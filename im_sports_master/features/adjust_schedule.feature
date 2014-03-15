Feature: Adjust the schedule of a division
  As a league administrator
  So that I can reschedule games if needed
  I want to be able to adjust the schedule of a division

  Background:
    Given the following users exist:
    | name       | email             | password  | password_confirmation  | admin  |
    | admin      | email@email.com   | password  | password               | true   |
    | user       | email2@email.com  | password  | password               | false  |

    Given the following leagues exist:
    | name    |
    | league1 |

    Given the following divisions exist:
    | name    | num_teams  | start_time  | end_time  | num_locations  | num_weeks | year | month | day | game_length  | league_id  |
    | testdiv | 8          | 8pm         | 10pm      | 2              | 2         | 2013 | 11    | 18  | 60           | 1          |
    | div2    | 2          | 8pm         | 9pm       | 1              | 1         | 2013 | 11    | 18  | 60           | 1          |

Scenario: A non-admin should not be able to see adjust schedule button
  Given I am on the home page
  And I follow "league1"
  And I follow "testdiv"
  And I follow "Placeholder Team 1 vs. Placeholder Team 2"
  Then I should not see "Edit Time"
  Given I am logged in as "email2@email.com" with password "password"
  And I am on the home page
  And I follow "league1"
  And I follow "testdiv"
  And I follow "Placeholder Team 1 vs. Placeholder Team 2"
  Then I should not see "Edit Time"

Scenario: An admin should be able to edit a game
  Given I am logged in as "email@email.com" with password "password"
  And I am on the home page
  And I follow "league1"
  And I follow "testdiv"
  And I follow "Placeholder Team 1 vs. Placeholder Team 2"
  When I follow "Edit"
  When I select "09" from "game[start_time(4i)]"
  And I select "00" from "game[start_time(5i)]"
  And I press "Save"
  Then I should see "Game was successfully updated."
  When I go to the home page
  And I follow "league1"
  And I follow "testdiv"
  And I follow "Placeholder Team 1 vs. Placeholder Team 2"
  Then I should see "09:00 AM"

Scenario: An admin adding a real location replaces placeholder locations
    Given I am logged in as "email@email.com" with password "password"
    And I am on the division page for "testdiv" of league "league1"
    When I fill in "new_location" with "RSF"
    And I press "Add Location"
    When I follow "Placeholder Team 1 vs. Placeholder Team 2"
    Then I should see "RSF"
    And I should not see "Placeholder Location 1"
    Given I am on the division page for "testdiv" of league "league1"
    When I follow "Placeholder Team 3 vs. Placeholder Team 4"
    Then I should see "RSF"
    And I should not see "Placeholder Location 1"
    Given I am on the division page for "testdiv" of league "league1"
    When I follow "Placeholder Team 5 vs. Placeholder Team 6"
    Then I should see "RSF"
    And I should not see "Placeholder Location 1"
    Given I am on the division page for "testdiv" of league "league1"
    When I follow "Placeholder Team 7 vs. Placeholder Team 8"
    Then I should see "RSF"
    And I should not see "Placeholder Location 1"
    Given I am on the division page for "testdiv" of league "league1"
    When I fill in "new_location" with "Haas"
    And I press "Add Location"
    When I follow "Placeholder Team 2 vs. Placeholder Team 3"
    Then I should see "Haas"
    And I should not see "Placeholder Location 2"
    Given I am on the division page for "testdiv" of league "league1"
    When I follow "Placeholder Team 4 vs. Placeholder Team 5"
    Then I should see "Haas"
    And I should not see "Placeholder Location 2"
    Given I am on the division page for "testdiv" of league "league1"
    When I follow "Placeholder Team 3 vs. Placeholder Team 4"
    Then I should see "RSF"
    And I should not see "Haas"
    And I should not see "Placeholder Location"

Scenario: An admin deleting a location restores placeholder locations
    Given I am logged in as "email@email.com" with password "password"
    And I am on the division page for "testdiv" of league "league1"
    When I fill in "new_location" with "RSF"
    And I press "Add Location"
    When I fill in "new_location" with "Haas"
    And I press "Add Location"
    And I press "Remove RSF"
    And I press "Haas"
    And I follow "Placeholder Team 1 vs. Placeholder Team 2"
    Then I should see "Placeholder Location 2"
    Given I am on the division page for "testdiv" of league "league1"
    And I follow "Placeholder Team 2 vs. Placeholder Team 3"
    Then I should see "Placeholder Location 1"
    Given I am on the division page for "testdiv" of league "league1"
    And I follow "Placeholder Team 3 vs. Placeholder Team 4"
    Then I should see "Placeholder Location 2"
    Given I am on the division page for "testdiv" of league "league1"
    And I follow "Placeholder Team 4 vs. Placeholder Team 5"
    Then I should see "Placeholder Location 1"

@javascript
Scenario: Can delete a game record
  Given I am logged in as "email@email.com" with password "password"
  And I am on the games page for division "div2" of league "league1"
  Then I should see "Placeholder Team 1"
  Then I should see "Placeholder Team 2"
  When I follow "Destroy"
  And I accept the alert
  Then I should be on the games page for division "div2" of league "league1"
  And I should not see "Placeholder Team 1"
  And I should not see "Placeholder Team 2"
