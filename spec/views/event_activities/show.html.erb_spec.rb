require 'spec_helper'

describe "event_activities/show" do
  before(:each) do
    @event_activity = assign(:event_activity, stub_model(EventActivity,
      :name => "Name",
      :is_active => ""
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(//)
  end
end
