class ItemsController < ApplicationController
  

  before_action :find_item, only: [:show, :edit, :update, :increase, :decrease, :add_to_list]
  before_action :category_options, only: [:new, :edit, :update, :create]
  before_action :cupboard_options, only: [:new, :edit, :update, :create]
  
  
  def index
    @items = Item.all
    @need_cataloging = Item.all.select{|item| item.category_id == nil}
  end
  
  def increase
    @item.quantity += 1
    @item.save
    redirect_to cupboard_path(@item.cupboard, :anchor => "#{@item.category.name}")
  end
  
  def decrease
    @item.quantity -= 1
    @item.save
    if @item.shopping_list == true && @item.quantity <= 1
      ShoppingListItem.create(name: "#{@item.name}", list: "Big Shop")
    end
    redirect_to cupboard_path(@item.cupboard, :anchor => "#{@item.category.name}")
  end
  
  def add_to_list
    
    if ShoppingListItem.create(name: "#{@item.name}", list: "Week Shop")
      flash[:success] = "#{@item.name} added to shopping list"
      redirect_to cupboard_path(@item.cupboard, :anchor => "#{@item.category.name}")
      else
      flash[:danger] = "Oops, something went wrong. Your item wasn't added to the shopping list"
    end
    
  end
  
  def new
    @item = Item.new
  end
  
  def create
    @item = Item.create(item_params)
    if @item.save
      redirect_to cupboard_path(@item.cupboard)
      flash[:success] = "Yup, that saved"
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
      if Item.all.select{|item| item.category_id == nil}.empty?
        redirect_to cupboards_path
      else
        redirect_to items_path
      end
    else
      render 'edit'
    end
  end
  
  
  
private
  
    def item_params
    params.require(:item).permit(:name, :category_id, :quantity, :ean, :weight, :packnumber, :shopping_list, :cupboard_id)
  end
  
  def category_options
    @category_options = Category.all.map{|c| [c.name, c.id]}
  end
  
  def cupboard_options
    @cupboard_options = Cupboard.all.map{|c| [c.name, c.id]}
  end
  
  def find_item
    @item = Item.find(params[:id])
  end
  
end
