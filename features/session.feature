Feature: Log into the system
  In order to use the system
  Users should be able to
  register, sign in, sign out, recover password

  Background:
    Given an user

  Scenario: User can sign in
    Given I sign in as "user"
    Then I should see "Welcome back"

  Scenario: User can update his preferences
    Given I sign in as "user"
    And I access my preferences page
    And I change my preferences first name and last name to "Lionel" and "Messi"
    And I sign in as "user"
    And I access the home page
    Then I should see "Lionel Messi"
    And I should see "Welcome back, Lionel"