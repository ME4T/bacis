require 'spec_helper'

describe "event_activities/edit" do
  before(:each) do
    @event_activity = assign(:event_activity, stub_model(EventActivity,
      :name => "MyString",
      :is_active => ""
    ))
  end

  it "renders the edit event_activity form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => event_activities_path(@event_activity), :method => "post" do
      assert_select "input#event_activity_name", :name => "event_activity[name]"
      assert_select "input#event_activity_is_active", :name => "event_activity[is_active]"
    end
  end
end
