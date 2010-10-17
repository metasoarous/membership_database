require 'spec_helper'

describe "renewals/edit.html.haml" do
  before(:each) do
    @renewal = assign(:renewal, stub_model(Renewal,
      :new_record? => false,
      :payment_amount => 1.5,
      :barter => false,
      :notes => "MyText",
      :membership_id => 1
    ))
  end

  it "renders the edit renewal form" do
    render

    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "form", :action => renewal_path(@renewal), :method => "post" do
      assert_select "input#renewal_payment_amount", :name => "renewal[payment_amount]"
      assert_select "input#renewal_barter", :name => "renewal[barter]"
      assert_select "textarea#renewal_notes", :name => "renewal[notes]"
      assert_select "input#renewal_membership_id", :name => "renewal[membership_id]"
    end
  end
end
