# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

plan1 = Plan.create!(:name => "Basic", :cost => 1.99, :active => true)
plan2 = Plan.create!(:name => "Intensive", :cost => 4.99, :active => true)
plan3 = Plan.create!(:name => "Full", :cost => 9.99, :active => true)

User.create!(:email => "admin@prettyreports.com", :password => "password", :admin => true, :plan => plan3)
User.create!(:email => "user@prettyreports.com", :password => "password", :admin => false, :plan => plan2)