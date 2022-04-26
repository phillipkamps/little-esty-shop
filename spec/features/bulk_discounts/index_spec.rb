require "rails_helper"

RSpec.describe "Bulk discounts index page" do
  let!(:merchant) { Merchant.create!(name: "Rebekah's Circuits") }
  let!(:bulk_discount_a) { BulkDiscount.create!(merchant: merchant, percentage: 0.10, quantity: 10000) }
  let!(:bulk_discount_b) { BulkDiscount.create!(merchant: merchant, percentage: 0.20, quantity: 40000) }

  let!(:other_merchant) { Merchant.create!(name: "Not Rebekah's Circuits") }
  let!(:bulk_discount_c) { BulkDiscount.create!(merchant: other_merchant, percentage: 0.50, quantity: 60000) }

  before :each do
    visit "/merchants/#{merchant.id}/bulk_discounts"
  end

  it "has bulk discounts", :vcr do
    expect(page).to have_content("Percentage: 0.1")
    expect(page).to have_content("Quantity: 10000")

    expect(page).to have_content("Percentage: 0.2")
    expect(page).to have_content("Quantity: 40000")

    expect(page).to_not have_content("Percentage: 0.5")
    expect(page).to_not have_content("Quantity: 60000")
  end

  it "links to bulk discount show", :vcr do
    click_link bulk_discount_a.id.to_s
    expect(current_path).to eq("/merchants/#{merchant.id}/bulk_discounts/#{bulk_discount_a.id}")
    expect(page).to have_content("Bulk Discount: #{bulk_discount_a.id}")
    expect(page).to_not have_content("Bulk Discount: #{bulk_discount_b.id}")
  end

  it "links to bulk discount create", :vcr do
    click_link "New bulk discount"
    expect(current_path).to eq("/merchants/#{merchant.id}/bulk_discounts/new")
  end

  it "displays upcoming holidays", :vcr do
    within ".upcoming-holidays" do
      expect("Memorial Day").to appear_before("Juneteenth")
      expect("Juneteenth").to appear_before("Independence Day")
      expect("2022-05-30").to appear_before("2022-06-20")
      expect("2022-06-20").to appear_before("2022-07-04")
    end
  end
end
