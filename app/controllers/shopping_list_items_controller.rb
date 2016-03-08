class ShoppingListItemsController < ApplicationController
  
  def index
    @items = ShoppingListItem.all
  end
  
  def new
    @item = ShoppingListItem.new
  end
  
  def create
    @item = ShoppingListItem.new(item_params)
    if @item.save
      redirect_to shopping_list_items_path
    else
      render 'new'
    end
  end
  
  def destroy
    @item = ShoppingListItem.find(params[:id])
    if @item.delete
      redirect_to shopping_list_items_path(:anchor => "#{@item.list}")
    end
  end
  
  private
  
  def item_params
    params.require(:shopping_list_item).permit(:name, :boughts, :list)
  end
end
