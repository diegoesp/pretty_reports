# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

report1 = Report.create({id: 1, report_type: 'sprint-release', content: 'sprint release report'})
report2 = Report.create({id: 2, report_type: 'sprint-definition', content: 'sprint definition report'})

items = Item.create([
  {item_type: 'bug', content: 'Not working on IE7'},
  {item_type: 'bug', content: 'Not resizing'},
  {item_type: 'feature', content: 'Let the user select zones'},

  {item_type: 'bug', content: 'Not working when resizing'},
  {item_type: 'feature', content: 'As a user I want to select multiple languages'},
  {item_type: 'task', content: 'Add rspec to the project'}
])

items[0].report_id = report1
items[1].report_id = report1.id
items[2].report_id = report1.id

items[3].report_id = report2.id
items[4].report_id = report2.id
items[5].report_id = report2.id

items.each {|item| item.save }


