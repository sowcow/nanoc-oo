Feature: command line interface

  Scenario: nanoc output
    When $ nanoc-oo mysite
    Then the output should contain "Enjoy!"
    When $ nanoc-oo mysite
    Then the output should contain "already exists"

  Scenario: (no side effect between features I)
    When $ nanoc-oo thesite
    Then the output should contain "Enjoy!"
  Scenario: (no side effect between features II)
    When $ nanoc-oo thesite
    Then the output should contain "Enjoy!"    

  Scenario: create site
    When $ nanoc-oo site
    Then a file named "site/Rules" should exist
    And a file named "site/content/index.html" should exist

  Scenario: create blank site
    When $ nanoc-oo site --blank
    Then a file named "site/Rules" should exist
    And a file named "site/content/index.html" should not exist  

  Scenario: Rules file is replaced
    When $ nanoc-oo site
    Then the file "site/Rules" should contain "FakeItem"

  Scenario: it describes actions
    When $ nanoc-oo thesite
    Then the output should contain "force"
    Then the output should contain "classes"

  Scenario: it hides site name in paths
    When $ nanoc-oo MySite123
    Then the output should not contain "MySite123/"