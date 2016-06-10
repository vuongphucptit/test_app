class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include SessionsHelper

  before_action :require_login, only: [:index, :edit, :update]

  private

  def require_login
    if !logged_in?
      redirect_to login_url
    end
  end

  def logged_in?
    !current_user.nil?
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def is_admin?
    if logged_in? && current_user.admin.nil?
      redirect_to root_path
    end
  end

  helper_method :current_user
end
