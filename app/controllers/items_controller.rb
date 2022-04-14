class ItemsController < ApplicationController
  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def index
    @merchant = Merchant.find(params[:merchant_id])
    @items = @merchant.items
  end

  def update
    merchant = Merchant.find(params[:merchant_id])
    item = Item.find(params[:id])

    if item.status == "disabled"
      item.status = "enabled"
    else
      item.status = "disabled"
    end
    
    item.save
    redirect_to "/merchants/#{merchant.id}/items"
  end

  def edit
    @item = Item.find(params[:id])
  end

  def show
    @item = Item.find(params[:id])
  end

  def create
    binding.pry
    merchant = Merchant.find(params[:merchant_id])
    item = merchant.items.create(item_params)

    if item.save
      redirect_to "/merchants/#{merchant.id}/items"
    else
      # flash[:alert] = "Error: missing information. Please fill in all fields"
      redirect_to "/merchants/#{merchant.id}/items/new"
    end
  end

  def update
    Item.update(item_params)
    @item = Item.find(params[:id])
    redirect_to "/items/#{@item.id}", alert: "#{@item.name} has been updated"
  end

  private

  def item_params
    params.permit(:name, :description, :unit_price)
  end
end
