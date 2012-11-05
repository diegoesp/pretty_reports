namespace :pretty_reports do

  # Run a complete setup: re-create schema, prepare databases, seed, run tests, etc.
  task :setup do
    i = 1
    total = 5
    
    # system "bundle exec rake db:drop RAILS_ENV=development"

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
    system "bundle exec rspec spec --color"
    i = i + 1
  end
  
  # Start unicorn multithreaded server
  task :unicorn do
    system "bundle exec unicorn_rails -c config/unicorn.conf.rb -D"
  end
end