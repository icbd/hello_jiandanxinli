class User < ApplicationRecord
  validates :telephone, presence: true, uniqueness: true,
            format: {with: /\A1[0-9]{10}\z/, message: "Please check phone number format."}


end
