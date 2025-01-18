class ApplicationController < ActionController::Base
  #Deviseコントローラーで許可されたパラメーターを設定するためのメソッド
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [
      :last_name, :first_name, :last_name_kana, :first_name_kana,
      :affiliated_store, :address, :telephone_number
    ])
    devise_parameter_sanitizer.permit(:account_update, keys: [
      :last_name, :first_name, :last_name_kana, :first_name_kana,
      :affiliated_store, :address, :telephone_number
    ])
  end
end
