require "rails_helper"

RSpec.describe "Bulk discounts new page" do
  let!(:merchant) { Merchant.create!(name: "Rebekah's Circuits") }
  let!(:bulk_discount_a) { BulkDiscount.create!(merchant: merchant, percentage: 0.10, quantity: 10000) }
  let!(:bulk_discount_b) { BulkDiscount.create!(merchant: merchant, percentage: 0.20, quantity: 40000) }

  let!(:other_merchant) { Merchant.create!(name: "Not Rebekah's Circuits") }
  let!(:bulk_discount_c) { BulkDiscount.create!(merchant: other_merchant, percentage: 0.50, quantity: 60000) }

  before :each do
    visit "/merchants/#{merchant.id}/bulk_discounts/new"
  end

  it "has form to create new bulk discount", :vcr do
    expect(page).to have_field("Percentage (as decimal):")
    expect(page).to have_field("Item quantity:")
  end

  it "creates new bulk discount", :vcr do
    fill_in "Percentage (as decimal):", with: "0.75"
    fill_in "Item quantity", with: "70000"
    click_button("Create discount")

    expect(current_path).to eq("/merchants/#{merchant.id}/bulk_discounts")
    expect(page).to have_content("Percentage: 0.75")
    expect(page).to have_content("Quantity: 70000")
  end
end
