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

    @user.attributes = params[:user].except(:id, :admin)

    if @user.save
      flash[:notice] = "Your information has been updated succesfully"      
    else
      flash[:alert] = @user.errors.full_messages.join(" - ")
    end
    render "edit"
  end

end