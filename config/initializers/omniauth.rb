Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, 'sKyBr2qJcSomFRAQtWL1kk7Hb', '8REKiFEoUhLG8aahUDeyVMLJmekztgqzKn81Hzun4upSv38V90'

  provider :facebook, '1405057826175142', 'c1f2e703de5df8f94fa1a91666ba4917',
           scope: 'public_profile', info_fields: 'id,name,link,email'

  provider :google_oauth2, '645979484822-hl2mgkqe2pqnsfg4np578litliiqbn9v.apps.googleusercontent.com', 'Y9uEefF-FEfPMG5HY4F4UdjD',
           scope: 'profile', image_aspect_ratio: 'square', image_size: 48, access_type: 'online', name: 'google', skip_jwt: true

  provider :instagram, 'd4070a13123b4c1aa75a9c8d8c280067', 'bd9847360bcf4175bcb3400da11fe75b'

  OmniAuth.config.on_failure = Proc.new do |env|
    #SessionsController.action(:auth_failure).call(env)
  end
end