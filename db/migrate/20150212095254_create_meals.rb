class CreateMeals < ActiveRecord::Migration
  def change
    create_table :meals do |t|
      t.text :details, null: false
      t.integer :calories, null: false
      t.references :user, null: false, index: true

      t.timestamps null: false
    end

    add_foreign_key :meals, :users
  end
end
