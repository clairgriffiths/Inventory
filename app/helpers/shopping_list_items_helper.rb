module ShoppingListItemsHelper
  
  def grouped_items
    @items.all.group_by{|item| item.list}
  end
end
