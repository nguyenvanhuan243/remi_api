# == Schema Information
#
# Table name: assets
#
#  id             :integer          not null, primary key
#  user_id        :integer
#  currency       :string
#  balance        :decimal(, )
#  locked_balance :decimal(, )
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
class Asset < ApplicationRecord
  belongs_to :user

  validate :locked_balance_not_greater_than_balance
  validates :balance, numericality: { greater_than_or_equal_to: 0 }
  validates :locked_balance, numericality: { greater_than_or_equal_to: 0 }
  validates :currency, presence: true, uniqueness: {
    scope: :user_id,
    message: 'has already existed this currency'
  }

  def locked_balance_not_greater_than_balance
    if locked_balance > balance
      errors.add(:locked_balance, :greater_than_balance)
    end
  end

end
