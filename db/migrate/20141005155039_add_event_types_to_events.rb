class AddEventTypesToEvents < ActiveRecord::Migration
  def change
  	add_column :events, :event_types, :string
  end
end
