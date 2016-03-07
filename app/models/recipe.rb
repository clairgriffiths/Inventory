class Recipe < ActiveRecord::Base
  has_many :ingredients, :dependent => :destroy
  accepts_nested_attributes_for :ingredients, :reject_if => lambda { |a| a[:name].blank? }, :allow_destroy => true
  
  def make_now?
    if self.ingredients.any?{|ing| ing.in_stock? == false}
      false
    else
      true
    end
  end
  
  def add_to_shopping_list
    # Not really working
    need = self.ingredients.select{|ing| ing.in_stock? == false}
    items = []
    need.each{|ing| items << Item.find_by(name: ing.name)}
    # won't find it if it doesn't exist!!
    items.each{|item| item.update(shopping_list: true)}
  end
  
end
