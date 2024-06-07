class DeviceDetail < ApplicationRecord
  has_many :recently_added
  has_many :qr_data
  has_many :generated_qrs
  has_many :favourites
  has_and_belongs_to_many :user_detail
end
