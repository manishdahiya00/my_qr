class TransactionHistory < ApplicationRecord
  belongs_to :user_detail,dependent: :destroy
end
