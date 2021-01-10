class ApiController < ApplicationController
  protect_from_forgery :only => [:login]

  @@user_hash_map = Hash.new
  include ApiHelper

  def function_dispatch
    send(params[:function])
  end

  # def module_function_dispatch
  #   t = eval("#{params[:module]}.new")
  #   t.send(params[:function])
  # end

  def current_spider
    if current_user.nil?
      raise StandardError, "current_spider not found #1"
    elsif @@user_hash_map[current_user].nil?
      raise StandardError, "current_spider not found #2"
    elsif !@@user_hash_map[current_user].logged_in?
      raise StandardError, "current_spider not found #3"
    end
    return @@user_hash_map[current_user]
  end

  def current_user
    session[:username]
  end

  def file
    file_name = params[:name]
    file_url = params[:address]
    path = FileRecord.path_to_full_path(FileRecord.address_to_path(file_url))
    current_spider.download_file(file_url, path)
    send_file(path, :filename => file_name)
  end

  def files
    require 'zip'
    urls = params[:address]
    spider = current_spider
    stream = Zip::OutputStream.write_buffer do |zos|
      file_objs = urls.each do |url|
        name = URI.decode(url.scan(/\/([^\/]*?)$/)[0][0])
        path = FileRecord.path_to_full_path(FileRecord.address_to_path(url))
        spider.download_file(url, path)
        zos.put_next_entry(name)
        zos.print(File.read(path))
      end
    end
    stream.rewind
    data = stream.read
    send_data(data, :filename => "tmp.zip", :type => "application/zip", :disposition => "attachment")
  end

  def courses
    render json: current_spider.get_courses
  end

  def analyze_timetable
    #puts current_user
    # ISO格式时间：Time.strptime('20190522T11:34:50', "%Y%m%dT%H:%M:%S")
    # yyyy/mm/dd hh:mm:ss格式：Time.strptime('2019-05-22 11:34:50', "%Y-%m-%d %H:%M:%S")
    #day_start = Time.strptime(params[:day_start],"%Y%m%dT%H:%M:%S")# 需要解析的events范围
    #day_end = Time.strptime(params[:day_end],"%Y%m%dT%H:%M:%S")
    user = User.find_by(email: current_user)
    ics_url = ""
    # 把每个人的ics链接存放到模型中方便之后读取
    if !available_ics_url(user[:timetable_ics])
      ics_url = current_spider.get_ics_url
      user.update(timetable_ics: ics_url)
    else
      ics_url = user[:timetable_ics]
    #TODO: 判断用户手动更新ics_url时要同步更新
    end
    cal = Icalendar::Calendar.parse(URI.open(ics_url).read).first #ics解析

    timetable = cal.events
    #.select{|event| event.dtstart > day_start && event.dtstart+event.duration.seconds < day_end} # 筛选在范围内的事件
    .map do |event|{
        "uid" => event.uid,
        "name" => event.summary,
        "start" => event.dtstart,
        "end" => event.dtstart + event.duration.seconds,
        "duration" => event.duration.seconds,
        "location" => event.location,
        "timed" => true}
    end
    #}
    return timetable
  end

  def timetable
    render json: analyze_timetable
  end

  def resources
    render json: find_resources(current_user)
  end

  def read_resources

  end

  def refresh_resources
    resources_update(current_user, current_spider.get_resources)
    resources
  end

  def login
    username = params[:username]
    password = params[:password]

    spider = Spider.new(username, password)
    if spider.login_sep == :success
      session[:username] = username
      @@user_hash_map[username] = spider
      user = User.find_by(email: username)
      if user.nil?
        User.new_user(username)
      end
      render json: "success"
    else
      render json: "fail"
    end
  end

  def logout
    current_spider.quit
    @@user_hash_map.delete(current_user)
    session[:username] = nil
    render json: "success"
  end
end
