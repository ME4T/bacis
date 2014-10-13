class AddTwitchFrameToEvents < ActiveRecord::Migration
  def change
    add_column :events, :twitch_frame, :string
  end
end
