class ItemsController < ApplicationController
  
  before_action :category_options, only: [:new, :edit, :update, :create]
  
  
  def index
    @items = Item.all
  end
  
  def increase
    @item = Item.find(params[:id])
    @item.quantity += 1
    @item.save
    redirect_to cupboard_path(@item.category.cupboard)
  end
  
  def decrease
    @item = Item.find(params[:id])
    @item.quantity -= 1
    @item.save
    if @item.quantity <= 0
      @item.delete
    end
    redirect_to cupboard_path(@item.category.cupboard)
  end

  def new
    @item = Item.new
  end
  
  def create
    @item = Item.create(item_params)
    if @item.save
      redirect_to categories_path
    else
      render 'new'
    end
  end

  def edit
  end
  
  private
  
  def item_params
    params.require(:item).permit(:name, :category_id, :quantity, :grams)
  end
  
  def category_options
    @category_options = Category.all.map{|c| [c.name, c.id]}
  end
  
  
end
