class ImportsController < ApplicationController

  before_filter :authenticate_user!

  respond_to :json

  # Displays a new instance
  def new
  end

  # Creates a new instance in database
  # Receives and returns a parameterized Import object
  def create
    import = Import.new
    import.assign_attributes(params)

    if import.api_token.blank? then fail "Must supply api_token param" end
    
    PivotalTracker::Client.token = import.api_token
    import.projects = PivotalTracker::Project.all

    render :json => import
  end
 
  # The update containts all the logic for the one-screen wizard
  # Receives and return a parameterized Import object
  def update
  	import = Import.new
    import.assign_attributes(params)

  	case import.step
    when 1
      if import.api_token.blank? then fail "Must supply api_token parameter" end

  		PivotalTracker::Client.token = import.api_token
  		import.projects = PivotalTracker::Project.all
    when 2
      if import.project_id.blank? then fail "Must supply project_id parameter" end

      PivotalTracker::Client.token = import.api_token
      project = PivotalTracker::Project.find(import.project_id.to_i)
      import.iterations = project.iterations.all
    when 3
      if import.iteration_id.blank? then fail "Must supply iteration_id parameter" end

      PivotalTracker::Client.token = import.api_token
      project = PivotalTracker::Project.find(import.project_id.to_i)
      import.stories = project.iterations.find(import.iteration_id.to_i).stories
    when 4
      # Last step => Import the stories
      if import.stories.blank? then fail "Stories must be supplied inside the import object" end
      import.import_stories(current_user)
    else
      fail "Step can be only 1, 2, 3 or 4"
    end
   
    render :json => import
  end

end