Feature: Users can browse, list, create and edit complaints
  Users, even those who are neither logged in nor enrolled, can browse complaints.
  Logged in user are able to create and edit his own complaints and advocates
  other's complaints.

  Background:
    Given 'Chad' is enrolled
    And   'John' is enrolled
    Given 'Chad complaint' was written
    And   'John complaint' was written

  Scenario: User access complaints list
    When  User visits 'complaints'
    Then  User sees 'chad' complaints and it's advocators
    And   User sees 'john' complaints and it's advocators

  Scenario: 'John' create a complaint through form
    Given 'John' signs in
    And   'John' visits new complaint page
    When  'John' writes the 'my second complaint'
    Then  'John' sees the complaint titled 'my second complaint'
          
