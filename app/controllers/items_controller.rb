class ItemsController < ApplicationController
  
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
  end

  def edit
  end
end
