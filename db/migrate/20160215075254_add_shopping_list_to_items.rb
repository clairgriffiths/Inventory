class AddShoppingListToItems < ActiveRecord::Migration
  def change
    add_column :items, :shopping_list, :boolean
  end
end
