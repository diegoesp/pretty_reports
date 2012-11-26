require 'net/http'

class ImportPivotalWizardController < ApplicationController
  include Wicked::Wizard

  before_filter :authenticate_user!

  steps :set_api_token, :select_project, :add_stories, :import_into_report

  def new
    import_pivotal = ImportPivotal.new
    import_pivotal.report_id = params[:report_id]

    session[:import_pivotal] = import_pivotal

    redirect_to wizard_path(:set_api_token)
  end

  def show

    @import_pivotal = session[:import_pivotal]

    unless @import_pivotal.api_token.blank?
      PivotalTracker::Client.token = @import_pivotal.api_token
    end

    case step
    when :select_project
      begin
        @projects = PivotalTracker::Project.all
      rescue
        flash[:alert] = "API token appears to be not valid. Please verify the code"
        redirect_to previous_wizard_path
        return
      end
    when :add_stories
      @stories = PivotalTracker::Project.find(@import_pivotal.project_id.to_i).stories.all
    end

    render_wizard
  end

  def update
    import_pivotal = session[:import_pivotal]

    case step
    when :set_api_token
      import_pivotal.api_token = params[:pivotal_api_token]
      if import_pivotal.api_token.blank?
        flash[:alert] = "The API token is mandatory so I can import your Pivotal stories"
        redirect_to wizard_path
        return
      end
    when :select_project
      import_pivotal.project_id = params[:project_id]
      if import_pivotal.project_id.blank?
        flash[:alert] = "A project is mandatory so I can show you its stories for import"
        redirect_to wizard_path
        return
      end
    when :add_stories
      import_pivotal.stories = params[:stories]
      if import_pivotal.stories.blank?
        flash[:alert] = "You must select at least one story"
        redirect_to wizard_path
        return
      end
    when :import_into_report
      report = import_pivotal.import_into_report(current_user)
      redirect_to edit_report_url(report)
      return
    end

    redirect_to next_wizard_path
  end

end