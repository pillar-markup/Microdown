"
# Markdown Parser and Elements

I'm a parser for markdown implemented by K. Osterbye and maintained enhanced by S. Ducasse. 
You are welcome to give an hand. 

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

# Todo
- make all the test green
- make the parser a bit more extensible (following the design of Pillar microdown grammar)
"
Class {
	#name : #ManifestGithubMarkdown,
	#superclass : #PackageManifest,
	#category : #'Microdown-Manifest'
}
