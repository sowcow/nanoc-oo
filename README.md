# nanoc-OO

[![Code Climate](https://codeclimate.com/badge.png)](https://codeclimate.com/github/sowcow/nanoc-oo)

the main idea is to decouple Rules file to classes

also by default files extensions *are* used to apply filters to layouts and items

TODO:
 
 * Rules file is running twice?
 * specs for UndefinedPage?
 * get rid of trash in Rules
 * cucumber features
 * items children, parent
 * check coverage
 * `#binary?` -> FakeItem (through ptools)
 * refactor:
   * specs:
     * refactor temp spec helpers
     * refactor specs with true/false variant arrays
     * use `context` properly (in specs)
     * specs want to be cleaned
     * refactor specs...
     * fix specs: `it 'should work'`, `it 'routes properly'`, ...
     * extract `"#{ SITE }/output/#{ name }..."`
     * tightly coupled specs?
 
**?** `'some.erb'.html?`

*(to be continued)*