class RecentlyAdded < ApplicationRecord
  belongs_to :device_detail,dependent: :destroy
end
