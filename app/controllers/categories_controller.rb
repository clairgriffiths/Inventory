class CategoriesController < ApplicationController
  
  before_action :find_category, only: [:show, :update, :edit]
  before_action :cupboard_options, only: [:new, :edit, :update, :create] 
  
  def index 
    @categories = Category.all
  end
  
  def show
    
  end
  
  def new 
    @category = Category.new
  end
  
  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to root_path
    else 
      render :new
    end
  end
  
  private
  
  def category_params
    params.require(:category).permit(:name, :cupboard_id)
  end
  
  def find_category
    @category = Category.find(params[:id])
  end
  
  def cupboard_options
    @cupboard_options = Cupboard.all.map{|c| [c.name, c.id]}
  end
  
  
end
