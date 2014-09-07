require "spec_helper"

describe EventActivitiesController do
  describe "routing" do

    it "routes to #index" do
      get("/event_activities").should route_to("event_activities#index")
    end

    it "routes to #new" do
      get("/event_activities/new").should route_to("event_activities#new")
    end

    it "routes to #show" do
      get("/event_activities/1").should route_to("event_activities#show", :id => "1")
    end

    it "routes to #edit" do
      get("/event_activities/1/edit").should route_to("event_activities#edit", :id => "1")
    end

    it "routes to #create" do
      post("/event_activities").should route_to("event_activities#create")
    end

    it "routes to #update" do
      put("/event_activities/1").should route_to("event_activities#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/event_activities/1").should route_to("event_activities#destroy", :id => "1")
    end

  end
end
