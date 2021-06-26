# frozen_string_literal: true #オブジェクトの破壊的な変更ができない

require 'rails_helper' # spec/rails_helper.rbを読み込む

RSpec.describe Item, "モデルに関するテスト", type: :model do
  describe '実際に保存してみる' do
    let(:item) { FactoryBot.create(:item) }
    # let(:user) { FactoryBot.create(:user) }
    it "有効な登録内容の場合は保存されるか" do
      expect(item).to be_valid # itemが有効であるか
    end
  end

  context "空白のバリデーションチェック" do
    let(:item) { FactoryBot.create(:item) }
    it "priceが空白の場合にバリデーションチェックされ空白のエラーメッセージが返ってきているか" do
      item.price = nil
      expect(item).to be_invalid # itemが無効であるか
      expect(item.errors[:price]).to include("を入力してください")
    end
    it "category_idが空白の場合にバリデーションチェックされ空白のエラーメッセージが返ってきているか" do
      item.category_id = nil
      expect(item).to be_invalid # itemが無効であるか
      expect(item.errors[:category_id]).to include("を入力してください")
    end
    it "brand_idが空白の場合に登録されないか" do
      item.brand_id = nil
      expect(item).to be_invalid # itemが無効であるか
    end
  end
end
