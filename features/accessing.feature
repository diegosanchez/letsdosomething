Feature: Users access to web page, recovers forgotten password, logs in to the website

  Background:
    Given System's just started up

        Scenario: Not enrolled user signs in
          Given There is not users
          And   'John' clicked 'Sign Up'
          When  'John' sign up
          Then  'John' are logged in

        Scenario: Enrolled user can sign in
          Given 'John' is enrolled
          And   There not user logged in
          And   'John' visits logging page
          When  'John' signs in
          Then  'John' are logged in

        Scenario: Enrolled user forgot his password
          Given 'John' is enrolled
          And   'John' visits logging page
          When  'John' clicks 'forgot password?'
          Then  'John' receives 'Reset password instructions'
          And   'John' clicks 'Change my password' on mail
          And   'John' fills form with password 'stronger_password'
          And   'John' new password is 'stronger_password'
          
          
