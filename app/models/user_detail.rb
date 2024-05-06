class UserDetail < ApplicationRecord
  has_and_belongs_to_many :device_detail
end
