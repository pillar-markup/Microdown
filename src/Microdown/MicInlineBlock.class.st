"
I represent the tree node used to handle ""intra-line-markup"", emphasis, inline code, images and urls.


"
Class {
	#name : #MicInlineBlock,
	#superclass : #Object,
	#instVars : [
		'string',
		'start',
		'end',
		'kind',
		'next',
		'children'
	],
	#category : #'Microdown-Model'
}

{ #category : #accessing }
MicInlineBlock >> children [
	^ children
]

{ #category : #accessing }
MicInlineBlock >> children: anObject [
	children := anObject
]

{ #category : #accessing }
MicInlineBlock >> end [
	^ end
]

{ #category : #accessing }
MicInlineBlock >> end: anObject [
	end := anObject
]

{ #category : #accessing }
MicInlineBlock >> kind [
	^ kind
]

{ #category : #accessing }
MicInlineBlock >> kind: anObject [
	kind := anObject
]

{ #category : #accessing }
MicInlineBlock >> literal [
	^string copyFrom: start to: end. 
]

{ #category : #accessing }
MicInlineBlock >> next [
	^ next
]

{ #category : #accessing }
MicInlineBlock >> next: anObject [
	next := anObject
]

{ #category : #printing }
MicInlineBlock >> printOn: aStream [
	children
		ifNotNil: [ |preSpace| preSpace := false. aStream nextPut: $[.
			children
				do: [ :each | 
					preSpace ifTrue:[aStream nextPut: Character space] ifFalse: [ preSpace := true ].
					each printOn: aStream.].
			aStream nextPut: $] ]
		ifNil:
			[ start isNil | end isNil
				ifTrue: [ aStream << 'Uninitialized GHMInlineBlock' ] 
				ifFalse: [  
			start to: end do: [ :index | aStream nextPut: (string at: index) ] ]]
]

{ #category : #split }
MicInlineBlock >> split [
	"if there is any internal structure to the block, decompose it and add children"

	| parts |
	parts := MicIntraBlockSplitter  new splitString: self printString.
	parts size = 1 & (parts first kind = #Plain)
		ifTrue: [ ^ self ].
	self children: parts
]

{ #category : #accessing }
MicInlineBlock >> start [
	^ start
]

{ #category : #accessing }
MicInlineBlock >> start: anObject [
	start := anObject
]

{ #category : #accessing }
MicInlineBlock >> string [
	^ string
]

{ #category : #accessing }
MicInlineBlock >> string: anObject [
	string := anObject
]
