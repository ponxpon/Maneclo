class UsersController < ApplicationController
  # 退会確認画面
  def unsubscribe
  end

  # 退会機能
  def update
    # ゲストユーザは削除できないようにする
    if current_user.email == 'guest@example.com'
      redirect_to root_path, alert: 'ゲストユーザーは削除できません。' and return
    end
    @user = current_user
    # is_deletedをtrueに変更することにより退会する
    @user.update(is_deleted: true)
    # セッション情報を削除
    reset_session
    redirect_to root_path, notice: "退会処理を実行いたしました。"
  end

  private

  def user_params
    params.permit(:name, :is_deleted, :admin)
  end
end
