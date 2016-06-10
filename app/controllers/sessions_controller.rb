class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)

    if user && user.authenticate(params[:session][:password])
      log_in user
      redirect_to user.admin? ? admin_index_path : root_path
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'sessions/new'
    end
  end

  def auth
    begin
      @user = from_omniauth(request.env['omniauth.auth'])
      if (session[:user_id].nil?)
        session[:user_id] = @user.id
      end
      flash[:success] = "Connect #{request.env['omniauth.auth'].provider.capitalize} Successfully."
    rescue
      flash.now[:warning] = 'There was an error while trying to authenticate you...'
    end

    redirect_to root_path
  end

  def signup
    @user = User.new
  end

  def register
    @user = User.new(user_params)

    if @user.save
      flash[:success] = 'User was successfully created.'
      redirect_to register_path
    else
      render 'signup'
    end
  end

  def auth_failure
    redirect_to root_path
  end

  def destroy
    if current_user
      session.delete(:user_id)
      @current_user = nil
    end
    redirect_to login_path
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
