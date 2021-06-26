# テストデータの作成
FactoryBot.define do
  factory :user do
    password = Faker::Internet.password(8) # ランダムな8桁のパスワードを生成する
    name { Faker::Name.last_name }
    email { Faker::Internet.free_email }
    password { password }
    password_confirmation { password }
  end
end
