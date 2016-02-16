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
  
  def make_now
    @recipes = Recipe.all.select{|recipe| recipe.make_now? != false}
  end
  
  def hypothetical_make_now
    @hypo_item = params[:hypo_item]
    @hypo_recipes = Recipe.all.select{|recipe| recipe.ingredients.all?{|ing| ing.in_stock? || ing.name == @hypo_item}}
  end
  
private
  
  def recipe_params
    params.require(:recipe).permit(:name, :meal, :picture_url, :instructions, ingredients_attributes: [:id, :name, :quantity])
  end
  
  def find_recipe
    @recipe = Recipe.find(params[:id])
  end
  
end
