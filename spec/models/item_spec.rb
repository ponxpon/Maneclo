# frozen_string_literal: true #オブジェクトの破壊的な変更ができない

require 'rails_helper' #spec/rails_helper.rbを読み込む

RSpec.describe Item, "モデルに関するテスト", type: :model do
  describe '実際に保存してみる' do
    it "有効な登録内容の場合は保存されるか" do
      expect(FactoryBot.build(:item)).to be_valid
    end
  end
  context "空白のバリデーションチェック" do
    it "category_idが空白の場合にバリデーションチェックされ空白のエラーメッセージが返ってきているか" do
      item = Item.new(brand_id: '1', category_id: '', price: '1000')
      expect(item).to be_invalid
      expect(item.errors[:category_id]).to include("can't be blank")
    end
    it "priceが空白の場合にバリデーションチェックされ空白のエラーメッセージが返ってきているか" do
      item = Item.new(brand_id: '1', category_id: '1', price: '')
      expect(item).to be_invalid
      expect(item.errors[:price]).to include("can't be blank")
    end
  end
end
