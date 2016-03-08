class CreateShoppingListItems < ActiveRecord::Migration
  def change
    create_table :shopping_list_items do |t|
      t.string :name
      t.boolean :bought, :default => false
      t.string :list
      t.timestamps null: false
    end
  end
end
