"
Delimiter definition for line break.
"
Class {
	#name : #MdsLineBreakDelimiter,
	#superclass : #MicAbstractDelimiter,
	#category : #'Microdown-MarkdownStrict'
}

{ #category : #applying }
MdsLineBreakDelimiter class >> applyOn: inlineParser [

	^ inlineParser processLineBreak
]

{ #category : #accessing }
MdsLineBreakDelimiter class >> associatedInlineBlock [

	^ MdsLineBreakBlock
]

{ #category : #accessing }
MdsLineBreakDelimiter class >> isCloser [

	^ true
]

{ #category : #accessing }
MdsLineBreakDelimiter class >> isOpener [

	^ true
]

{ #category : #accessing }
MdsLineBreakDelimiter class >> markup [

	^ #lineBreak
]

{ #category : #testing }
MdsLineBreakDelimiter class >> matches: aString [
	| indexOfCr |

	(aString size >= 3) ifFalse: [ ^ false ].
	
	indexOfCr := (aString indexOf: Character cr) - 1.
	indexOfCr < 2 ifTrue: [ ^ false ].
			
	^ (aString first: indexOfCr) allSatisfy: [ :each | each = Character space ]
]

{ #category : #accessing }
MdsLineBreakDelimiter class >> size [

	^ 1
]

{ #category : #accessing }
MdsLineBreakDelimiter class >> type [

	^ #lineBreak
]

{ #category : #adding }
MdsLineBreakDelimiter >> addInlineBlock: anIndex to: inlineParser [

	inlineParser addLineBreakInlineBlock: anIndex

]

{ #category : #accessing }
MdsLineBreakDelimiter >> endIndex [

	^ self index + self size
]
