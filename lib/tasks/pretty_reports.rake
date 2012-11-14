require 'rake'
require 'rspec/core/rake_task'

namespace :pretty_reports do

  # Run a complete setup: re-create schema, prepare databases, seed, run tests, etc.
  task :setup => [:environment] do
    i = 1
    total = 5
    
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.clean

    puts "# #{i} / #{total}: Migrating tables"
    system "bundle exec rake db:migrate RAILS_ENV=development"
    i = i + 1
    
    puts "# #{i} / #{total}: Preparing test database"
    system "bundle exec rake db:test:prepare RAILS_ENV=development"
    i = i + 1

    puts "# #{i} / #{total}: Annotate model"
    system "bundle exec annotate --position before RAILS_ENV=development"
    i = i + 1

    puts "# #{i} / #{total}: Seeding tables"
    system "bundle exec rake db:seed RAILS_ENV=development"
    i = i + 1

    puts "# #{i} / #{total}: Running rspec tests"
    system "bundle exec rspec spec"
    i = i + 1
  end
  
  # Start unicorn multithreaded server as a daemon
  task :unicorn do
    system "bundle exec unicorn_rails -c config/unicorn.conf.rb -D"
  end

end