class CupboardsController < ApplicationController
  def new
    @cupboard = Cupboard.new
  end

  def index
    @cupboards = Cupboard.all
  end
  
  def show
    @cupboard = Cupboard.find(params[:id])
  end
  
  def new
    @cupboard = Cupboard.new
  end
  
  def create
    @cupboard = Cupboard.new(cupboard_params)
    if @cupboard.save
      redirect_to cupboards_path
    else
      render 'new'
    end
  end
  
  def get_eans
    session = GoogleDrive.saved_session("config.json")
    file = session.file_by_title("Barcode Scanner history")
    # This overwrites whatever was in there before
    file.download_to_file("/home/nitrous/code/projects/Inventory/tmp/test.txt")
    if File.zero?("/home/nitrous/code/projects/Inventory/tmp/test.txt")
      flash[:danger] = "Nothing was imported"
    else
      Item.extract_eans
      flash[:success] = "Items were imported"
      file.delete
      redirect_to root_path
    end
  end
  
private
  
  def cupboard_params
    params.require(:cupboard).permit(:name)
  end
  
end
