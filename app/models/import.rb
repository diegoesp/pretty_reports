# Used for the import stories wizard for Pivotal
class Import
  
  attr_accessor :report_id,     # (int) Report that is going to import stories 
  :api_token,     # (string) API token that is going to be used to access pivotal
  :projects,      # (array) Projects that were fetched using the API token 
  :project_id,    # (string) Project selected
  :iterations,    # (array) Iterations that were fetched from the project
  :iteration,     # (string) Iteration selected
  :stories        # (array) Stories selected

  # Cleans state for the model except for the report id, that is conserved
  def clean
    self.api_token = nil
    self.projects = nil
    self.project_id = nil
    self.iterations = nil
    self.iteration = nil
    self.stories = nil
  end

  # Imports the selected stories into the report
  def import_into_report(user)
    report = user.reports.find(self.report_id)

    self.stories.each do |story|
      report.items.build(:item_type => "feature", :section => "delivered", :title => story)
    end

    report.save!
  end
end