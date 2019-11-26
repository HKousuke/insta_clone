Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['0123456789'], ENV['0123456789']
end