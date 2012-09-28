Feature: simple paginating

  Scenario:
    Given the file named "lib/classes/articles.rb" with:
      """ruby
      class Article < Page
        GOOD_ID = %r|^/articles/.|
        
        def preprocess
          
        end
      end
      """
    And the following articles exist:  //////////////   Scenario outlines ?
      |       file            | paragraph_count |
      | articles/article_1.md |        1        |
      | articles/ten.md    |       10        |
      | articles/third.md  |       25        |
      | articles/third.md  |       50        |
      | articles/third.md  |       100       |
    When I run `nanoc compile`
    Then