require 'spec_helper'

describe "renewals/show.html.haml" do
  before(:each) do
    @renewal = assign(:renewal, stub_model(Renewal,
      :payment_amount => 1.5,
      :barter => false,
      :notes => "MyText",
      :membership_id => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    rendered.should match(/1.5/)
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    rendered.should match(/false/)
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    rendered.should match(/MyText/)
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    rendered.should match(/1/)
  end
end
