class Brand < ApplicationRecord
  # アソシエーション
  has_many :items, dependent: :destroy
  belongs_to :user

  # バリデーション
  validates :brand_name, presence: true
end
