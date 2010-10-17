require 'spec_helper'

describe "memberships/index.html.haml" do
  before(:each) do
    assign(:memberships, [
      stub_model(Membership,
        :mailing_address => "Mailing Address",
        :home_address => "Home Address",
        :phone => "Phone",
        :email => "Email",
        :number => 1,
        :city => "City",
        :state => "State",
        :state => "State",
        :zip => 1,
        :best_contact => "Best Contact",
        :volunteer_skills => "MyText"
      ),
      stub_model(Membership,
        :mailing_address => "Mailing Address",
        :home_address => "Home Address",
        :phone => "Phone",
        :email => "Email",
        :number => 1,
        :city => "City",
        :state => "State",
        :state => "State",
        :zip => 1,
        :best_contact => "Best Contact",
        :volunteer_skills => "MyText"
      )
    ])
  end

  it "renders a list of memberships" do
    render
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Mailing Address".to_s, :count => 2
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Home Address".to_s, :count => 2
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Phone".to_s, :count => 2
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => "City".to_s, :count => 2
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => "State".to_s, :count => 2
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => "State".to_s, :count => 2
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Best Contact".to_s, :count => 2
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
