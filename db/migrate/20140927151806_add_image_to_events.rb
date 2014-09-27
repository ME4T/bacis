class AddImageToEvents < ActiveRecord::Migration
  def self.up
  	# add_attachment :events, :image
    change_table :events do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :events, :image
  end
end
