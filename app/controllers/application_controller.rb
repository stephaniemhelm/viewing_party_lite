# frozen_string_literal: true

class ApplicationController < ActionController::Base
  def welcome
    @users = User.all
  end

  # def current_user
  #   User.find(session[:user_id])
  # end
end
