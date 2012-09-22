Feature: Report that a sprint finished
  In order to report that a sprint finished
  Users should be able to
  print a sprint release report

  Background:
    Given an admin
    And an user

  @javascript
  Scenario: User can create a report
    Given I sign in as "user"
    And I create a sprint release report
    Then one valid sprint release report should exist

  Scenario: A user can generate a PDF of his report
    Given a sprint release report created by "user"
    And I sign in as "user"
    When I download the first sprint release report
    Then I should receive a PDF

  Scenario: A user cannot access other users report
    Given a sprint release report created by "admin"
    And I sign in as "user"
    Then download of the first sprint release report should fail

  Scenario: a user should see three reports in his search page if he created three
    Given I sign in as "user"
    And a sprint release report created by "user"
    And a sprint release report created by "user"
    And a sprint release report created by "user"
    Then I should have 3 reports in my search page

  Scenario: An admin user should be able to see all reports for all users in his search page
    Given a sprint release report created by "admin"
    And a sprint release report created by "user"
    And I sign in as "admin"
    Then I should have 2 reports in my search page

  Scenario: A user should be able to see only his in his search page
    Given a sprint release report created by "admin"
    And a sprint release report created by "user"
    And I sign in as "user"
    Then I should have 1 report in my search page
