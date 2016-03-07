class Cupboard < ActiveRecord::Base
  has_many :items
  
  
  def categories
    self.items.map{|item| item.category}
  end
  
  def category_items(category)
    self.items.select{|item| item.category == category}
  end
end
