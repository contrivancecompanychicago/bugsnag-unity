Feature: Handled Errors and Exceptions

Scenario Outline: Reporting a handled exception
  When I run the <platform> application
  Then I should receive a request
  And the request is a valid for the error reporting API
  And the "Bugsnag-API-Key" header equals "a35a2a72bd230ac0aa0f52715bbdc6aa"
  And the payload field "notifier.name" equals "Unity Bugsnag Notifier"
  And the payload field "events" is an array with 1 element
  And the exception "errorClass" equals "System.Exception"
  And the exception "message" equals "blorb"

@android
Examples:
  | platform  |
  | Android   |

@macos
Examples:
  | platform  |
  | MacOS     |
