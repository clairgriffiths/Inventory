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
        add_items(if_ean_exists?(ean))
      end
  end
  
  def self.if_ean_exists?(ean)
    # how do I get this from extract_eans?
    # if Item.find_by(:ean => '000').blank?
    if !Item.find_by(:ean => ean).blank?
      item = Item.find_by(:ean => ean)
      item.quantity += 1
      item.save
    else
     ean
    end
  end
    
  def self.add_items(ean)
    access_token = "29DF7AE5-3FD2-47AA-BDC0-6D30145D6611"
    url = "http://www.searchupc.com/handlers/upcsearch.ashx?request_type=3&access_token=#{access_token}&upc=#{ean}"
    request = HTTParty.get(url)
    body = JSON.parse(request.body)
    if body == {} || body["0"]["productname"] == nil
      Item.create(ean: ean, quantity: 1)
    else
      @api_name = body["0"]["productname"]
      Item.create(name: @api_name, quantity: 1)
    end
  end
  
    
    
end
