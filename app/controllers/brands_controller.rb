class BrandsController < ApplicationController
  # ブランド名一覧画面
  def index
    @newbrand = Brand.new
    @brands = Brand.where(user_id: current_user.id).includes(:user).order("created_at DESC") # 自分が作成したブランドを自分だけに新規作成順に表示
  end

  # ブランド名の新規登録
  def create
    @brand = Brand.new(brand_params)
    @brand.user_id =current_user.id
    @brand.save
    redirect_to brands_path
  end

  # ブランド名編集画面
  def edit
    @brand = Brand.find(params[:id])
  end

  # ブランド名の更新
  def update
    @brand = Brand.find(params[:id])
    @brand.update(brand_params)
    redirect_to brands_path
  end

  def destroy
    @brand = Brand.find(params[:id])
    @brand.destroy
    redirect_to brands_path
  end


  private
  def brand_params
    params.require(:brand).permit(:brand_name, :user_id)
  end
end
