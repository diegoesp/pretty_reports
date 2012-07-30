require 'spec_helper'

describe "reports/index" do
  before(:each) do
    assign(:reports, [
      stub_model(Report,
        :report_type => "Report Type",
        :content => "MyText"
      ),
      stub_model(Report,
        :report_type => "Report Type",
        :content => "MyText"
      )
    ])
  end

  it "renders a list of reports" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Report Type".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
