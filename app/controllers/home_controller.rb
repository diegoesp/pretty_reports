require 'pdfkit'

class HomeController < ApplicationController

  before_filter :authenticate_user!, :except => [:index]

  respond_to :json

  def index      
    if !user_signed_in?
      redirect_to welcome_page_path
    end

    @user = current_user
  end

  def pdfkit
  end

end
