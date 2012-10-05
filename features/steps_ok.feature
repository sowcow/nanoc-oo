Feature: steps are ok

  Scenario:
    Given I have a blank nanoc site
    When I successfully compile it
    Then it is successfully compiled