# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create!(:first_name => "John", :last_name => "Admin", :email => "admin@prettyreports.com", :password => "password", :admin => true, :confirmed_at => "2012-11-10 00:00:00")
User.create!(:first_name => "Trevor", :last_name => "User", :email => "user@prettyreports.com", :password => "password", :admin => false, :confirmed_at => "2012-11-10 00:00:00")