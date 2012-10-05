# nanoc-OO [![Code Climate](https://codeclimate.com/badge.png)](https://codeclimate.com/github/sowcow/nanoc-oo)

* even more powerful nanoc (\*with object oriented taste\*)

* the main idea is to decouple Rules file to classes \<link to feature>

* by default files extensions are used to apply filters to layouts and items \<link to feature>

* **pending** (+item).children is filled with children by default; some dsl to reuse items by assigning them as children to other items; compiling is guided by children tree

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
 * silent `no compilation rules found` by introducing empty compilation rule in `UndefinedPage`?
 * use factories?  
 * require inside code
 * Rules file functions are passing params too much
 * Rules:`unless item.is_a? FakeDir` is not tested decision
 * unclear testing dependencies
 * require FileUtils?