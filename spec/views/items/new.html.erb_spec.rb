require 'spec_helper'

describe "items/new" do
  before(:each) do
    assign(:item, stub_model(Item,
      :item_type => "MyString",
      :content => "MyText",
      :report => nil
    ).as_new_record)
  end

  it "renders new item form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => items_path, :method => "post" do
      assert_select "input#item_item_type", :name => "item[item_type]"
      assert_select "textarea#item_content", :name => "item[content]"
      assert_select "input#item_report", :name => "item[report]"
    end
  end
end
