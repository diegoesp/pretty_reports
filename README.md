Pretty reports
==============

The ultimate communication tool for all your reporting needs !

Setup
=====

1) Pull the code using the following command:

git clone https://github.com/diegoesp/pretty_reports.git

2) Configure RBEnv in your local system

Use this guide: https://github.com/diegoesp/pretty_reports/wiki/Rbenv-configuration

3) Install PostgreSQL

Pretty Reports runs by default on 9.1. You can use this: https://github.com/diegoesp/pretty_reports/wiki/Setup-PostgreSQL-Ubuntu-Server

You must configure two databases:

* pretty_reports_development: User prdev, password prdev
* pretty_reports_test: User prtest, password prtest

You can follow this guide for doing so: http://www.cyberciti.biz/faq/howto-add-postgresql-user-account/

3) Install the necessary bundles in your local project

bundle install --path vendor/bundle

Remember that you must have configured:

* nokogiri: install build-essential and libxml2-dev / libxslt-dev packages
* PostgreSQL: At this point the pg gem will fail if you have not installed PostgreSQL on your system

4) Run the setup task for Pretty Reports. This will setup your databases and run both RSpec and cucumber tests

bundle cat exec rake pretty_reports:setup

5) Launch Unicorn (do not use WEBRick as we need multithreading for the PDFKit)

bundle exec unicorn_rails -c config/unicorn.conf.rb

You can now access Pretty Reports at http://localhost:3000. Prepare to be amazed !