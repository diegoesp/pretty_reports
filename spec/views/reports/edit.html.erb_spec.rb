require 'spec_helper'

describe "reports/edit" do
  before(:each) do
    @report = assign(:report, stub_model(Report,
      :report_type => "MyString",
      :content => "MyText"
    ))
  end

  it "renders the edit report form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => reports_path(@report), :method => "post" do
      assert_select "input#report_report_type", :name => "report[report_type]"
      assert_select "textarea#report_content", :name => "report[content]"
    end
  end
end
