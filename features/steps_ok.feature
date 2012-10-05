Feature: steps are ok

  Scenario:
    Given I have a default nanoc site
    When I successfully compile it
    Then a file named "output/index.html" should exist
    Then a file named "output/style.css" should exist