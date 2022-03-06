class Order < ApplicationRecord

  has_many :order_details

  belongs_to :customer

  validates :postal_code, presence: true
  validates :address, presence: true
  validates :name, presence: true
  validates :payment_method, presence: true

  enum payment_method: { credit_card: 0, transfer: 1 }
  enum status: { waiting_deposit: 0, deposited: 1, production: 2, preparing_ship: 3, shipped: 4 }

end