"
I represent a delimiter used in grammar. I'm abstract.
I'm useful for inline split parsing process.

Methods to overide:
- isCloser, isOpener: answer true or false whether am I a closing markup or an opening markup (I can be both for a format for instance, when markup is the same for both uses)
- type: my type name, as a symbol
- markup (a string)

isActive is true when I must be part of searched delimiters during normal inline split process.
(false for instance for delimiters relative to link or figure since they are analyzed in special procedure)

My index refers to the index character in global string which is parsed.

Always instantiate me with my constructor ""index:"" to precise it.
"
Class {
	#name : #MicAbstractDelimiter,
	#superclass : #Object,
	#instVars : [
		'index'
	],
	#pools : [
		'MicMicrodownSharedPool'
	],
	#category : #'Microdown-Parser'
}

{ #category : #accessing }
MicAbstractDelimiter class >> allActive [

	^ self allSubclasses select: [ :subclass | subclass isActive ]
]

{ #category : #'as yet unclassified' }
MicAbstractDelimiter class >> allRegex [
	^ ((self allActive collect: [ :del | |str| 
		str := WriteStream on: ''. 
		(del associatedInlineBlock 
			ifNil: [true] ifNotNil: [:block | block isEvaluated])
			ifTrue: [ 
				del markup do: [:char| str nextPut: $\;nextPut: char] ]
			ifFalse: [
				del markup do: [:char| str nextPut: $\;nextPut: char].
				del associatedInlineBlock new closingDelimiter in: [ :other |
					str nextPutAll: (self regExNot: other).
					other do: [:char| str nextPut: $\;nextPut: char].
					 ]
				]. 
		str contents]) joinUsing: '|') asRegex
	
]

{ #category : #accessing }
MicAbstractDelimiter class >> associatedInlineBlock [
	^ self subclassResponsibility
]

{ #category : #accessing }
MicAbstractDelimiter class >> associatedTypes [

	^ { self type }
]

{ #category : #accessing }
MicAbstractDelimiter class >> index: anIndex [
	^ self new index: anIndex; yourself
]

{ #category : #testing }
MicAbstractDelimiter class >> isActive [
	^ true
]

{ #category : #testing }
MicAbstractDelimiter class >> isBoth [
	^ self isCloser and: self isOpener
]

{ #category : #accessing }
MicAbstractDelimiter class >> isCloser [
	^ self subclassResponsibility 
]

{ #category : #testing }
MicAbstractDelimiter class >> isCloserOnly [
	^ self isCloser and: self isOpener not
]

{ #category : #accessing }
MicAbstractDelimiter class >> isOpener [
	^ self subclassResponsibility 
]

{ #category : #testing }
MicAbstractDelimiter class >> isOpenerOnly [
	^ self isCloser not and: [ self isOpener ]
]

{ #category : #accessing }
MicAbstractDelimiter class >> markup [
	^ self subclassResponsibility 
]

{ #category : #'as yet unclassified' }
MicAbstractDelimiter class >> rawStyleOpeningMarkups [
	^ self allActive select: [ :del | del isOpener and: [ del associatedInlineBlock isEvaluated not ] ]
]

{ #category : #'as yet unclassified' }
MicAbstractDelimiter class >> regExNot: markup [
	"return a regular expression (string), which is recognizing anything but markup"
	| str prefix|
	str := WriteStream on: ''.
	str nextPut: $(.
	prefix := ''.
	1 to: markup size do: [ :idx |
		str nextPutAll: prefix; nextPut: $[;nextPut: $^; nextPut: (markup at: idx); nextPut: $].
		prefix := '|', (markup copyFrom: 1 to: idx) escapeAll.
		 ].
	str nextPut: $);nextPut: $*.
	^ str contents
]

{ #category : #accessing }
MicAbstractDelimiter class >> size [
	^ self markup size
]

{ #category : #accessing }
MicAbstractDelimiter class >> type [
	^ self subclassResponsibility 
]

{ #category : #dispatching }
MicAbstractDelimiter >> addInlineBlock: anIndex to: inlineParser [

	inlineParser addRegularInlineBlock: anIndex
]

{ #category : #accessing }
MicAbstractDelimiter >> associatedInlineBlock [
	^ self class associatedInlineBlock 
]

{ #category : #accessing }
MicAbstractDelimiter >> endIndex [

	^ self index - 1
]

{ #category : #accessing }
MicAbstractDelimiter >> index [
	^ index
]

{ #category : #accessing }
MicAbstractDelimiter >> index: anInteger [
	index := anInteger
]

{ #category : #testing }
MicAbstractDelimiter >> isActive [
	^ self class isActive
]

{ #category : #testing }
MicAbstractDelimiter >> isCloser [
	^ self class isCloser
]

{ #category : #testing }
MicAbstractDelimiter >> isOpener [
	^ self class isOpener
]

{ #category : #testing }
MicAbstractDelimiter >> markup [
	^ self class markup
]

{ #category : #printing }
MicAbstractDelimiter >> printOn: aStream [
	| name |
	name := self class name.
	aStream nextPutAll: (self class name copyFrom: 4 to: name size - 'Delimiter' size ).
	aStream nextPut: $:; space ; nextPutAll: self markup
	
]

{ #category : #accessing }
MicAbstractDelimiter >> size [
	^ self class size
]

{ #category : #accessing }
MicAbstractDelimiter >> type [
	^ self class type
]
