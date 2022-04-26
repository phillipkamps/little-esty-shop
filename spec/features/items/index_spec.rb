require "rails_helper"

describe "merchant item index page" do
  before do
    @merchant_1 = Merchant.create!(
      name: "Store Store"
    )
    @merchant_2 = Merchant.create!(
      name: "Erots"
    )
    @cup = @merchant_1.items.create!(
      name: "Cup",
      description: "What the **** is this thing?",
      unit_price: 10000
    )
    @soccer = @merchant_1.items.create!(
      name: "Soccer Ball",
      description: "A ball of pure soccer.",
      unit_price: 32000
    )
    @beer = @merchant_2.items.create!(
      name: "Beer",
      description: "Happiness <3",
      unit_price: 100
    )

    @customer_1 = Customer.create!(
      first_name: "Malcolm",
      last_name: "Jordan"
    )
    @customer_2 = Customer.create!(
      first_name: "Jimmy",
      last_name: "Felony"
    )

    @invoice_1 = @customer_1.invoices.create!(
      status: 1
    )
    @invoice_2 = @customer_1.invoices.create!(
      status: 2
    )
    @invoice_3 = @customer_2.invoices.create!(
      status: 0
    )

    @invoice_item_1 = InvoiceItem.create!(
      item_id: @soccer.id,
      invoice_id: @invoice_1.id,
      quantity: 1,
      unit_price: @soccer.unit_price,
      status: 1
    )
    @invoice_item_2 = InvoiceItem.create!(
      item_id: @cup.id,
      invoice_id: @invoice_1.id,
      quantity: 50,
      unit_price: @cup.unit_price,
      status: 1
    )
    @invoice_item_3 = InvoiceItem.create!(
      item_id: @soccer.id,
      invoice_id: @invoice_2.id,
      quantity: 500,
      unit_price: @soccer.unit_price,
      status: 0
    )
    @invoice_item_4 = InvoiceItem.create!(
      item_id: @beer.id,
      invoice_id: @invoice_3.id,
      quantity: 2,
      unit_price: @beer.unit_price * 2,
      status: 0
    )

    @transaction_1 = @invoice_1.transactions.create!(
      credit_card_number: "4654405418249632",
      result: "success"
    )
    @transaction_2 = @invoice_2.transactions.create!(
      credit_card_number: "4654405418249632",
      result: "failed"
    )

    visit "/merchants/#{@merchant_1.id}/items"
  end

  it "has a list of all of the merchants items", :vcr do
    expect(page).to have_content("Cup")
    expect(page).to have_content("Soccer Ball")
    expect(page).not_to have_content("Beer")
  end

  it "has a button to create a new item", :vcr do
    click_button("Create a New Item")
    expect(current_path).to eq("/merchants/#{@merchant_1.id}/items/new")
  end

  describe "merchants top 5 items", :vcr do
    before do
      @nothing = @merchant_1.items.create!(
        name: "nothing",
        description: "Not anything",
        unit_price: 999
      )
      @lotion = @merchant_1.items.create!(
        name: "lotion",
        description: "Moisturize, kid.",
        unit_price: 50000
      )
      @gnihton = @merchant_1.items.create!(
        name: "gnihton",
        description: "Seems to be word written backwards",
        unit_price: 1111111
      )
      @something = @merchant_1.items.create!(
        name: "something",
        description: "Seems to be @something",
        unit_price: 37500
      )

      @invoice_4 = @customer_1.invoices.create!(
        status: 1,
        created_at: DateTime.new(2012, 12, 12)
      )

      @invoice_item_5 = InvoiceItem.create!(
        item_id: @nothing.id,
        invoice_id: @invoice_4.id,
        quantity: 90,
        unit_price: @nothing.unit_price,
        status: 2
      )
      @invoice_item_6 = InvoiceItem.create!(
        item_id: @gnihton.id,
        invoice_id: @invoice_4.id,
        quantity: 12,
        unit_price: @gnihton.unit_price,
        status: 2
      )
      @invoice_item_7 = InvoiceItem.create!(
        item_id: @lotion.id,
        invoice_id: @invoice_4.id,
        quantity: 5,
        unit_price: @lotion.unit_price,
        status: 2
      )
      @invoice_item_8 = InvoiceItem.create!(
        item_id: @something.id,
        invoice_id: @invoice_4.id,
        quantity: 5,
        unit_price: @something.unit_price,
        status: 2
      )
      @transaction_3 = @invoice_4.transactions.create!(
        credit_card_number: "4654405418249632",
        result: "success"
      )

      visit "/merchants/#{@merchant_1.id}/items"
    end

    it "displays them in order", :vcr do
      within("#top_five_items") do
        expect("gnihton").to appear_before("Cup")
        expect("Cup").to appear_before("lotion")
        expect("lotion").to appear_before("something")
        expect("something").to appear_before("nothing")

        expect(page).not_to have_content("Soccer Ball")
      end
    end

    it "has the best date for sales", :vcr do
      within("#top_item_#{@gnihton.id}") do
        expect(page).to have_content("Top selling date was: 2012-12-12")
      end
    end

    it "displays the item's total revenue", :vcr do
      within("#top_item_#{@gnihton.id}") do
        expect(page).to have_content("Total revenue generated: $133333.32")
      end

      within("#top_item_#{@cup.id}") do
        expect(page).to have_content("Total revenue generated: $5000.0")
      end

      within("#top_item_#{@nothing.id}") do
        expect(page).to have_content("Total revenue generated: $899.1")
      end
    end
  end

  it "displays the merchant and merchant item's names", :vcr do
    expect(page).to have_content(@merchant_1.name)
    within("#all_items") do
      expect(page).to have_content(@cup.name)
      expect(page).to have_content(@soccer.name)

      expect(page).not_to have_content(@beer.name)
    end
  end

  it "has a button to change item status", :vcr do
    within("#DisabledItem-#{@cup.id}") do
      expect(page).to_not have_button("Disable Item")
      click_button("Enable Item")
    end

    expect(current_path).to eq("/merchants/#{@merchant_1.id}/items")

    within("#EnabledItem-#{@cup.id}") do
      expect(page).to_not have_button("Enable Item")
      expect(page).to have_button("Disable Item")
      click_button("Disable Item")
    end

    expect(current_path).to eq("/merchants/#{@merchant_1.id}/items")

    within("#DisabledItem-#{@cup.id}") do
      expect(page).to have_button("Enable Item")
      expect(page).to_not have_button("Disable Item")
    end
  end
end
