class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
  # ユーザ新規登録でユーザ名のデータ操作許可
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  # サインイン後itemsに遷移
  def after_sign_in_path_for(resource)
    items_path
  end

  # サインアップ後itemsに遷移
  def after_sign_up_path_for(resource)
    customer_path(current_customer)
  end

   # 会員の論理削除のための記述。退会後は同じアカウントでは利用できない。
  def reject_user
    @user = User.find_by(name: params[:user][:name])
    if @user
      if @user.valid_password?(params[:user][:password]) && (@user.is_deleted == false)
        flash[:notice] = "退会済みです。再度ご登録をしてご利用ください。"
        redirect_to new_user_registration
      else
        flash[:notice] = "項目を入力してください"
      end
    end
  end
end
