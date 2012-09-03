Feature: Report that a sprint finished
  In order to report that a sprint finished
  Users should be able to
  send a sprint release report

  Scenario: User can generate the report
    Given I am an user
    And I sign in
    And I create a sprint release report
    When I download the sprint release report
    Then I should receive a PDF