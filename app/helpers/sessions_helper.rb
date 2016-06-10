module SessionsHelper
  # Logs in the given user.
  def log_in(user)
    session[:user_id] = user.id
  end

  def current_user?(user)
    user == current_user
  end

  def from_omniauth(auth_hash)
    user = User.find_or_create_by(uid: auth_hash['uid'], provider: auth_hash['provider'])
    user.name = auth_hash['info']['name']
    user.image_url = auth_hash['info']['image']
    user.is_connect = true
    user.user_id = user.nil? ? nil : user.id
    user.save(:validate => false)
    user
  end

  def dis_connect(user_id, provider)
    user = User.find_by(user_id: user_id, provider: provider)
    user.is_connect = false
    user.save(:validate => false)
    user
  end

  private

  def get_social_location_for(provider, location_hash)
    case provider
      when 'linkedin'
        location_hash['name']
      else
        location_hash
    end
  end

  def get_social_url_for(provider, urls_hash)
    case provider
      when 'linkedin'
        urls_hash['public_profile']
      else
        urls_hash[provider.capitalize]
    end
  end

  def user_has_social(provider)
    user = User.find_by(user_id: current_user.id, provider: provider)

    if user.nil?
      user_social = User.find_by(id: current_user.id, provider: provider)
    else
      user_social = nil
    end

    user_social
  end
end
