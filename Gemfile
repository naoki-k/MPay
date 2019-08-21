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

group :development do
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw], group: :test
  gem "spring"
  gem "web-console", ">= 3.3.0"
  gem "faker", "1.7.3"
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
end
