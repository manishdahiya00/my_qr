class UserDetail < ApplicationRecord
  has_many :transaction_histories
  has_many :redeems
 has_and_belongs_to_many :device_detail

end
