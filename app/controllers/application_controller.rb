class ApplicationController < ActionController::Base
    before_action :set_locale
    protect_from_forgery with: :exception
    before_action :configure_permitted_parameters, if: :devise_controller?
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    { locale: I18n.locale }
  end
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :email, :password, :status, :admin)}
    end


end
