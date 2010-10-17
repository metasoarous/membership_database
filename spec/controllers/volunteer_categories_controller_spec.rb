require 'spec_helper'

describe VolunteerCategoriesController do

  def mock_volunteer_category(stubs={})
    (@mock_volunteer_category ||= mock_model(VolunteerCategory).as_null_object).tap do |volunteer_category|
      volunteer_category.stub(stubs) unless stubs.empty?
    end
  end

  describe "GET index" do
    it "assigns all volunteer_categories as @volunteer_categories" do
      VolunteerCategory.stub(:all) { [mock_volunteer_category] }
      get :index
      assigns(:volunteer_categories).should eq([mock_volunteer_category])
    end
  end

  describe "GET show" do
    it "assigns the requested volunteer_category as @volunteer_category" do
      VolunteerCategory.stub(:find).with("37") { mock_volunteer_category }
      get :show, :id => "37"
      assigns(:volunteer_category).should be(mock_volunteer_category)
    end
  end

  describe "GET new" do
    it "assigns a new volunteer_category as @volunteer_category" do
      VolunteerCategory.stub(:new) { mock_volunteer_category }
      get :new
      assigns(:volunteer_category).should be(mock_volunteer_category)
    end
  end

  describe "GET edit" do
    it "assigns the requested volunteer_category as @volunteer_category" do
      VolunteerCategory.stub(:find).with("37") { mock_volunteer_category }
      get :edit, :id => "37"
      assigns(:volunteer_category).should be(mock_volunteer_category)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created volunteer_category as @volunteer_category" do
        VolunteerCategory.stub(:new).with({'these' => 'params'}) { mock_volunteer_category(:save => true) }
        post :create, :volunteer_category => {'these' => 'params'}
        assigns(:volunteer_category).should be(mock_volunteer_category)
      end

      it "redirects to the created volunteer_category" do
        VolunteerCategory.stub(:new) { mock_volunteer_category(:save => true) }
        post :create, :volunteer_category => {}
        response.should redirect_to(volunteer_category_url(mock_volunteer_category))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved volunteer_category as @volunteer_category" do
        VolunteerCategory.stub(:new).with({'these' => 'params'}) { mock_volunteer_category(:save => false) }
        post :create, :volunteer_category => {'these' => 'params'}
        assigns(:volunteer_category).should be(mock_volunteer_category)
      end

      it "re-renders the 'new' template" do
        VolunteerCategory.stub(:new) { mock_volunteer_category(:save => false) }
        post :create, :volunteer_category => {}
        response.should render_template("new")
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested volunteer_category" do
        VolunteerCategory.should_receive(:find).with("37") { mock_volunteer_category }
        mock_volunteer_category.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :volunteer_category => {'these' => 'params'}
      end

      it "assigns the requested volunteer_category as @volunteer_category" do
        VolunteerCategory.stub(:find) { mock_volunteer_category(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:volunteer_category).should be(mock_volunteer_category)
      end

      it "redirects to the volunteer_category" do
        VolunteerCategory.stub(:find) { mock_volunteer_category(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(volunteer_category_url(mock_volunteer_category))
      end
    end

    describe "with invalid params" do
      it "assigns the volunteer_category as @volunteer_category" do
        VolunteerCategory.stub(:find) { mock_volunteer_category(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:volunteer_category).should be(mock_volunteer_category)
      end

      it "re-renders the 'edit' template" do
        VolunteerCategory.stub(:find) { mock_volunteer_category(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested volunteer_category" do
      VolunteerCategory.should_receive(:find).with("37") { mock_volunteer_category }
      mock_volunteer_category.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the volunteer_categories list" do
      VolunteerCategory.stub(:find) { mock_volunteer_category }
      delete :destroy, :id => "1"
      response.should redirect_to(volunteer_categories_url)
    end
  end

end
