class AddCaloriesToUser < ActiveRecord::Migration
  def change
    add_column :users, :calories, :integer
  end
end
