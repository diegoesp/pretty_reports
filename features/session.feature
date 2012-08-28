Feature: Log into the system
  In order to use the system
  Users should be able to 
  register, sign in, sign out, recover password

  Scenario: User can sign in
    Given I am user "admin@prettyreports.com" with an account
    And I sign in
    Then I should see "Estas logeado como admin"