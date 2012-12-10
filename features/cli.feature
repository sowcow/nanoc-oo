Feature: command line interface
  Scenario: nanoc output
    Given $ nanoc-oo mysite
    Then the output should contain "Enjoy!"
    When $ nanoc-oo mysite
    Then the output should contain "already exists"