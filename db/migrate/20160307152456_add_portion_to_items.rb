class AddPortionToItems < ActiveRecord::Migration
  def change
    add_column :items, :portion, :integer
  end
end
