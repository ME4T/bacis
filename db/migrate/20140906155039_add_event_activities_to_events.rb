class AddEventActivitiesToEvents < ActiveRecord::Migration
  def change
  	add_column :events, :event_activities, :string
  end
end
