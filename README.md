# nanoc-OO

the main idea is to decouple Rules file to classes

also by default files extensions *are* used to apply filters to layouts and items

TODO:
 
 * Rules file is running twice?
 * specs for UndefinedPage?
 * get rid of trash in Rules
 * cucumber features
 * items children, parent
 * check coverage
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
 
**?** `#binary?` through ptools or nanoc config
**?** `'some.erb'.html?`

*(to be continued)*