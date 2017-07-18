class User < ApplicationRecord
  after_commit :create_account, on: :create

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :account, dependent: :destroy

  private

  def create_account
   @account=Account.new(money:0, user_id: User.last.id)
   @account.save
  end
end
