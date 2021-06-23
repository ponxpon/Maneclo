class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # アソシエーション
  has_many :items, dependent: :destroy
  has_many :brands, dependent: :destroy

  # ゲストログイン機能
  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user| #このemailを使ってログインする。アカウントがなければ作成してログインする。
      user.password = SecureRandom.urlsafe_base64 #パスワードをランダム文字列
      user.name = "ゲスト" #登録時にnameのカラムがあるので、ゲストに設定
    end
  end

  # ログイン時に退会済みのユーザーが同じアカウントでログイン出来ないようにする制約
  def active_for_authentication?
    super && (is_deleted == false)
  end
end
