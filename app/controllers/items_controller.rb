class ItemsController < ApplicationController
  # 服一覧画面
  def index
    @items = Item.where(user_id: current_user.id).includes(:user).order("created_at DESC") # 自分が投稿したものを自分だけに新規投稿順に表示
  end

  # 服新規登録画面
  def new
    @item = Item.new # 新規投稿用の空のインスタンス
  end

  # 服の新規登録
  def create
    # 登録済ブランド
    if params[:item][:brands] == "existing_brands"
      @item = Item.new(item_params) #フォームから送られてきたデータをストロングパラメータを経由して＠itemに代入
      @item.user_id = current_user.id #deviseのメソッドを使ってログインしている自分のidを代入
      @item.save
    # # 新規登録ブランド
    elsif params[:item][:brands] == "new_brands"
      @item = Item.new(item_params) #フォームから送られてきたデータをストロングパラメータを経由して＠itemに代入
      @item.user_id = current_user.id #deviseのメソッドを使ってログインしている自分のidを代入
      @brand = Brand.new(brand_params) #ブランドを新規登録
      @brand.user_id = current_user.id
      @item.brand = @brand #アイテムのブランドに作成したブランドを紐付ける
      @item.save
    end
    redirect_to items_path
  end

  # 服詳細画面
  def show
    @item = Item.find(params[:id])
  end

  # 服編集画面
  def edit
    @item = Item.find(params[:id])
  end

  # 服の更新
  def update
    @item = Item.find(params[:id])
    @item.update(item_params)
    redirect_to items_path
  end

  # 服の削除
  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    redirect_to items_path
  end

  # グラフ表示画面
  def graph
  end

  private

  def item_params
    params.require(:item).permit(:user_id, :brand_id, :category_id, :item_image, :price, :introduction, :purchase_date)
  end

  def brand_params
    params.require(:brands).permit(:brand_name, :user_id)
  end
end