source "https://rubygems.org"

gem "rails", "~> 8.0.2"

gem "mysql2", "~> 0.5"
gem "puma", ">= 5.0"
gem "tzinfo-data", platforms: %i[ windows jruby ]
gem "solid_cache"
gem "solid_queue"
gem "solid_cable"
gem "bootsnap", require: false
gem "kamal", require: false
gem "thruster", require: false

# Auth
gem "devise_token_auth", "~> 1.2.5"

# Cors
gem "rack-cors", "~> 2.0.2"

group :development, :test do
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"
  gem "brakeman", require: false
  gem "rubocop-rails-omakase", require: false
  gem "rspec-rails", "~> 8.0.0"
  gem "factory_bot_rails", "~> 6.4.4"
  gem "shoulda-matchers", "~> 5.3.0"
end
