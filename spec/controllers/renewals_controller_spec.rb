require 'spec_helper'

describe RenewalsController do

  def mock_renewal(stubs={})
    (@mock_renewal ||= mock_model(Renewal).as_null_object).tap do |renewal|
      renewal.stub(stubs) unless stubs.empty?
    end
  end

  describe "GET index" do
    it "assigns all renewals as @renewals" do
      Renewal.stub(:all) { [mock_renewal] }
      get :index
      assigns(:renewals).should eq([mock_renewal])
    end
  end

  describe "GET show" do
    it "assigns the requested renewal as @renewal" do
      Renewal.stub(:find).with("37") { mock_renewal }
      get :show, :id => "37"
      assigns(:renewal).should be(mock_renewal)
    end
  end

  describe "GET new" do
    it "assigns a new renewal as @renewal" do
      Renewal.stub(:new) { mock_renewal }
      get :new
      assigns(:renewal).should be(mock_renewal)
    end
  end

  describe "GET edit" do
    it "assigns the requested renewal as @renewal" do
      Renewal.stub(:find).with("37") { mock_renewal }
      get :edit, :id => "37"
      assigns(:renewal).should be(mock_renewal)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created renewal as @renewal" do
        Renewal.stub(:new).with({'these' => 'params'}) { mock_renewal(:save => true) }
        post :create, :renewal => {'these' => 'params'}
        assigns(:renewal).should be(mock_renewal)
      end

      it "redirects to the created renewal" do
        Renewal.stub(:new) { mock_renewal(:save => true) }
        post :create, :renewal => {}
        response.should redirect_to(renewal_url(mock_renewal))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved renewal as @renewal" do
        Renewal.stub(:new).with({'these' => 'params'}) { mock_renewal(:save => false) }
        post :create, :renewal => {'these' => 'params'}
        assigns(:renewal).should be(mock_renewal)
      end

      it "re-renders the 'new' template" do
        Renewal.stub(:new) { mock_renewal(:save => false) }
        post :create, :renewal => {}
        response.should render_template("new")
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested renewal" do
        Renewal.should_receive(:find).with("37") { mock_renewal }
        mock_renewal.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :renewal => {'these' => 'params'}
      end

      it "assigns the requested renewal as @renewal" do
        Renewal.stub(:find) { mock_renewal(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:renewal).should be(mock_renewal)
      end

      it "redirects to the renewal" do
        Renewal.stub(:find) { mock_renewal(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(renewal_url(mock_renewal))
      end
    end

    describe "with invalid params" do
      it "assigns the renewal as @renewal" do
        Renewal.stub(:find) { mock_renewal(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:renewal).should be(mock_renewal)
      end

      it "re-renders the 'edit' template" do
        Renewal.stub(:find) { mock_renewal(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested renewal" do
      Renewal.should_receive(:find).with("37") { mock_renewal }
      mock_renewal.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the renewals list" do
      Renewal.stub(:find) { mock_renewal }
      delete :destroy, :id => "1"
      response.should redirect_to(renewals_url)
    end
  end

end
