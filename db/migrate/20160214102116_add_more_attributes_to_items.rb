class AddMoreAttributesToItems < ActiveRecord::Migration
  def change
    add_column :items, :ean, :string
    add_column :items, :weight, :integer
    add_column :items, :packnumber, :integer
  end
end
