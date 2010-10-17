require 'spec_helper'

describe "volunteer_categories/new.html.haml" do
  before(:each) do
    assign(:volunteer_category, stub_model(VolunteerCategory,
      :name => "MyString",
      :description => "MyText"
    ).as_new_record)
  end

  it "renders new volunteer_category form" do
    render

    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "form", :action => volunteer_categories_path, :method => "post" do
      assert_select "input#volunteer_category_name", :name => "volunteer_category[name]"
      assert_select "textarea#volunteer_category_description", :name => "volunteer_category[description]"
    end
  end
end
