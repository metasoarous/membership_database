require 'spec_helper'

describe "volunteer_categories/index.html.haml" do
  before(:each) do
    assign(:volunteer_categories, [
      stub_model(VolunteerCategory,
        :name => "Name",
        :description => "MyText"
      ),
      stub_model(VolunteerCategory,
        :name => "Name",
        :description => "MyText"
      )
    ])
  end

  it "renders a list of volunteer_categories" do
    render
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
