require 'spec_helper'

describe MembershipsController do

  def mock_membership(stubs={})
    (@mock_membership ||= mock_model(Membership).as_null_object).tap do |membership|
      membership.stub(stubs) unless stubs.empty?
    end
  end

  describe "GET show" do
    it "assigns the requested membership as @membership" do
      Membership.stub(:find).with("37") { mock_membership }
      get :show, :id => "37"
      assigns(:membership).should be(mock_membership)
    end
  end

  describe "GET new" do
    it "assigns a new membership as @membership" do
      Membership.stub(:new) { mock_membership }
      get :new
      assigns(:membership).should be(mock_membership)
    end
  end

  describe "GET edit" do
    it "assigns the requested membership as @membership" do
      Membership.stub(:find).with("37") { mock_membership }
      get :edit, :id => "37"
      assigns(:membership).should be(mock_membership)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created membership as @membership" do
        Membership.stub(:new).with({'these' => 'params'}) { mock_membership(:save => true) }
        post :create, :membership => {'these' => 'params'}
        assigns(:membership).should be(mock_membership)
      end

      it "redirects to the created membership" do
        Membership.stub(:new) { mock_membership(:save => true) }
        post :create, :membership => {}
        response.should redirect_to(membership_url(mock_membership))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved membership as @membership" do
        Membership.stub(:new).with({'these' => 'params'}) { mock_membership(:save => false) }
        post :create, :membership => {'these' => 'params'}
        assigns(:membership).should be(mock_membership)
      end

      it "re-renders the 'new' template" do
        Membership.stub(:new) { mock_membership(:save => false) }
        post :create, :membership => {}
        response.should render_template("new")
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested membership" do
        Membership.should_receive(:find).with("37") { mock_membership }
        mock_membership.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :membership => {'these' => 'params'}
      end

      it "assigns the requested membership as @membership" do
        Membership.stub(:find) { mock_membership(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:membership).should be(mock_membership)
      end

      it "redirects to the membership" do
        Membership.stub(:find) { mock_membership(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(membership_url(mock_membership))
      end
    end

    describe "with invalid params" do
      it "assigns the membership as @membership" do
        Membership.stub(:find) { mock_membership(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:membership).should be(mock_membership)
      end

      it "re-renders the 'edit' template" do
        Membership.stub(:find) { mock_membership(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested membership" do
      Membership.should_receive(:find).with("37") { mock_membership }
      mock_membership.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the memberships list" do
      Membership.stub(:find) { mock_membership }
      delete :destroy, :id => "1"
      response.should redirect_to(memberships_url)
    end
  end

end
