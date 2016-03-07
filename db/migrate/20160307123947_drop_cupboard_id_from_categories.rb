class DropCupboardIdFromCategories < ActiveRecord::Migration
  def up
    remove_reference :categories, :cupboard
    add_reference :items, :cupboard, index: true, foreign_key: true
  end
  
  def down
    add_reference :categories, :cupboard, index: true, foreign_key: true
    remove_reference :items, :cupboard
  end
  
end
