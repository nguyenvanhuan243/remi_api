# == Schema Information
#
# Table name: payments
#
#  id                :integer          not null, primary key
#  user_id           :string           not null
#  payment_type      :integer          not null
#  email             :string(254)
#  from              :string(254)
#  to                :string(254)
#  value             :decimal(, )
#  transaction_id    :string(254)
#  amount            :decimal(10, 2)   default(0.0)
#  fee               :decimal(10, 2)   default(0.0)
#  received_currency :string
#  convert_rate      :decimal(10, 2)   default(0.0)
#  received_amount   :decimal(10, 2)   default(0.0)
#  status            :integer          default(0)
#  details           :text
#  phone             :string(20)
#  code              :string(100)
#  from_currency     :string(20)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
class Payment < ApplicationRecord
  belongs_to :user

  enum status: {
    pending: 0,
    confirm: 1,
    approved: 2,
    decline: 3,
    process: 4,
    network_confirmed: 5,
    revert: 6,
    cancel: 7,
    unaccepted: 8,
    audit: 9
  }

  enum payment_type: { deposit: 0, withdrawn: 1 }

  private

  # == Instant methods ============================================================
  def clear_cache
    Rails.cache.delete 'total_usdt*'
  end
end
