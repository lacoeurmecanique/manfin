class Category < ApplicationRecord

  has_many :transactions, dependent: :destroy

  validates_uniqueness_of :kind
  validates :kind, presence: true

end
