echo "# 1 / 5: Droping tables"
bundle exec rake db:drop
echo "# 2 / 5: Migrating tables"
bundle exec rake -v db:migrate
echo "# 3 / 5: Preparing test database"
bundle exec rake -v db:test:prepare
echo "# 4 / 5: Seeding tables"
bundle exec rake db:seed
echo "# 5 / 5: Running tests"
bundle exec rspec spec