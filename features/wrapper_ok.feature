Feature: wrapper is ok

  Scenario:
    Given I have a wrapped nanoc site
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