Feature: nanoc is ok

  Scenario Outline:
    When I successfully run `ruby -S nanoc <command>`
    Then the output should contain "<success>"

    Examples:
      | command | success |
      |   -v    |   2007  |
      | cs temp |  Enjoy! |