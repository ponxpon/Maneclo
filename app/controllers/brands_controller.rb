class BrandsController < ApplicationController
  # ブランド名一覧画面
  def index
    @brand = Brand.new
    # 自分が作成したブランドを自分だけに新規作成順に表示
    @brands = Brand.where(user_id: current_user.id).includes(:user).order("created_at DESC")
  end

  # ブランド名の新規登録
  def create
    @brand = Brand.new(brand_params)
    @brand.user_id = current_user.id
    if @brand.save # saveメソッドの結果がtrueならリダイレクト
      redirect_to brands_path, notice: "登録が完了しました。"
    else # falseならブランド一覧ページを再表示
      @brands = Brand.where(user_id: current_user.id).includes(:user).order("created_at DESC")
      flash[:alert] = "ブランド名を入力してください。"
      render :index
    end
  end

  # ブランド名編集画面
  def edit
    @brand = Brand.find(params[:id])
    # 他人のデータを編集不可　他人のブランド名編集画面には遷移しない
    if @brand.user == current_user
      render "edit"
    else
      redirect_to brands_path, alert: "他人のブランド名を編集することはできません。"
    end
  end

  # ブランド名の更新
  def update
    @brand = Brand.find(params[:id])
    if @brand.update(brand_params)
      redirect_to brands_path, notice: "ブランド名の更新が完了しました。"
    else
      flash[:alert] = "ブランド名を入力してください。"
      render :edit
    end
  end

  def destroy
    @brand = Brand.find(params[:id])
    @brand.destroy
    redirect_to brands_path, notice: "ブランド名の削除が完了しました。"
  end

  private

  def brand_params
    params.require(:brand).permit(:brand_name, :user_id)
  end
end
