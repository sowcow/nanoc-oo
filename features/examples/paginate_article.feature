@wip
Feature: paginate article example

  Scenario:
    Given I have a blank wrapped nanoc site
    And a file named "content/article.html.md" with:
      """
      # First Header

      ...

      # Second Header

      ...

      # Third Header

      ...

      """
    And a file named "lib/classes/articles.rb" with:
      """
      class Article < Page
        GOOD_ID = %r|^/[^/]+/$| # one level deep
        
        def preprocess context
          pages(item.raw_content).each_with_index do |page,index|
            context.items << Nanoc::Item.new(page, {}, %"#{identifier}#{index+1}/")
          end
        end

        private
        def pages content
          content.scan(/# .+?(?:(?=# )|\z)/m).map &:strip
        end
      end

      class ArticlePage < Page
        GOOD_ID = //
        PRIORITY = -1  # any non Article
        EXT = 'html'

        def preprocess *a; nil end
      end
      """
    When I successfully compile it
    Then the following files should exist:
      |  output/article/index.html  |
      | output/article/1/index.html |
      | output/article/2/index.html |
      | output/article/3/index.html |
    And the file "output/article/index.html" should contain exactly:
      """
      # First Header

      ...
      """
    And the file "output/article/1/index.html" should contain exactly:
      """
      # First Header

      ...
      """
    And the file "output/article/2/index.html" should contain exactly:
      """
      # Second Header

      ...
      """
    And the file "output/article/3/index.html" should contain exactly:
      """
      # Third Header

      ...
      """

