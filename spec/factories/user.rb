# テストデータの作成
FactoryBot.define do
  factory :user do
    name { Faker::Name.last_name }
    email { Faker::Internet.free_email }
    is_deleted { false }
    admin { false }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
