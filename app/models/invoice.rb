class Invoice < ApplicationRecord
  validates :status, presence: true

  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items
  has_many :transactions
  belongs_to :customer

  enum status: { "in_progress" => 0, "completed" => 1, "cancelled" => 2 }
end
