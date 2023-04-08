@data_security
Feature: Data confidentiality
  Verify that the application does not allow the browser to cache sensitive data

  @iriusrisk-cwe-525
  Scenario Outline: Prevent browser caching of sensitive data
    Given a new browser instance
    And the client/browser is configured to use an intercepting proxy
    And the login page
    And the username <username> is used
    And the password <password> is used
    When the user logs in
    And the proxy logs are cleared
    And they access the restricted resource: <method>
    And the response that contains the string: <sensitiveData> is recorded
    Then the HTTP Cache-control header has the value: no-cache, no-store, must-revalidate
    And the HTTP Pragma header has the value: no-cache
    Examples:
      | method              | username   | password   | sensitiveData               |
      | viewBobsProfile     | bob        | password   | Robert                      |
      # teste de password vazia
      | viewAlicesProfile	| alice	     |            |	Alice@website.com           |
      # teste de password pequena
      | viewAlicesProfile	| alice	     | p          |	Alice@website.com           |
      # teste de username vazio
      | viewBobsMessages    | 	         | password	  | Bob                         |
      # teste de username pequeno
      | viewBobsMessages    | b          | password	  | Bob                         |
      # teste de username com caractere especial
      | viewAlicesProfile    | 4l1c&     | password   | Alice@website.com           |    