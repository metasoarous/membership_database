require 'spec_helper'

describe "memberships/new.html.haml" do
  before(:each) do
    assign(:membership, stub_model(Membership,
      :mailing_address => "MyString",
      :home_address => "MyString",
      :phone => "MyString",
      :email => "MyString",
      :number => 1,
      :city => "MyString",
      :state => "MyString",
      :state => "MyString",
      :zip => 1,
      :best_contact => "MyString",
      :volunteer_skills => "MyText"
    ).as_new_record)
  end

  it "renders new membership form" do
    render

    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "form", :action => memberships_path, :method => "post" do
      assert_select "input#membership_mailing_address", :name => "membership[mailing_address]"
      assert_select "input#membership_home_address", :name => "membership[home_address]"
      assert_select "input#membership_phone", :name => "membership[phone]"
      assert_select "input#membership_email", :name => "membership[email]"
      assert_select "input#membership_number", :name => "membership[number]"
      assert_select "input#membership_city", :name => "membership[city]"
      assert_select "input#membership_state", :name => "membership[state]"
      assert_select "input#membership_state", :name => "membership[state]"
      assert_select "input#membership_zip", :name => "membership[zip]"
      assert_select "input#membership_best_contact", :name => "membership[best_contact]"
      assert_select "textarea#membership_volunteer_skills", :name => "membership[volunteer_skills]"
    end
  end
end
