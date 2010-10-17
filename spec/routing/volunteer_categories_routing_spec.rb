require "spec_helper"

describe VolunteerCategoriesController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/volunteer_categories" }.should route_to(:controller => "volunteer_categories", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/volunteer_categories/new" }.should route_to(:controller => "volunteer_categories", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/volunteer_categories/1" }.should route_to(:controller => "volunteer_categories", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/volunteer_categories/1/edit" }.should route_to(:controller => "volunteer_categories", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/volunteer_categories" }.should route_to(:controller => "volunteer_categories", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/volunteer_categories/1" }.should route_to(:controller => "volunteer_categories", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/volunteer_categories/1" }.should route_to(:controller => "volunteer_categories", :action => "destroy", :id => "1")
    end

  end
end
