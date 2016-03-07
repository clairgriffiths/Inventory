class Item < ActiveRecord::Base
  
  belongs_to :category
  
  require "google/api_client"
  require "google_drive"
  
    
  # Populating items from barcode scan
  def self.extract_eans
    @eans1 = []
    # How would this work in Heroku?
    CSV.foreach("/home/nitrous/code/projects/Inventory/tmp/test.txt") do |csv|
      @eans1 << csv[0]
    end
      @eans1.each do |ean|
        
        if ean_exists?(ean)
          increase_item_quantity(ean)
        else
          add_item(ean)
        end
      end
  end
  
  def self.ean_exists?(ean)
    !Item.find_by(:ean => ean).blank?
  end
    
  def self.increase_item_quantity(ean)
    item = Item.find_by(:ean => ean)
    item.quantity += 1
    item.save
  end
    
  def self.add_item(ean)
    access_token = "29DF7AE5-3FD2-47AA-BDC0-6D30145D6611"
    url = "http://www.searchupc.com/handlers/upcsearch.ashx?request_type=3&access_token=#{access_token}&upc=#{ean}"
    request = HTTParty.get(url)
    body = JSON.parse(request.body)
    if body == {} || body["0"]["productname"] == " "
      item = Item.create(ean: ean, quantity: 1)
    else
      @api_name = body["0"]["productname"]
      Item.create(name: @api_name, quantity: 1, ean: ean)
    end
  end
  
    
    
end
