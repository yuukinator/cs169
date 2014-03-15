require "spec_helper"

describe TeamsController do
  describe "routing" do

    it "routes to #index" do
      get("leagues/1/divisions/1/teams").should route_to("teams#index", :league_id => "1", :division_id => "1")
    end

    it "routes to #new" do
      get("leagues/1/divisions/1/teams/new").should route_to("teams#new", :league_id => "1", :division_id => "1")
    end

    it "routes to #show" do
      get("leagues/1/divisions/1/teams/1").should route_to("teams#show", :id => "1", :league_id => "1", :division_id => "1")
    end

    it "routes to #edit" do
      get("leagues/1/divisions/1/teams/1/edit").should route_to("teams#edit", :id => "1", :league_id => "1", :division_id => "1")
    end

    it "routes to #create" do
      post("leagues/1/divisions/1/teams").should route_to("teams#create", :league_id => "1", :division_id => "1")
    end

    it "routes to #update" do
      put("leagues/1/divisions/1/teams/1").should route_to("teams#update", :id => "1", :league_id => "1", :division_id => "1")
    end

    it "routes to #destroy" do
      delete("leagues/1/divisions/1/teams/1").should route_to("teams#destroy", :id => "1", :league_id => "1", :division_id => "1")
    end

  end
end
