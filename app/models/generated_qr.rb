class GeneratedQr < ApplicationRecord
  has_one_attached :codeImage
  belongs_to :device_detail,dependent: :destroy
end
