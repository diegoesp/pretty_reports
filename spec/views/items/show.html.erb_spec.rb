require 'spec_helper'

describe "items/show" do
  before(:each) do
    @item = assign(:item, stub_model(Item,
      :item_type => "Item Type",
      :content => "MyText",
      :report => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Item Type/)
    rendered.should match(/MyText/)
    rendered.should match(//)
  end
end
