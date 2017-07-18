class Transaction < ApplicationRecord

  belongs_to :category
  belongs_to :account

  validates :description, :value, presence: true
  validates :direction, inclusion: { in: [ true, false ]}
  validates :description, length: { maximum: 140 }
  validates :value, numericality: {other_than: 0}


end
