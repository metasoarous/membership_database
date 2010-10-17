require 'spec_helper'

describe "volunteer_categories/edit.html.haml" do
  before(:each) do
    @volunteer_category = assign(:volunteer_category, stub_model(VolunteerCategory,
      :new_record? => false,
      :name => "MyString",
      :description => "MyText"
    ))
  end

  it "renders the edit volunteer_category form" do
    render

    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "form", :action => volunteer_category_path(@volunteer_category), :method => "post" do
      assert_select "input#volunteer_category_name", :name => "volunteer_category[name]"
      assert_select "textarea#volunteer_category_description", :name => "volunteer_category[description]"
    end
  end
end
