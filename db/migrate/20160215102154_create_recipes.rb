class CreateRecipes < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
      t.string :name
      t.string :meal
      t.text :instructions
      t.string :picture_url

      t.timestamps null: false
    end
  end
end
