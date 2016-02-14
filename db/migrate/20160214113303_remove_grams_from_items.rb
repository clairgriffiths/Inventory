class RemoveGramsFromItems < ActiveRecord::Migration
  def change
    remove_column :items, :grams
  end
end
