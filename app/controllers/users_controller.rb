class UsersController < ApplicationController

  def welcome
  end


  def signup
    @user = User.new
  end

  def login
  end

  def create
    @user = User.new(user_params)
    if @user.save
      cookies.permanent[:token] = @user.token
      redirect_to :root
    else
      render :signup
    end
  end

  def logout
    cookies.delete(:token)
    redirect_to root_url
  end

  def create_login_session
    user = User.find_by_name(params[:name])
    if user && user.authenticate(params[:password])
      cookies.permanent[:token] = user.token
      if user.role == '老师'
        redirect_to '/teacher/index'
      else
        redirect_to '/student/index'
      end
    else
      redirect_to :login
    end
  end

  def download
    io = File.open(params[:path])
    io.binmode
    send_data(io.read, :filename => params[:name], :disposition => 'attachment')
  end

  private
  def user_params
    params.require(:user).permit!
  end
end
