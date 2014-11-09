class AddSocialToEvents < ActiveRecord::Migration
  def change
    add_column :events, :facebook_url, :string
    add_column :events, :twitter_url, :string
  end
end
