class UserDetail < ApplicationRecord
  has_and_belongs_to_many :device_detail
  has_many :redeem_histories
end
