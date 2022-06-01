"
Delimiter definition for line break.
"
Class {
	#name : #MacLineBreakDelimiter,
	#superclass : #MicAbstractDelimiter,
	#category : #'Microdown-Macrodown'
}

{ #category : #applying }
MacLineBreakDelimiter class >> applyOn: inlineParser [

	^ inlineParser processLineBreak
]

{ #category : #accessing }
MacLineBreakDelimiter class >> associatedInlineBlock [

	^ MacLineBreakBlock
]

{ #category : #accessing }
MacLineBreakDelimiter class >> isCloser [

	^ true
]

{ #category : #accessing }
MacLineBreakDelimiter class >> isOpener [

	^ true
]

{ #category : #accessing }
MacLineBreakDelimiter class >> markup [

	^ #lineBreak
]

{ #category : #testing }
MacLineBreakDelimiter class >> matches: aString [
	| indexOfCr |

	(aString size >= 3) ifFalse: [ ^ false ].
	
	indexOfCr := (aString indexOf: Character cr) - 1.
	indexOfCr < 2 ifTrue: [ ^ false ].
			
	^ (aString first: indexOfCr) allSatisfy: [ :each | each = Character space ]
]

{ #category : #accessing }
MacLineBreakDelimiter class >> size [

	^ 1
]

{ #category : #accessing }
MacLineBreakDelimiter class >> type [

	^ #lineBreak
]

{ #category : #adding }
MacLineBreakDelimiter >> addInlineBlock: anIndex to: inlineParser [

	inlineParser addLineBreakInlineBlock: anIndex

]

{ #category : #accessing }
MacLineBreakDelimiter >> endIndex [

	^ self index + self size
]
