class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # アソシエーション
  has_many :items, dependent: :destroy
  has_many :brands, dependent: :destroy

  # ログイン時に退会済みのユーザーが同じアカウントでログイン出来ないようにする制約
  def active_for_authentication?
    super && (is_deleted == false)
  end
end
