"
I represent the tree node used to handle ""intra-line-markup"", emphasis, inline code, images and urls.


"
Class {
	#name : #GHMInlineBlock,
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
GHMInlineBlock >> children [
	^ children
]

{ #category : #accessing }
GHMInlineBlock >> children: anObject [
	children := anObject
]

{ #category : #accessing }
GHMInlineBlock >> end [
	^ end
]

{ #category : #accessing }
GHMInlineBlock >> end: anObject [
	end := anObject
]

{ #category : #accessing }
GHMInlineBlock >> kind [
	^ kind
]

{ #category : #accessing }
GHMInlineBlock >> kind: anObject [
	kind := anObject
]

{ #category : #accessing }
GHMInlineBlock >> literal [
	^string copyFrom: start to: end. 
]

{ #category : #accessing }
GHMInlineBlock >> next [
	^ next
]

{ #category : #accessing }
GHMInlineBlock >> next: anObject [
	next := anObject
]

{ #category : #printing }
GHMInlineBlock >> printOn: aStream [
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
GHMInlineBlock >> split [
	"if there is any internal structure to the block, decompose it and add children"

	| parts |
	parts := GHMIntraBlockSplitter  new splitString: self printString.
	parts size = 1 & (parts first kind = #Plain)
		ifTrue: [ ^ self ].
	self children: parts
]

{ #category : #accessing }
GHMInlineBlock >> start [
	^ start
]

{ #category : #accessing }
GHMInlineBlock >> start: anObject [
	start := anObject
]

{ #category : #accessing }
GHMInlineBlock >> string [
	^ string
]

{ #category : #accessing }
GHMInlineBlock >> string: anObject [
	string := anObject
]
