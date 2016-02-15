class ItemsController < ApplicationController
  

  before_action :find_item, only: [:show, :edit, :update, :increase, :decrease]
  before_action :category_options, only: [:new, :edit, :update, :create]
  
  
  def index
    @items = Item.all
    @need_cataloging = Item.all.select{|item| item.category_id == nil}
  end
  
  def increase
    @item.quantity += 1
    @item.save
    redirect_to cupboard_path(@item.category.cupboard)
  end
  
  def decrease
    @item.quantity -= 1
    @item.save
    redirect_to cupboard_path(@item.category.cupboard)
  end
  
  def new
    @item = Item.new
  end
  
  def create
    @item = Item.create(item_params)
    if @item.save
      redirect_to cupboard_path(@item.category.cupboard)
    else
      render 'new'
    end
  end

  def edit
  end
  
  def show
  end
  
  def update
    if @item.update(item_params)
      redirect_to items_path
    else
      render 'edit'
    end
  end
  
  def shopping_list
    @items = Item.all.select{|item| item.shopping_list == true && item.quantity <= 1}
  end
  
  private
  
  def item_params
    params.require(:item).permit(:name, :category_id, :quantity, :ean, :weight, :packnumber, :shopping_list)
  end
  
  def category_options
    @category_options = Category.all.map{|c| [c.name, c.id]}
  end
  
  def find_item
    @item = Item.find(params[:id])
  end
  
end
