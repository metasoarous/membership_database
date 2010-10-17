require "spec_helper"

describe RenewalsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/renewals" }.should route_to(:controller => "renewals", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/renewals/new" }.should route_to(:controller => "renewals", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/renewals/1" }.should route_to(:controller => "renewals", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/renewals/1/edit" }.should route_to(:controller => "renewals", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/renewals" }.should route_to(:controller => "renewals", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/renewals/1" }.should route_to(:controller => "renewals", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/renewals/1" }.should route_to(:controller => "renewals", :action => "destroy", :id => "1")
    end

  end
end
