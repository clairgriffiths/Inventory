class Cupboard < ActiveRecord::Base
  has_many :items
  
  def get_eans
    begin
      session = GoogleDrive.saved_session("config.json")
      file = session.file_by_title("Barcode Scanner history")
      # Overwrites whatever was in there before
      file.download_to_file("/home/nitrous/code/Inventory/tmp/test.txt")
      # Deletes the file from the drive, not locally
      # file.delete
    rescue
       false
    end
  end
  
  def categories
    self.items.map{|item| item.category}
  end
  
  def category_items(category)
    self.items.select{|item| item.category == category}
  end
end
