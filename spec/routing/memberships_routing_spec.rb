require "spec_helper"

describe MembershipsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/memberships" }.should route_to(:controller => "memberships", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/memberships/new" }.should route_to(:controller => "memberships", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/memberships/1" }.should route_to(:controller => "memberships", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/memberships/1/edit" }.should route_to(:controller => "memberships", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/memberships" }.should route_to(:controller => "memberships", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/memberships/1" }.should route_to(:controller => "memberships", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/memberships/1" }.should route_to(:controller => "memberships", :action => "destroy", :id => "1")
    end

  end
end
