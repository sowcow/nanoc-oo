# nanoc-OO [![Code Climate](https://codeclimate.com/badge.png)](https://codeclimate.com/github/sowcow/nanoc-oo)

* even more powerful nanoc (\*with object oriented taste\*)

* the main idea is to decouple Rules file to classes \<link to feature>

* by default files extensions are used to apply filters to layouts and items \<link to feature>

* **pending** (+item).children is filled with children by default; some dsl to reuse items by assigning them as children to other items; compiling is guided by children tree

## todo:

1. children/parent
1. Rules file:
    * get rid of trash
    * is it running twice (rspec)?
1. cucumber features / examples
1. extract methods from step definitions?
1. layout in a class << !
1. decouple specs
1. ...

## notes:
 
### useful:

 * relative paths filter used by default
 * configureable

### cryptic:

 * specs for UndefinedPage?
 * unused Hidable
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
 * fakeitem ~ nanocitem
 * specs (lack of specification of code that is covered by features)
   * binary?
   * extension or ''
   * raw_content
   * EXT = , ID=nil, Page.create, ...
 * (+item).parent?