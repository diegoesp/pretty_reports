namespace :pretty_reports do

  task :setup do
    i = 1
    total = 7

    puts "# #{i} / #{total}: Dropping tables"
    system "bundle exec rake db:drop RAILS_ENV=development"
    # Rake::Task["db:drop"].invoke
    i = i + 1
    
    puts "# #{i} / #{total}: Migrating tables"
    system "bundle exec rake db:migrate RAILS_ENV=development"
    # Rake::Task["db:migrate"].invoke
    i = i + 1
    
    puts "# #{i} / #{total}: Preparing test database"
    system "bundle exec rake db:test:prepare RAILS_ENV=development"
    # Rake::Task["db:test:prepare"].invoke
    i = i + 1

    puts "# #{i} / #{total}: Annotate model"
    system "bundle exec annotate --position before RAILS_ENV=development"
    i = i + 1

    puts "# #{i} / #{total}: Seeding tables"
    system "bundle exec rake db:seed RAILS_ENV=development" # Rake::Task["db:seed"].invoke
    i = i + 1

    puts "# #{i} / #{total}: Running rspec tests"
    system "bundle exec rspec spec --color"
    i = i + 1

    puts "# #{i} / #{total}: Running cucumber tests"
    system "bundle exec cucumber RAILS_ENV=test"
  end
  
end