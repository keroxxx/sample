source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.2'


gem 'rails',            '~> 6.0.3', '>= 6.0.3.4'
gem 'puma',             '~> 4.1'
gem 'sass-rails',       '>= 6'
gem 'webpacker',        '~> 4.0'
gem 'turbolinks',       '~> 5'
gem 'jbuilder',         '~> 2.7'
gem 'bcrypt',           '~> 3.1.7'
gem 'aws-sdk-s3',              '1.46.0', require: false
gem 'image_processing', '~> 1.2'
gem 'active_storage_validations', '0.8.2'
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
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'webdrivers'
  gem 'rails-controller-testing'
  gem 'minitest'
  gem 'minitest-reporters'
  gem 'guard'
  gem 'guard-minitest'
end

group :produciton do
  gem 'mysql2'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]