"
I build the table of contents of a Microdown document: I visit its headers and nest them as a tree of `MicTocEntry`, by level, up to a limit level. I answer this tree as a document to render (`toc`) or as values for Mustache templates (`templateValues`).

## Life cycle: who creates me and who uses me

1. A client creates me with `new`, optionally sets the deepest header level to keep with `limitUpTo:` (6 by default), and sends me `visit:` with a document.
2. It then asks for the result: `tocItems` (the top entries), `toc` (a `MicRootBlock` holding a `MicTocEntryList`, that `MicHTMLVisitor` writes as nested lists), or `templateValues`.
3. `MicBookSitePublisher>>tableOfContentsOf:` uses `templateValues` to give the root template of each page its table of contents.
4. For the links of `templateValues` to work, the headers must be identified first by `MicHeaderIdentifier` (a separate pass).

## Responsibility:

- I nest the headers of a document by level, ignoring the ones deeper than my limit.
- I answer the table of contents for Mustache templates: dictionaries with `name`, `href`, `hasChildren` and `children`, as in `{{#children}}<a href=""{{href}}"">{{name}}</a>{{/children}}`.
- I link each entry to the target its header got from `MicHeaderIdentifier` (`MicHeaderIdentifier targetOf: aHeader`); I do not give ids myself.

## Collaborators: 

- `MicHeaderBlock`: the headers I collect.
- `MicTocEntry` and `MicTocEntryList`: the tree I build.
- `MicHeaderIdentifier`: gives the headers the targets my entries link to.

## Public API and Key Messages

- `limitUpTo: anInteger` keep the headers up to level anInteger (1 to 5).
- `visit: aDocument` collect its headers.
- `tocItems` the top entries; `toc` the table of contents as a document.
- `templateValues` the table of contents for templates.

## Examples

```
MicTocBuilder exampleOfAChapter templateValues
```

## Internal Representation

- `tocItems`: the top entries, an `OrderedCollection` of `MicTocEntry`.
- `headerStack`: the entries of the current branch while visiting, innermost on top.
- `limit`: the deepest header level kept.
"
Class {
	#name : 'MicTocBuilder',
	#superclass : 'MicrodownVisitor',
	#instVars : [
		'tocItems',
		'headerStack',
		'limit'
	],
	#category : 'Microdown-Toc',
	#package : 'Microdown-Toc'
}

{ #category : 'examples' }
MicTocBuilder class >> exampleOfAChapter [
	"A builder that collected the headers of a small chapter: one top entry with two children."

	<sampleInstance>
	^ self new
		  visit: (Microdown parse: '# Microdown syntax

## Text emphasis

Some text.

## Links and figures

More text.');
		  yourself
]

{ #category : 'initialization' }
MicTocBuilder >> initialize [

	super initialize.
	tocItems := OrderedCollection new.
	headerStack := Stack new.
	limit := 6
]

{ #category : 'configure' }
MicTocBuilder >> limitUpTo: anInteger [

	(anInteger between: 1 and: 5) ifFalse: [
		self error: 'Invalid input. Limit should be between 1 and 5' ].
	limit := anInteger
]

{ #category : 'template values' }
MicTocBuilder >> templateValues [
	"Answer the table of contents for Mustache templates: a dictionary whose children are its entries, each a dictionary with name, href, hasChildren and children. The href of an entry is the link target of its header (see MicHeaderIdentifier>>#identify:), nil when the header was not identified."

	^ Dictionary new
		  at: 'children'
		  put:
			  (tocItems
				   collect: [ :each | self templateValuesOf: each ]
				   as: Array);
		  yourself
]

{ #category : 'template values' }
MicTocBuilder >> templateValuesOf: aTocEntry [
	"Answer the template values of aTocEntry and of its children."

	| children |
	children := aTocEntry children
		            collect: [ :each | self templateValuesOf: each ]
		            as: Array.
	^ Dictionary new
		  at: 'name' put: aTocEntry header text;
		  at: 'href'
		  put:
			  ((MicHeaderIdentifier targetOf: aTocEntry header) ifNotNil: [
					   :target | '#' , target ]);
		  at: 'hasChildren' put: children isNotEmpty;
		  at: 'children' put: children;
		  yourself
]

{ #category : 'accessing' }
MicTocBuilder >> toc [

	^ MicRootBlock new children: { 
			(MicTocEntryList new 
				children: tocItems; yourself) } ; 
			yourself  
]

{ #category : 'accessing' }
MicTocBuilder >> tocItems [
	^ tocItems
]

{ #category : 'visiting' }
MicTocBuilder >> visitHeader: aMicHeader [
	"Add aMicHeader to the table of contents, in the last entry less deep than it, or as a top entry when there is none. Ignore it when it is deeper than my limit."

	| newTocEntry |
	aMicHeader level > limit ifTrue: [ ^ self ].
	newTocEntry := MicTocEntry new for: aMicHeader.
	[
		headerStack isNotEmpty and: [
			headerStack top level >= aMicHeader level ] ] whileTrue: [
		headerStack pop ].
	headerStack
		ifEmpty: [ tocItems add: newTocEntry ]
		ifNotEmpty: [ headerStack top addChild: newTocEntry ].
	headerStack push: newTocEntry
]
