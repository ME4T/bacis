class AddTwitterSearchToEvents < ActiveRecord::Migration
  def change
  	add_column :events, :twitter_search, :string

  end
end
