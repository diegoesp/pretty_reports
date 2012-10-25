require 'net/http'

class UsersController < ApplicationController

  before_filter :authenticate_user!, :except => [:show]

  def edit
    @user = User.find(params[:id])

    if @user != current_user
      raise "user cannot edit other users unless it is an admin"  unless current_user.admin?
    end
  end

  def update
    @user = User.find(params[:id])
    
    if @user != current_user
      raise "user cannot edit other users unless it is an admin"  unless current_user.admin?
    end

    if params[:user][:password].blank?
      params[:user].delete("password")
      params[:user].delete("password_confirmation")
    end

    # Never update admin field. That is only managed by the backend
    params[:user].delete("admin")

    @user.attributes = params[:user]

    if @user.save
      flash.now[:notice] = "Your information has been updated succesfully"      
    else
      flash.now[:alert] = @user.errors.full_messages.join(" - ")
    end
    render "edit"
  end

end