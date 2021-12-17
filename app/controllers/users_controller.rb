class UsersController < ApplicationController
  before_action :require_user, only: :show

  def new
    @user = User.new
  end

  def show
    @user = User.find(session[:user_id])
  end

  def create
    user = User.new(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to '/dashboard'
    elsif params[:password] != params[:password_confirmation]
      redirect_to '/register'
      flash[:alert] = 'Password and password confirmation must match.'
    else
      redirect_to '/register'
      flash[:alert] = 'Please enter valid data.'
    end
  end

    private
    def user_params
      params.permit(:name, :email, :password, :password_confirmation)
    end

    def require_user
      if !session[:user_id]
        flash[:alert] = 'Must be a registered user and logged in to visit user dashboard.'
        redirect_to '/'
      end 
    end
end
