Pretty reports
==============

The ultimate communication tool for all your reporting needs !

Setup
=====

1) Pull the code using the following command:

git pull https://github.com/diegoesp/pretty_reports.git

2) Configure RBEnv in your local system

3) Install the necessary bundles in your local project

bundle install --path vendor/bundle

4) Run the setup task for Pretty Reports. This will setup your databases and run both RSpec and cucumber tests

bundle exec rake pretty_reports:setup

5) Launch Unicorn (do not use WEBRick as we need multithreading for the PDFKit)

bundle exec unicorn_rails -c config/unicorn.conf.rb

You can now access Pretty Reports at http://localhost:3000. Prepare to be amazed !