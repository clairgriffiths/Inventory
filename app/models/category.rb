class Category < ActiveRecord::Base
  
  has_many :items
  
  
  validates_uniqueness_of :name
  
end
