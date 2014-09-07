require 'spec_helper'

describe "event_activities/new" do
  before(:each) do
    assign(:event_activity, stub_model(EventActivity,
      :name => "MyString",
      :is_active => ""
    ).as_new_record)
  end

  it "renders new event_activity form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => event_activities_path, :method => "post" do
      assert_select "input#event_activity_name", :name => "event_activity[name]"
      assert_select "input#event_activity_is_active", :name => "event_activity[is_active]"
    end
  end
end
