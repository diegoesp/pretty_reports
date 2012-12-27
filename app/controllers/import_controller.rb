class ImportController < ApplicationController

  before_filter :authenticate_user!

  respond_to :json

  def new
  end

  def create
  	import =  Import.new
  	import.report_id = params[:report_id]
    import.api_token = params[:api_token]
  	session[:import] = import

    render :json => import
  end
 
  def update
  	import = session[:import]
  	
  	if params[:api_token] != import.api_token
		  # Must refetch all depending information
  		import.clean

  		import.api_token = params[:api_token]
  
  		PivotalTracker::Client.token = import.api_token;
  		import.projects = PivotalTracker::Project.all; 

  		render :json => import
  	end

  end

end
