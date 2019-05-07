Feature: User login
  Background:
    Given User visits Login page

  Scenario Outline: User logs in
    When User logs in with <login> login and <password> password and <remember> remember me checkbox
    Then Login should be <state>

  Examples:
    | login      | password  | remember   | state      |
    | correct    | correct   | unchecked  | successful |
    | correct    | correct   | checked    | successful |
    | empty      | correct   | unchecked  | failed     |
    | correct    | empty     | unchecked  | failed     |
    | empty      | empty     | unchecked  | failed     |
    | correct    | incorrect | unchecked  | failed     |
    | incorrect  | correct   | unchecked  | failed     |
    | incorrect  | incorrect | unchecked  | failed     |

  Scenario: Previously logged in User is automatically logged in
    Given User logs in with correct login and correct password and checked remember me checkbox
    When  User reopens browser and opens Homepage
    Then  Login should be successful

  Scenario: User is not logged in automatically after logout
    Given User logs in with correct login and correct password and checked remember me checkbox
    And   User logs out
    When  User reopens browser and opens Homepage
    Then User should be logged out