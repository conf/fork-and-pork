class CreateMeals < ActiveRecord::Migration
  def change
    create_table :meals do |t|
      t.text :details
      t.integer :calories

      t.timestamps null: false
    end
  end
end
