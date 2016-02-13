class ItemsController < ApplicationController
  
  before_action :category_options, only: [:new, :edit, :update, :create] 
  
  def index
    @items = Item.all
  end
  
  def increase
    @item = Item.find(params[:id])
    @item.quantity += 1
    @item.save
    redirect_to items_path
  end
  
  def decrease
    @item = Item.find(params[:id])
    @item.quantity -= 1
    @item.save
    redirect_to items_path
  end

  def new
    @item = Item.new
  end
  
  def create
    @item = Item.create(item_params)
    if @item.save
      redirect_to items_path
    else
      render 'new'
    end
  end

  def edit
  end
  
  private
  
  def item_params
    params.require(:item).permit(:name, :category_id, :quantity)
  end
  
  def category_options
    @category_options = Category.all.map{|c| [c.name, c.id]}
  end
end
