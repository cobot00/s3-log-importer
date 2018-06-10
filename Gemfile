source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.1'

gem 'rails', '~> 5.2.0'
gem 'pg', '~> 1.0.0'
gem 'puma', '~> 3.11'

gem 'bootsnap', '>= 1.1.0', require: false
gem 'beautiful-log', '~> 0.2.2'

group :development, :test do
  gem 'rubocop', '0.49.1', require: false
  gem 'pry-rails', '~> 0.3.6'
  gem 'pry-byebug', '~> 3.4.2'
end

group :development, :test do
  gem 'rspec-rails', '~> 3.6.0'
  gem 'factory_bot_rails', '~> 4.10.0'
end

group :test do
  gem 'timecop', '~> 0.9.0'
  gem 'database_cleaner', '1.6.1'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
