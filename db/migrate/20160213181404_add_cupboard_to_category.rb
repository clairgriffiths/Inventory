class AddCupboardToCategory < ActiveRecord::Migration
  def change
    add_reference :categories, :cupboard, index: true, foreign_key: true
  end
end
