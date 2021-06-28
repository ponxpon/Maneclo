class ItemsController < ApplicationController
  # 服一覧画面
  def index
    # @items = Item.where(user_id: current_user.id).includes(:user).page(params[:page]).reverse_order.per(12)
    # ransackメソッドは検索ヘルパーメソッド　自分が登録したものを自分だけに新規登録順に表示　ページング機能:1ページに表示するレコード数を12件に変更
    @q = Item.where(user_id: current_user.id).includes(:user).page(params[:page]).reverse_order.per(12).ransack(params[:q])
    # resultメソッドは検索結果を返すヘルパーメソッド　distinct: trueは重複する検索結果を除外する
    @items = @q.result(distinct: true)
  end

  # 服新規登録画面
  def new
    @item = Item.new # 新規投稿用の空のインスタンス
  end

  # グラフ表示画面
  def graph
    # @pie = Item.where(user_id: current_user.id).group(:category_id).sum(:price)　この記述ではカテゴリーidで表示されカテゴリー名で表示されないので下の記述に修正
    # カテゴリー別価格の円グラフ　自分が登録した服をカテゴリーで分けて、カテゴリー別の総価格を円グラフで表示
    @pie = Item.where(user_id: current_user.id).group(:category_id).select("category_id, sum(price) as price_count").map { |m| [m.category.category_name, m.price_count] }.to_h
    # カテゴリー別数の棒グラフ　自分が登録した服をカテゴリーで分けて、カテゴリー別の総数を棒グラフで表示
    @column = Item.where(user_id: current_user.id).group(:category_id).select("category_id, count(category_id) as price_count").map { |m| [m.category.category_name, m.price_count] }.to_h
  end

  # 服の新規登録
  def create
    # 登録済ブランド
    if params[:item][:brands] == "existing_brands"
      @item = Item.new(item_params) # フォームから送られてきたデータをストロングパラメータを経由して＠itemに代入
      @item.user_id = current_user.id # deviseのメソッドを使ってログインしている自分のidを代入
      if @item.save # saveメソッドの結果がtrueならリダイレクト
        redirect_to items_path, notice: "登録が完了しました。"
      else # falseなら服登録ページを再表示
        flash[:alert] = "必須項目を入力してください。"
        render :new
      end
    # 新規登録ブランド
    elsif params[:item][:brands] == "new_brands"
      @item = Item.new(item_params) # フォームから送られてきたデータをストロングパラメータを経由して＠itemに代入
      if !brand_params[:brand_name].present? && @item.brand_id.nil? # ブランド名がない＆ブランドidが存在しない時に処理
        flash[:alert] = "必須項目を入力してください。"
        render :new and return # returnをしないとエラーが発生する
      end
      @item.user_id = current_user.id # deviseのメソッドを使ってログインしている自分のidを代入
      brand = Brand.new(brand_params) # ブランドを新規登録
      brand.user_id = current_user.id # ブランドのuser_idカラムに登録したユーザのuser.idを代入
      @item.brand = brand # アイテムのブランドに作成したブランドを紐付ける
      if @item.save # saveメソッドの結果がtrueならリダイレクト
        redirect_to items_path, notice: "登録が完了しました。"
      else # falseなら服登録ページを再表示
        flash[:alert] = "必須項目を入力してください。"
        render :new
      end
    end
  end

  # 服詳細画面
  def show
    @item = Item.find(params[:id])
    # 他人の服詳細画面には遷移しない
    if @item.user == current_user
      render "show"
    else
      redirect_to items_path, alert: "他人の服を見ることはできません。"
    end
  end

  # 服編集画面
  def edit
    @item = Item.find(params[:id])
    # 他人のデータを編集不可　他人の服編集画面には遷移しない
    if @item.user == current_user
      render "edit"
    else
      redirect_to items_path, alert: "他人の服のデータを編集することはできません。"
    end
  end

  # 服の更新
  def update
    # 登録済ブランド
    if params[:item][:brands] == "existing_brands"
      @item = Item.find(params[:id])
      @item.update(item_params)
    # 新規登録ブランド
    elsif params[:item][:brands] == "new_brands"
      @item = Item.find(params[:id])
      if !brand_params[:brand_name].present? # ブランド名がない時に処理
        flash[:alert] = "必須項目を入力してください。"
        render :new and return # returnをしないとエラーが発生する
      end
      @item.update(item_params)
      brand = Brand.new(brand_params) # ブランドを新規登録
      brand.user_id = current_user.id # ブランドのuser_idカラムに登録したユーザのuser.idを代入
      @item.brand = brand # アイテムのブランドに作成したブランドを紐付ける
      @item.save
    end
    redirect_to items_path, notice: "更新が完了しました。"
  end

  # 服の削除
  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    redirect_to items_path, notice: "服の削除が完了しました。"
  end

  private

  def item_params
    params.require(:item).permit(:user_id, :brand_id, :category_id, :item_image, :price, :introduction, :purchase_date)
  end

  def brand_params
    params.require(:brands).permit(:brand_name, :user_id)
  end
end
