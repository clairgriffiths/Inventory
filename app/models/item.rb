class Item < ActiveRecord::Base
  
  belongs_to :category
  
  require "google/api_client"
  require "google_drive"
  
  @eans1 = []
  
  def self.get_eans
    session = GoogleDrive.saved_session("config.json")
    file = session.file_by_title("Barcode Scanner history")
    # Overwrites whatever was in there before
    file.download_to_file("/home/nitrous/code/Inventory/tmp/test.txt")
    # Deletes the file from the drive, not locally
    file.delete
  end
  
  def self.extract_eans
    CSV.foreach("/home/nitrous/code/Inventory/tmp/test.txt") do |csv|
      @eans1 << csv[0]
    end
    @eans1
  end
  
  def self.ean_exists?
    # Need to get the list of EAN numbers
    @eans1.each do |ean|
      if Item.where(:ean => ean).blank?
        @ean_lookup << ean
        @ean_lookup
      else
        @item1 = Item.find_by(:ean => ean)
        @item1.update(:quantity => (@item1.quantity += 1))
      end
    end
  end
    
  def self.add_items(eans)
    access_token = "29DF7AE5-3FD2-47AA-BDC0-6D30145D6611"
    eans.each do |ean|
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
  
    
    
end
