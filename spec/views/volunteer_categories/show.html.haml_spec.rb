require 'spec_helper'

describe "volunteer_categories/show.html.haml" do
  before(:each) do
    @volunteer_category = assign(:volunteer_category, stub_model(VolunteerCategory,
      :name => "Name",
      :description => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    rendered.should match(/Name/)
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    rendered.should match(/MyText/)
  end
end
