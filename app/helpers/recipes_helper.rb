module RecipesHelper
  
  def found_item(ingredient)
    @found_item = Item.find_by(name: ingredient.name)
  end
  
  def grouped_recipes
    @recipes.all.group_by{|recipe| recipe.meal}
  end
  
  def grouped_make_now_recipes
     @make_now_recipes = @recipes.all.select{|recipe| recipe.make_now? == false}
     @make_now_recipes.group_by{|recipe| recipe.meal}
  end
  
end
