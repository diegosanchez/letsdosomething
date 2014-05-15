Feature: Users access to homepage and have to see most popular complaints

  Background:
    Given 'Chad' is enrolled
    And   bunch of user enrolled
    And   'Chad complaint' was written

  Scenario: User visit home page
    When  'Brad' signs in 
    And   visit 'home page'
    Then  should see 'Chad complaint'

