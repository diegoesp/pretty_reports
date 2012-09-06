echo "# 1 / 7: Dropping tables"
bundle exec rake db:drop
echo "# 2 / 7: Migrating tables"
bundle exec rake -v db:migrate
echo "# 3 / 7: Preparing test database"
bundle exec rake -v db:test:prepare
echo "# 4 / 7: Annotate model"
bundle exec annotate --position before
echo "# 5 / 7: Seeding tables"
bundle exec rake db:seed
echo "# 6 / 7: Running rspec tests"
bundle exec rspec spec --color
echo "# 7 / 7: Running cucumber tests"
bundle exec rake cucumber