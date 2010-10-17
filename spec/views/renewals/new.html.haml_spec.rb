require 'spec_helper'

describe "renewals/new.html.haml" do
  before(:each) do
    assign(:renewal, stub_model(Renewal,
      :payment_amount => 1.5,
      :barter => false,
      :notes => "MyText",
      :membership_id => 1
    ).as_new_record)
  end

  it "renders new renewal form" do
    render

    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "form", :action => renewals_path, :method => "post" do
      assert_select "input#renewal_payment_amount", :name => "renewal[payment_amount]"
      assert_select "input#renewal_barter", :name => "renewal[barter]"
      assert_select "textarea#renewal_notes", :name => "renewal[notes]"
      assert_select "input#renewal_membership_id", :name => "renewal[membership_id]"
    end
  end
end
