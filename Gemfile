source 'https://rubygems.org'

ruby '2.2.2'

gem 'rails', '4.2.5'

gem 'similar_text'

gem 'sass-rails', '~> 5.0'

gem 'coffee-rails', '~> 4.1.0'

gem 'jquery-rails'

gem 'jbuilder', '~> 2.0'

gem 'sdoc', '~> 0.4.0', group: :doc

gem 'bcrypt', '~> 3.1.7'
gem 'mailboxer'

source 'https://rails-assets.org' do
  gem 'rails-assets-moment'
  gem 'rails-assets-angular'
  gem 'rails-assets-angular-material', '~> 1.1.0.rc2'
end

gem 'sidekiq'

gem 'devise', '~> 4.0.0.rc2'
gem 'cancancan', '~> 1.8'

gem 'rerun'

group :development, :test do
  gem 'byebug'
  gem 'jasmine-rails'
end

group :development do
  gem 'web-console', '~> 2.0'
  gem 'spring'
  gem 'sqlite3'
end

group :test do
  gem 'test-unit'
  gem 'rspec-rails', '2.14'
  gem 'simplecov', :require => false
  gem 'cucumber-rails', :require => false
  gem 'cucumber-rails-training-wheels'
  gem 'capybara'
  gem 'poltergeist'
  gem 'database_cleaner'
  gem 'autotest-rails'
  gem 'factory_girl_rails'
  gem 'metric_fu'
  gem "codeclimate-test-reporter", :require => false
end

group :production do
  gem 'newrelic_rpm'
  gem 'rails_12factor'
  gem 'pg', '0.15.1'
end
