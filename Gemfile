source 'https://rubygems.org'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'jquery-rails'
gem 'rails', '3.2.6'
gem 'bourbon'
gem 'bootstrap-sass', '2.0.3.1'
gem 'pg'
gem 'jquery-ui-rails'
gem 'activeadmin'
gem "meta_search",    '>= 1.1.0.pre'
gem "pdfkit"

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  gem 'therubyracer', :platforms => :ruby
  gem 'uglifier', '>= 1.0.3'
end

group :test, :development do
  gem "rspec-rails"
  gem 'sqlite3'  
end

group :development do
  gem 'annotate', '2.4.1.beta1'
  # For PDFKit tests
  gem "unicorn"
  gem "hirb"            # Rails console beautifier: require "hirb" / Hirb.enable
end

group :test do
  gem 'capybara'                            # Driver for testing web apps and javascript via selenium
  gem 'launchy'                             # Launches the web browser via automation
  gem 'database_cleaner'                    # Resets database between tests
  gem 'turn', :require => false             # Better formatted test reports
  gem 'minitest'                            # Support for cucumber  
  gem 'cucumber-rails', :require => false   # Allows to use cucumber DSL  
  gem "pdf-reader"                          # for PDF testing
end 