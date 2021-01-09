require 'icalendar'
require 'openuri'

class ApiController < ApplicationController

  # before_action :check_logged_in, only: [:courses, :resources, :file, :files]
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
    if session[:username].nil? ||
       @@user_hash_map[session[:username]].nil? ||
       !@@user_hash_map[session[:username]].logged_in?
      raise StandardError, "current_spider not found"
    end
    return @@user_hash_map[session[:username]]
  end

  def file
    file_name = params[:name]
    file_url = params[:address]
    path = from_url_to_path(file_url)
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
        path = from_url_to_path(url)
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


  def save_ics_to_user
    # 把每个人的ics链接存放到模型中方便之后读取
  end

  def ics_analyze
    ics_url = get_ics_url
    if ics_url.nil?
      return false
    else
      cal = Icalendar.parse(open(ics_url).read).first
      return cal.events
    end
  end

  def login
    spider = Spider.new(params[:username], params[:password])
    if spider.login_sep == :success
      session[:username] = params[:username]
      @@user_hash_map[session[:username]] = spider
      user = User.find_by(email: params[:username])
      if user.nil?
        User.new_user(params[:username])
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
