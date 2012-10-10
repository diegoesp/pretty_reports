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

  Scenario: A user can generate an HTML of his report
    Given a sprint release report created by "user"
    And I sign in as "user"
    When I access the first HTML sprint release report
    Then I should receive an HTML report

  # Scenario: A user can generate a PDF of his report
  #   Given a sprint release report created by "user"
  #   And I sign in as "user"
  #   When I download the first sprint release report
  #   Then I should receive a PDF report

  Scenario: A user cannot access other users report
    Given a sprint release report created by "admin"
    And I sign in as "user"
    Then download of the first sprint release report should fail

  Scenario: A user must be logged in to get a PDF
    Given a sprint release report created by "user"
    When I download the first sprint release report
    Then I should be required to sign

  Scenario: a user should see three reports in his search page if he created three
    Given I sign in as "user"
    And a sprint release report created by "user"
    And a sprint release report created by "user"
    And a sprint release report created by "user"
    Then I should have 3 reports in my search page

  Scenario: A user should be able to see only his reports in his search page
    Given a sprint release report created by "admin"
    And a sprint release report created by "user"
    And I sign in as "user"
    Then I should have 1 report in my search page