class AddGramsToItems < ActiveRecord::Migration
  def change
    add_column :items, :grams, :integer
  end
end
