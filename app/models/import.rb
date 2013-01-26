# Used for the import stories wizard for Pivotal
# It is not persisted in the database so there's no table for this.
# It is useful to inherit from ActiveRecord::Base so we can use its methods
class Import
  include ActiveModel::AttributeMethods
  include ActiveModel::Conversion
  include ActiveModel::Validations
  extend ActiveModel::Naming

  validates :report_id, :presence => true
  validates :stories, :presence => true

  attr_accessor :id,            # => id for the model object. Id is not guaranteed to be unique and only exists for short-lived purpooses
    :report_id,                 # => Report that is importing the stories
    :step,                      # => Step currently being executed in the wizard. Below reference for each step.
    :api_token,                 # => API Token used for accessing Pivotal Tracker 
    :projects,                  # => List of projects that the user can access
    :project_id,                # => Project selected by user
    :iterations,                # => Iterations that the user can access
    :iteration_id,              # => Iteration selected by user
    :stories                    # => Stories that the user is importing to the report

  # Step can take the following values:
  # Step 1 is to input the API token that lets the system to get the projects
  # Step 2 is to input the Project so the system can get the iterations
  # Step 3 is to input the iteration so the system can get the stories
  # Step 4 is to import the stories

  def initialize()
    self.id = rand(1..1000)
  end

  def assign_attributes(attributes = {})
      attributes.each do |name, value|
        if self.respond_to?(name)
          send("#{name}=", value)
        end
      end
  end

  # Imports the selected stories into the report stored in this object
  # @param user Current user, used to access the report. If the user cannot access the report the method will fail
  def import_stories(user)

    if !self.valid?
      fail "Object must be valid to call this method"
    end

    report = user.reports.find(self.report_id)

    stories.each do |story|
      report.items.build(:item_type => "feature", :section => "delivered", :title => story["name"])
    end

    report.save!
  end

end