class AdminController < ApplicationController
  before_filter :is_admin?
  def index
    @users = User.paginate(page: params[:page], per_page: 10)
  end
end
