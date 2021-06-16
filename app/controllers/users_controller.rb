class UsersController < ApplicationController
  # 退会確認画面
  def unsubscribe
    @user = current_user
  end

  # 退会機能
  def update
    @user = current_user
    # is_deletedをtrueに変更することにより退会する
    @user.update(is_deleted: true)
    # セッション情報を削除
    reset_session
    redirect_to root_path
  end

  private
  def user_params
    params.permit(:name, :is_deleted, :admin)
  end
end
