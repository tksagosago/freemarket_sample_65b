class ItemsController < ApplicationController

  def new
    @item = Item.new
    @item.images.new
  end

  def buy
  end

  def show
  end
  
end