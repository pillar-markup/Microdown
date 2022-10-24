"
I represent a reference to a section, figure, environment. I follow the pattern `*@`, label, `@*`

```
See *@fig1@*
```

"
Class {
	#name : #MicAnchorReferenceBlock,
	#superclass : #MicInlineElement,
	#instVars : [
		'reference'
	],
	#category : #'Microdown-ModelInline'
}

{ #category : #accessing }
MicAnchorReferenceBlock class >> closingDelimiter [

 	^ AnchorReferenceCloserMarkup
]

{ #category : #testing }
MicAnchorReferenceBlock class >> isEvaluated [
	^ false
]

{ #category : #accessing }
MicAnchorReferenceBlock class >> openingDelimiter [

 	^ AnchorReferenceOpenerMarkup
]

{ #category : #parsing }
MicAnchorReferenceBlock class >> parse: delimiter stream: aTokenStream for: aParser [

	^ aParser
		  parseNonEvaluatedBlock: self
		  token: delimiter
		  stream: aTokenStream
]

{ #category : #visiting }
MicAnchorReferenceBlock >> accept: aVisitor [
 	^ aVisitor visitAnchorReference: self
]

{ #category : #accessing }
MicAnchorReferenceBlock >> closingDelimiter [
	^ self class closingDelimiter
]

{ #category : #initialization }
MicAnchorReferenceBlock >> kind [

	^ #anchorReference
]

{ #category : #accessing }
MicAnchorReferenceBlock >> openingDelimiter [
	^ self class openingDelimiter
]

{ #category : #accessing }
MicAnchorReferenceBlock >> reference [
	^ reference
]

{ #category : #accessing }
MicAnchorReferenceBlock >> reference: aReference [
	reference := aReference
]

{ #category : #visiting }
MicAnchorReferenceBlock >> referenceAsHTML [	
	| ref |
	self flag: #todo.
	ref := self reference.
	(ref endsWith: '.md')
		ifTrue: [ ref := (ref copyUpToLast: $.) , '.html' ]
		ifFalse: [ Error signal: 'Reference : ' , ref , ' should end with .pillar or .pier' ].
	^ ref
]
