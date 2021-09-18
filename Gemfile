source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

gem 'rails',            '~> 6.0.3', '>= 6.0.3.4'
gem 'puma',             '4.3.6'
gem 'sass-rails',       '>= 6'
gem 'webpacker',        '4.0.7'
gem 'turbolinks',       '5.2.0'
gem 'jbuilder',         '2.9.1'
gem 'bcrypt',           '~> 3.1.7'
gem 'fog-aws'
gem 'carrierwave'
gem 'mini_magick'
gem 'bootstrap-sass'
gem 'will_paginate'
gem 'bootstrap-will_paginate'
gem 'faker'
gem 'dotenv-rails'
gem 'rails-i18n'
gem 'bootsnap',         '>= 1.4.2', require: false

group :development, :test do
  gem 'mysql2'
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'factory_bot_rails'
  gem 'rspec-rails'
  gem 'capybara'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'rubocop-rspec', require: false
end

group :test do
  gem 'selenium-webdriver'
  gem 'webdrivers'
end

group :produciton do
  gem 'mysql2'
  gem 'puma_worker_killer'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]