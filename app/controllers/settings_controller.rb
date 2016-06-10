class SettingsController < ApplicationController
  def profile
    @user = current_user
    @user_face = user_has_social('facebook')
    @user_twitter = user_has_social('twitter')
    @user_google = user_has_social('google')
    @user_instagram = user_has_social('instagram')
  end

  def set_change_profile
    @user = current_user

    if @user.update_attributes(user_params)
      flash[:success] = 'User was successfully updated.'
      redirect_to settings_profile_path
    else
      render 'settings/profile'
    end
  end

  def disconnect
    begin
      @user = dis_connect(current_user.id, params[:provider])
      flash[:success] = "Disconnect #{params[:provider].capitalize} Successfully."
    rescue
      flash.now[:warning] = "There was an error while trying to disconnect #{params[:provider].capitalize} ..."
    end

    redirect_to settings_profile_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :picture)
  end
end
