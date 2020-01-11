source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.5'

gem 'rails', '~> 6.0.1'

gem 'pg', '>= 0.18', '< 2.0'
gem 'pg_search'
gem 'puma', '~> 4.3'
gem 'bootsnap', '>= 1.4.2', require: false
gem 'sass-rails', '>= 6'
gem 'webpacker', '~> 4.0'
gem 'turbolinks', '~> 5'
gem 'redis', '~> 4.0'
gem 'dotenv-rails'
gem 'dalli', '~> 2.7.9'
gem 'annotate', group: :development

gem 'image_processing', '~> 1.2'
gem 'aws-sdk-s3', require: false

gem 'sidekiq'
gem 'sidekiq-limit_fetch', '~> 3.4.0'
gem 'sinatra', require: false

gem 'devise', git: 'https://github.com/plataformatec/devise'
gem 'pundit'

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
gem 'paper_trail', '~> 10.2'
gem 'cpf_cnpj', '~> 0.5.0'
gem 'draper'
gem 'pagy', '~> 3.5'
gem 'has_scope'
gem 'ajax-datatables-rails'
gem 'i18n'
gem 'rails-i18n', '~> 6.0.0'
gem 'slim-rails'
gem 'simple_form'
gem 'lograge'
gem 'logstash-event'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'table_print', '~> 1.5.6'
  gem 'pry-rails', '~> 0.3.9'
  gem 'pry-byebug'
  gem 'pry-stack_explorer'

  gem 'database_cleaner'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'rspec-rails'
  gem 'rspec-collection_matchers'
  gem 'shoulda-matchers'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'web-console', '>= 3.3.0'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  gem 'webdrivers'
end
