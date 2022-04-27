class Invoice < ApplicationRecord
  validates :status, presence: true

  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items
  has_many :transactions
  belongs_to :customer

  enum status: {"in_progress" => 0, "completed" => 1, "cancelled" => 2}

  def invoice_total
    total = invoice_items
      .group(:invoice_id)
      .sum("invoice_items.unit_price * invoice_items.quantity")
    total[id]
  end

  def discounted_revenue
    discounted_invoice_items = invoice_items.joins(:bulk_discounts)
      .where("items.merchant_id = bulk_discounts.merchant_id") # Prevent discounts from applying to items with different merchants on same invoice.
      .where("invoice_items.quantity >= bulk_discounts.quantity")
      .distinct

    discounted_item_total = discounted_invoice_items
      .sum("invoice_items.unit_price * invoice_items.quantity * (1-bulk_discounts.percentage)")

    non_discounted_item_total = invoice_items.joins(:bulk_discounts)
      .where.not(id: discounted_invoice_items)
      .where.not("invoice_items.quantity >= bulk_discounts.quantity")
      .distinct
      .sum("invoice_items.unit_price * invoice_items.quantity")

    discounted_item_total + non_discounted_item_total
  end

  def has_items_not_shipped
    invoice_items.where.not(status: 2).empty?
  end

  def self.oldest_first
    Invoice.order(:created_at)
  end
end
