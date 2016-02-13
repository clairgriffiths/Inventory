class CreateCupboards < ActiveRecord::Migration
  def change
    create_table :cupboards do |t|
      t.string :name
      t.timestamps null: false
    end
  end
end
