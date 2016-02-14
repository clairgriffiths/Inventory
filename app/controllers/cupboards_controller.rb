class CupboardsController < ApplicationController
  def new
  end

  def index
    @cupboards = Cupboard.all
  end
  
  def show
    @cupboard = Cupboard.find(params[:id])
  end
end
