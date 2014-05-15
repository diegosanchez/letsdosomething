Feature: Users can advocate a complaint or relinquish it

  Background:
    Given 'Chad' is enrolled
    And   'John' is enrolled
    Given 'Chad complaint' was written
    And   'John complaint' was written
    And   'Brad' is enrolled

  @javascript
  Scenario: User advocates a complaint
    When  'Brad' signs in 
    And   User visits 'complaints'
    And   'Brad' advocates 'Chad complaint'
    Then  'Chad complaint' contains 'Brad' as advocator

  @javascript
  Scenario: User relinquishes a complaint
    Given   'Brad' advocated 'Chad complaint'
    And     'Brad' signs in 
    And     User visits 'complaints'
    When     'Brad' relinquishes 'Chad complaint'
    Then    'Chad complaint' doesn't contain 'Brad' as advocator any more

