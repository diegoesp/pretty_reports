FactoryGirl.define do

  factory :user do
    first_name  "Trevor"
    last_name   "User"
    email       "user@prettyreports.com"
    password    "password"
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

end