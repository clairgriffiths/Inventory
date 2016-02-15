module RecipesHelper
  
  def found_item(ingredient)
    @found_item = Item.find_by(name: ingredient.name)
  end
  
  def grouped_recipes
    @recipes.all.group_by{|recipe| recipe.meal}
  end
  
end
