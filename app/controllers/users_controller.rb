class UsersController < ApplicationController
  def new
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    user = User.create(user_params)
    if user.save
      redirect_to "/users/#{user.id}"
    elsif params[:password] != params[:password_confirmation]
      flash[:alert] = 'Password and password confirmation must match.'
    else
      flash[:alert] = 'Please enter valid data.'
    end
  end

  def login_form

  end

  def login_user
    #require "pry"; binding.pry
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      redirect_to "/users/#{user.id}"
    else
      redirect_to '/login'
      flash[:alert] = 'User email or password not correct.'
    end
  end

    private
    def user_params
      params.permit(:name, :email, :password, :password_confirmation)
    end
end
