# Microdown Parser and Elements

[![Build Status](https://travis-ci.com/pillar-markup/Microdown.svg?branch=master)](https://travis-ci.com/pillar-markup/Microdown)

I'm a parser for microdown implemented by S. Ducasse, L. Dargaud and G. Polito. It is based on the work on markdown of K. Osterbye. 

Microdown is a smaller mardown but more extensible. 
It supports
- Header
- Lists
- Paragraph
- Code with arguments: key=val&key2=val2
- Quote
...
But also 
- Environment with arguments
- Table
- Anchor
- Annotated paragraph
- Math with arguments
- and more intra block elements such as extensible markups, raw, math, and references.


I follow the design mentioned in [https://github.github.com/gfm](https://github.github.com/gfm), in particular the parsing strategy in appendix A.

In short, the strategy is that at any point in time, we might have a number of children of the root which are ""open"". The deepest in open in the tree is called ""current"". All the parents of current are open. 

When a new line is read we do the following:

1. Check if the new line can be consumed by current.
	- as part of this a child of current can be made which can consume the new line
2. If current cannot consume the new line, we close current, move current to its parent, and repeat 1.
3. The root node can consume anything, for instance by making new nodes for storing the new line.
4. The roor node is not closed until input is exhausted

The other packages in this repository are the extensions made to produce Pillar model. 
Such packages should be moved in the future to other location (probably pillar itself).

## Loading

```
Metacello new
  baseline: 'Microdown';
  repository: 'github://pillar-markup/Microdown/src';
  load.
```
