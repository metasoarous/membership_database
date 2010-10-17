require 'spec_helper'

describe "renewals/index.html.haml" do
  before(:each) do
    assign(:renewals, [
      stub_model(Renewal,
        :payment_amount => 1.5,
        :barter => false,
        :notes => "MyText",
        :membership_id => 1
      ),
      stub_model(Renewal,
        :payment_amount => 1.5,
        :barter => false,
        :notes => "MyText",
        :membership_id => 1
      )
    ])
  end

  it "renders a list of renewals" do
    render
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => false.to_s, :count => 2
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
