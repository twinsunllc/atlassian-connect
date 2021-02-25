source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

gemspec

gem 'atlassian-jwt'

group :development do
  gem 'byebug'
  gem 'dotenv'
  gem 'sqlite3'
end

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'fabrication'
  gem 'rspec'
  gem 'rspec-rails'
  gem 'yaml_db'
end

group :test do
  gem 'capybara', '>= 3.26'
  gem 'selenium-webdriver'
  gem 'webdrivers'
end

