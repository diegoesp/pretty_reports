FactoryGirl.define do

  factory :user do
    first_name    "Trevor"
    last_name     "User"
    email         "user@prettyreports.com"
    password      "password"
    confirmed_at  "2012-11-10 00:00:00"
  end

  factory :item do
    item_type   "feature"
    section     "delivered"
    title       "As a user I want"
    subtitle    "to log into the app"
    position    0
    report
  end

  factory :report do
    report_type   "sprint-release"
    title         "title"
    subtitle      "subtitle"
    user
  end

  factory :admin, :class => User do
    first_name    "Karl"
    last_name     "Admin"
    email         "admin@prettyreports.com"
    password      "password"
    admin         true
    confirmed_at  "2012-11-10 00:00:00"
  end

end