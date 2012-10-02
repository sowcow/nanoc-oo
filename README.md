# nanoc-OO [![Code Climate](https://codeclimate.com/badge.png)](https://codeclimate.com/github/sowcow/nanoc-oo)

the main idea is to decouple Rules file to classes:
*(examples or features gonna be here)*

also by default files extensions *are* used to apply filters to layouts and items:
*(examples or features gonna be here)*

...


## todo:

1. children/parent
2. Rules file:
    * get rid of trash
    * is it running twice?
3. cucumber features / use cases
4. decouple specs
5. ...

## notes:
 
 * specs for UndefinedPage?
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
 * `'some.erb'.html?` 