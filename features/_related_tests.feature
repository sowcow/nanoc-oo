Feature: related tests

  Scenario Outline: nanoc is ok
    When I successfully run `ruby -S nanoc <command>`
    Then the output should contain "<success>"

    Examples:
      | command | success |
      |   -v    |   2007  |
      | cs temp |  Enjoy! |

      
  Scenario: wrapper is ok
    Given I have a blank wrapped nanoc site
    And a directory named "lib/classes" should exist
    And a file named "lib/classes/hide_all.rb" with:
      """
      class HideAll < Page
        GOOD_ID = // # any
        def route; nil end
      end
      """
    When I successfully compile it
    Then the file "output/index.html" should not exist
    Then the file "output/style.css" should not exist
    

  Scenario: steps are ok
    Given I have a default nanoc site
    When I successfully compile it
    Then a file named "output/index.html" should exist
    Then a file named "output/style.css" should exist    