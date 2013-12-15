auth_credentials = YAML.load_file("#{Rails.root}/config/resque_auth.yml")[Rails.env].symbolize_keys

Resque::Server.use(Rack::Auth::Basic) do |user, password|
  user == auth_credentials[:user].to_s
  password == auth_credentials[:password].to_s
end