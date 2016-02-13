class CategoriesController < ApplicationController
  
  before_action :find_category, only: [:show, :update, :edit]
  
  def index 
    @categories = Category.all
  end
  
  def show
  end
  
  def new 
  end
  
  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to categories_path
    else 
      render :new
    end
  end
  
  private
  
  def category_params
    params.require(:category).permit(:name)
  end
  
  def find_category
    @category = Category.find(params[:id])
  end
  
  
end
