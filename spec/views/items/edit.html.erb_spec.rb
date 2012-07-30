require 'spec_helper'

describe "items/edit" do
  before(:each) do
    @item = assign(:item, stub_model(Item,
      :item_type => "MyString",
      :content => "MyText",
      :report => nil
    ))
  end

  it "renders the edit item form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => items_path(@item), :method => "post" do
      assert_select "input#item_item_type", :name => "item[item_type]"
      assert_select "textarea#item_content", :name => "item[content]"
      assert_select "input#item_report", :name => "item[report]"
    end
  end
end
