class Item < ApplicationRecord
  # refileに必要なメソッド
  attachment :item_image

  # アソシエーション
  belongs_to :user
  belongs_to :brand
  belongs_to :category

end
