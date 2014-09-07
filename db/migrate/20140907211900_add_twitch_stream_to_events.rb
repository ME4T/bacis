class AddTwitchStreamToEvents < ActiveRecord::Migration
  def change
    add_column :events, :twitch_stream, :string
  end
end
