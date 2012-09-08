Feature: Log into the system
  In order to use the system
  Users should be able to 
  register, sign in, sign out, recover password

  Scenario: User can sign in
    Given I am an admin user
    And I sign in
    Then I should see "Estas logeado como admin"