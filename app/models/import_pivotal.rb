# Used for the import stories wizard for Pivotal
class ImportPivotal
  attr_accessor :report_id, :api_token, :project_id, :stories

  # Imports the selected stories into the report
  def import_into_report(user)
    report = user.reports.find(self.report_id)

    self.stories.each do |story|
      report.items.build(:item_type => "feature", :section => "delivered", :title => story)
    end

    report.save!

    report
  end
end