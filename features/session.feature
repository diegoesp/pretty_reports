Feature: Log into the system
  In order to use the system
  Users should be able to 
  register, sign in, sign out, recover password

  Background:
    Given an user

  Scenario: User can sign in
    Given I sign in as "user"
    Then I should see "Welcome back"