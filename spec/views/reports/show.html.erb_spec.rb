require 'spec_helper'

describe "reports/show" do
  before(:each) do
    @report = assign(:report, stub_model(Report,
      :report_type => "Report Type",
      :content => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Report Type/)
    rendered.should match(/MyText/)
  end
end
