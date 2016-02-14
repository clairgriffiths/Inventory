class Item < ActiveRecord::Base
  
  belongs_to :category
  
   
  def self.new_api_item
    access_token = "29DF7AE5-3FD2-47AA-BDC0-6D30145D6611"
    @ean = "5011308318662"
    url = "http://www.searchupc.com/handlers/upcsearch.ashx?request_type=3&access_token=#{access_token}&upc=#{@ean}"
    request = HTTParty.get(url)
    body = JSON.parse(request.body) 
    @api_name = body["0"]["productname"]
    
    # Check it isn't already in there
    if Item.where(:ean => @ean).blank?
      Item.create(name: @api_name, quantity: 1, ean: @ean)
    else
      @item1 = Item.find_by(:ean => @ean)
      @item1.update(:quantity => (@item1.quantity += 1))
      @item1.save
    end
  end
  
end
