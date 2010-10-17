require 'spec_helper'

describe "members/new.html.haml" do
  before(:each) do
    assign(:member, stub_model(Member,
      :membership_id => 1,
      :first_name => "MyString",
      :last_name => "MyString",
      :phone => "MyString",
      :email => "MyString",
      :notes => "MyText"
    ).as_new_record)
  end

  it "renders new member form" do
    render

    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "form", :action => members_path, :method => "post" do
      assert_select "input#member_membership_id", :name => "member[membership_id]"
      assert_select "input#member_first_name", :name => "member[first_name]"
      assert_select "input#member_last_name", :name => "member[last_name]"
      assert_select "input#member_phone", :name => "member[phone]"
      assert_select "input#member_email", :name => "member[email]"
      assert_select "textarea#member_notes", :name => "member[notes]"
    end
  end
end
