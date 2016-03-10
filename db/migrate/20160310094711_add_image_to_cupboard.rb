class AddImageToCupboard < ActiveRecord::Migration
  def change
    add_column :cupboards, :image_link, :string
  end
end
