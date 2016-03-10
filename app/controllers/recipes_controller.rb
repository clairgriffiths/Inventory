class RecipesController < ApplicationController
   
  before_action :find_recipe, only: [:show, :edit, :update, :destroy]

  def index
    @recipes = Recipe.all
  end

  def show
  end
  
  def new
    @recipe = Recipe.new
    15.times { @recipe.ingredients.build}
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
      redirect_to @recipe
    else
      render 'edit'
    end
  end
  
  def destroy
    if @recipe.destroy
      redirect_to recipes_path
    end
  end
  
  def make_now
     @recipes = Recipe.all
  end
  
  def hypothetical_make_now
    if params[:hypo_items]
      @hypo_items  = params[:hypo_items].split(", ")
      @all_recipes = Recipe.all.select{|recipe| recipe.ingredients.all?{|ing| ing.in_stock? || ing.name.in?(@hypo_items)}}
      @hypo_recipes = @all_recipes.select{ |recipe| recipe.make_now? == false}
    end
  end
  
private
  
  def recipe_params
    params.require(:recipe).permit(:name, :meal, :picture_url, :instructions, ingredients_attributes: [:id, :name, :quantity])
  end
  
  def find_recipe
    @recipe = Recipe.find(params[:id])
  end
  
end
