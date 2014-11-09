class AddOtherToEvents < ActiveRecord::Migration
  def change
  	add_column :events, :other_games, :boolean
  	add_column :events, :other_types, :boolean
  end
end
