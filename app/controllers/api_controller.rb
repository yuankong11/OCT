require 'icalendar'
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
    if session[:username].nil?
      raise StandardError, "current_spider not found #1"
    elsif @@user_hash_map[session[:username]].nil?
      raise StandardError, "current_spider not found #2"
    elsif @@user_hash_map[session[:username]].logged_in?
      raise StandardError, "current_spider not found #3"
    end
    return @@user_hash_map[session[:username]]
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

  def resources
    render json: current_spider.get_resources
  end

  def timetable
    #puts current_user
    @user = User.find_by(email: current_user)
    # 把每个人的ics链接存放到模型中方便之后读取
    ics_url = current_spider.get_ics_url
    if !ics_url.nil?
      @user.update(timetable_ics: ics_url)
      cal = Icalendar.parse(open(ics_url).read).first #ics解析
      render json: cal.events
    end
  end

  def resources
    render json: find_resources(current_user)
  end

  def read_resources

  end

  def refresh_resources
    resources_update(current_user, @@user_hash_map[current_user].get_resources)
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
    @@user_hash_map.delete(session[:username])
    session[:username] = nil
    render json: "success"
  end
end
