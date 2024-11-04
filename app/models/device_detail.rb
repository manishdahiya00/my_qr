class DeviceDetail < ApplicationRecord
  has_many :recently_added
  has_many :qr_data
  has_many :generated_qrs
  has_many :favourites
  has_and_belongs_to_many :user_detail

  def self.search(search)
    where("deviceId LIKE ? OR deviceName LIKE ? OR security_token LIKE ? OR advertisingId LIKE ?", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%") 
  end
end
