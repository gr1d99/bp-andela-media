source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.3'

gem 'rails', '~> 5.2.1'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 3.11'
gem 'pry-rails', '~> 0.3.7'
gem 'bootsnap', '>= 1.1.0', require: false
gem 'rack-cors', '~> 1.0', '>= 1.0.2'
gem 'foreman', '~> 0.85.0'
gem 'active_model_serializers', '~> 0.10.0'
gem 'acts-as-taggable-on', '~> 6.0'
gem 'reform', '~> 2.2', '>= 2.2.4'
gem 'reform-rails'

group :development, :test do
  gem 'rubocop', require: false
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails', '~> 3.8'
  gem 'simplecov', require: false
  gem 'factory_bot_rails'
  gem 'faker'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'shoulda-matchers', '~> 3.1'
  gem 'database_cleaner'
  gem 'guard-rspec', require: false
end
