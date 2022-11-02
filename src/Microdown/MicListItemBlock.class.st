"
I represent one item in a list (ordered or non-ordered).

```
1. item 1
2. item 2
```
or 
```
- item 1
- item 2
```
are two lists containing 2 item list elements. 

An item list can be on multiple lines 

```
1. item 1 **foo**
   on the same item element
2. is another element
3. and a third one on 
   another line 
```

Please note that I can contain nested subelements and 

```
1. item 1 **foo**
   on the same item
  - sublevel item 1 **bold**
  - sublevel item 2
2. item 2
```

Therefore I expose two APIs:
- `children` which returns all the mic elements (for example the text and the nested lists)
- `textElements` which returns only the text elements (for example `item 1 **foo** on the same item`)
	
Pay attention my instance variable text is only used during the parsing time. 

"
Class {
	#name : #MicListItemBlock,
	#superclass : #MicAbstractBlock,
	#instVars : [
		'text',
		'textElements'
	],
	#category : #'Microdown-Model'
}

{ #category : #visiting }
MicListItemBlock >> accept: aVisitor [
 	^ aVisitor visitListItem: self
]

{ #category : #testing }
MicListItemBlock >> addLineAndReturnNextNode: line [
	"add line to this node. 
	Notice, the action is allowed to create new nodes in the block tree.
	Returns the node to handle next line - typically self."
	
	
	| normalized |
	text
		ifNil: [ text := line trim.
			^ self ].
	normalized := line copyFrom: parent indent + 1 to: line size.	"drop indent"
	"SD: I thought that a list item was holding a paragraph but it holds directly text."
		
	(self isAList: normalized)
		ifTrue: [ 
			self inlineParse: text.
			text := ''.
			^ self newBlockFor: normalized parent: self ]
		ifFalse: [ 
			"here we manage multiple lines list item."
			text := text , String cr , normalized ]
]

{ #category : #testing }
MicListItemBlock >> canConsumeLine: line [
	"return if this block can consume line"

	^ line beginsWith: (' ' repeat: parent indent)
]

{ #category : #visiting }
MicListItemBlock >> closeMe [

	super closeMe.
	self inlineParse: text
]

{ #category : #accessing }
MicListItemBlock >> computeNestedLevel [
	"An item has the same nested level than its parent."
	^ self parent computeNestedLevel
]

{ #category : #testing }
MicListItemBlock >> isAList: normalized [

	^ parser isAList: normalized
]

{ #category : #accessing }
MicListItemBlock >> nestedLevel [
	"Return the nesting level of main blocks. Basically only list increases this."
	
	^ self parent nestedLevel 
]

{ #category : #accessing }
MicListItemBlock >> testText [
	"I am used to make it easier to write tests"
	^ String streamContents: [ :str | children do: [ :each | str nextPutAll: each substring ] ]
]

{ #category : #accessing }
MicListItemBlock >> text [
	self deprecated: 'Use testText instead' transformWith: '`@rec text' -> '`@rec testText'.
	^ self testText 
]

{ #category : #accessing }
MicListItemBlock >> textElements [ 
	self deprecated: 'I should not be used, use children' transformWith: '`@rec textElements' -> '`@rec children'.
	^ children  
]
