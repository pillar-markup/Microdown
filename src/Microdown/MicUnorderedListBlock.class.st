"
I represent an unordered list of list items
"
Class {
	#name : #MicUnorderedListBlock,
	#superclass : #MicListBlock,
	#category : #'Microdown-Model'
}

{ #category : #testing }
MicUnorderedListBlock >> canConsumeLine: line [
	"to consume this line there must be a UnorderdListItem start at the right indentation"
	
	^ (super canConsumeLine: line) and: [line trim matchesRegex: '(^\* |^- | ^\+).*']
]

{ #category : #printing }
MicUnorderedListBlock >> printOn: aStream [

	aStream nextPutAll: 'UnorderedList'.
	
]
