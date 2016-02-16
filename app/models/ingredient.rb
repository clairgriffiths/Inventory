class Ingredient < ActiveRecord::Base
  belongs_to :recipe
  
  def in_stock?
    item = Item.find_by(name: self.name)
    if item == nil
      false
    else
      true
    end
  end
  
  
  
end
