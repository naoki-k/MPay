# frozen_string_literal: true

source "https://rubygems.org"

git_source(:github) {|repo_name| "https://github.com/#{repo_name}" }

ruby "2.6.3"

gem "rails"

gem "postgresql"
gem "pg"
gem "haml-rails"
gem "bcrypt"
gem "bootsnap", require: false
gem "rails-i18n"
gem 'turbolinks'
gem 'sass-rails'
gem 'will_paginate',  '3.1.7'
gem "rmagick"
# rmagickがうまく入らないときは以下を試す
# $ brew install imagemagick@6
# $ PKG_CONFIG_PATH=/usr/local/opt/imagemagick@6/lib/pkgconfig gem install rmagick

group :development do
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw], group: :test
  gem "spring"
  gem "web-console", ">= 3.3.0"
  gem "faker", "2.1.2"
  gem "listen"
  gem "rails-erd"
end

group :test do
  gem "capybara"
  gem "webdrivers"
  gem "selenium-webdriver"
  gem "factory_bot_rails"
  gem "haml_lint"
  gem "rspec-rails"
  gem "rails-controller-testing"
  gem "faker", "2.1.2"
  gem 'database_cleaner'
end
