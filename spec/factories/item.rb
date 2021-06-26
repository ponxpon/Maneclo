# FactoryBotはテストデータの作成をサポートをしてくれるGem
# 宣言文でありデータの定義を行う際に記述
FactoryBot.define do
  # どのモデルに対してデータ定義を行うのか記す
  factory :item do
    # カラム名｛ 値 ｝の形になる
    category_id { Faker::Number.digit }
    item_image_id { Faker::Number.digit }
    price { Faker::Number.number(digits: 4) } # 先頭の桁が0にならない指定された桁数を生成する
  end
end
