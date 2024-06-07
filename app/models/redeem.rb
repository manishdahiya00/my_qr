class Redeem < ApplicationRecord
  belongs_to :user_detail,dependent: :destroy
end
