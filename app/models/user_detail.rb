class UserDetail < ApplicationRecord
  has_many :transaction_histories
  has_many :redeems
  has_and_belongs_to_many :device_detail

  def self.search(search)
    where("socialEmail LIKE ? OR socialName LIKE ? OR refCode LIKE ? OR advertisingId LIKE ?", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%") 
  end

end
