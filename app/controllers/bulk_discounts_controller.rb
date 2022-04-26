require "./lib/holiday_api/upcoming_holidays"

class BulkDiscountsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discounts = @merchant.bulk_discounts
    @next_3_holidays = UpcomingHolidays.new.next_3_holidays
  end

  def show
    @bulk_discount = BulkDiscount.find(params[:id])
    @merchant = Merchant.find(params[:merchant_id])
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    merchant = Merchant.find(params[:merchant_id])
    merchant.bulk_discounts.create!(bulk_discount_params)
    redirect_to "/merchants/#{merchant.id}/bulk_discounts"
  end

  def destroy
    merchant = Merchant.find(params[:merchant_id])
    discount = merchant.bulk_discounts.find(params[:id])
    discount.delete
    redirect_to "/merchants/#{merchant.id}/bulk_discounts"
  end

  def edit
    @bulk_discount = BulkDiscount.find(params[:id])
    @merchant = Merchant.find(params[:merchant_id])
  end

  def update
    merchant = Merchant.find(params[:merchant_id])
    discount = merchant.bulk_discounts.find(params[:id])
    discount.update(bulk_discount_params)
    redirect_to "/merchants/#{merchant.id}/bulk_discounts/#{discount.id}"
  end

  private

  def bulk_discount_params
    params.permit(:percentage, :quantity)
  end
end
