echo "# 1 / 6: Dropping tables"
bundle exec rake db:drop
echo "# 2 / 6: Migrating tables"
bundle exec rake -v db:migrate
echo "# 3 / 6: Preparing test database"
bundle exec rake -v db:test:prepare
echo "# 4 / 6: Annotate model"
bundle exec annotate --position before
echo "# 5 / 6: Seeding tables"
bundle exec rake db:seed
echo "# 6 / 6: Running tests"
bundle exec rspec spec