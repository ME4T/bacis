class AddAgeToEvents < ActiveRecord::Migration
  def change
    add_column :events, :age, :integer
  end
end
