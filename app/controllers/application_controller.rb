class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :configure_permitted_parameters,
    if: :devise_controller?


  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys:[:image, :email, :name, :about])
    devise_parameter_sanitizer.permit(:account_update, keys:[:image, :email, :name, :about])
  end

end
