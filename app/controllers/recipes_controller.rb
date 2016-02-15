class RecipesController < ApplicationController
   
  before_action :find_recipe, only: [:show, :edit, :update, :delete]

  def index
    @recipes = Recipe.all
  end

  def show
  end
  
  def new
    @recipe = Recipe.new
    5.times { @recipe.ingredients.build}
  end
  
  def create
    @recipe = Recipe.new(recipe_params)
    if @recipe.save
      redirect_to recipes_path
    else
      render 'new'
    end
  end
  
  def edit
  end
  
  def update
    if @recipe.update(recipe_params)
      # do something
    else
      render 'edit'
    end
  end
  
private
  
  def recipe_params
    params.require(:recipe).permit(:name, :meal, :ingredient_id, :picture_url, :instructions)
  end
  
  def find_recipe
    @recipe = Recipe.find(params[:id])
  end
  
end
