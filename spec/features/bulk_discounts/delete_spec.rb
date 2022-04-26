require "rails_helper"

RSpec.describe "Bulk discounts delete page" do
  let!(:merchant) { Merchant.create!(name: "Rebekah's Circuits") }
  let!(:bulk_discount_a) { BulkDiscount.create!(merchant: merchant, percentage: 0.10, quantity: 10000) }
  let!(:bulk_discount_b) { BulkDiscount.create!(merchant: merchant, percentage: 0.20, quantity: 40000) }

  let!(:other_merchant) { Merchant.create!(name: "Not Rebekah's Circuits") }
  let!(:bulk_discount_c) { BulkDiscount.create!(merchant: other_merchant, percentage: 0.50, quantity: 60000) }

  before :each do
    visit "/merchants/#{merchant.id}/bulk_discounts/"
  end

  it "has link to delete bulk discount", :vcr do
    within "##{bulk_discount_b.id}" do
      click_link "Delete"
    end

    expect(page).to_not have_content("Bulk Discount: #{bulk_discount_b.id}")
  end
end
