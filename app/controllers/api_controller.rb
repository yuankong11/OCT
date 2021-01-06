class ApiController < ApplicationController
  protect_from_forgery :only => [:login]
  before_action :check_logged_in, only: [:courses, :resources, :file]

  @@map = Hash.new

  include ApiHelper

  def function_dispatch
    send(params[:function])
  end

  def module_function_dispatch
    t = eval("#{params[:module]}.new")
    t.send(params[:function])
  end

  def check_logged_in
    if @@map[session[:username]] && @@map[session[:username]].logged_in?
    else
      raise StandardError
    end
  end

  def file
    file_name = params[:name]
    file_url = params[:address]
    path = "./app/assets/resources/" + file_url
    @@map[session[:username]].download_file(file_url, path)
    send_file(path, :filename => file_name)
  end

  def courses
    render json: @@map[session[:username]].get_courses
  end

  def resources
    render json: @@map[session[:username]].get_resources
  end

  def login
    spider = Spider.new(params[:username], params[:password])
    if spider.login_sep == :success
      session[:username] = params[:username]
      @@map[session[:username]] = spider
      render json: "success"
    else
      render json: "fail"
    end
  end

  def logout
    puts session[:username]
    if session[:username].nil?
      render json: "not_login"
    else
      if !@@map[session[:username]].nil?
        @@map[session[:username]].quit
        @@map.delete(session[:username])
        session[:username] = nil
        render json: "success"
      else
        render json: "fail"
      end
    end
  end

  # def remember(user)
  #   user.remember
  #   cookies.permanent.signed[:user_id] = user.id
  #   cookies.permanent[:remember_token] = user.remember_token
  # end

  # def current_user
  #   return @current_user if !@current_user.nil?
  #   if session[:user_id]
  #       @current_user = User.find_by(id: session[:user_id])
  #       return @current_user
  #   end
  #   if cookies.signed[:user_id]
  #       @current_user = User.find_by(id: cookies.signed[:user_id])
  #       return nil if @current_user.nil?
  #       if @current_user.authenticated?(cookies[:remember_token])
  #           log_in @current_user
  #       else
  #           @current_user = nil
  #       end
  #       return @current_user
  #   end
  # end

  # def forget(user)
  #   user.forget
  #   cookies.delete(:user_id)
  #   cookies.delete(:remember_token)
  # end

  # def log_out
  #   forget(current_user)
  #   session.delete(:user_id)
  #   @current_user = nil
  # end

  # def log_in(user)
  #   session[:user_id] = user.id
  # end

  # def logged_in?
  #   !current_user.nil?
  # end

  # def new
  #   redirect_to current_user if logged_in?
  # end

  # def create
  #   user = User.find_by_email(params[:session][:email])
  #   if user && user.authenticate(params[:session][:password])
  #     log_in user
  #     if params[:session][:remember_me] == '1'
  #       remember(user)
  #     else
  #       forget(user)
  #     end
  #     redirect_to user
  #   else
  #     flash.now[:danger] = "登录失败，用户名/密码错误！"
  #     render :new
  #   end
  # end

  # def destroy
  #   log_out if logged_in?
  #   redirect_to :login
  # end

  # def remember
  #   @remember_token = User.new_token
  #   self.remember_digest = User.digest(@remember_token)
  #   save
  # end

  # def authenticated?(remember_token)
  #   return false if self.remember_digest.nil?
  #   BCrypt::Password.new(self.remember_digest).is_password?(remember_token)
  # end

  # def forget
  #   update_attribute(:remember_digest, nil)
  # end

  # def digest(string)
  #   cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
  #                                                 BCrypt::Engine.cost
  #   BCrypt::Password.create(string, cost: cost)
  # end

  # def new_token
  #   SecureRandom.urlsafe_base64
  # end
end
