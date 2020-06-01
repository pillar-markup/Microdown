"
I represent an ordered list of list items
"
Class {
	#name : #MicOrderedListBlock,
	#superclass : #MicListBlock,
	#instVars : [
		'startIndex'
	],
	#category : #'Microdown-Model'
}

{ #category : #testing }
MicOrderedListBlock >> addLineAndReturnNextNode: line [
	"Create a new item, and insert it into me."
	"line is on the format '1. item text'"

	self startIndexFrom: line.
	^ super addLineAndReturnNextNode: line
]

{ #category : #'as yet unclassified' }
MicOrderedListBlock >> asPillar [
	^ PROrderedList new
		setChildren: (self children collect: [ :child | child asPillar ]);
		counter: self startIndex;
		yourself
]

{ #category : #testing }
MicOrderedListBlock >> canConsumeLine: line [
	"to consume this line there must be a UnorderdListItem start at the right indentation"

	^ (super canConsumeLine: line) and: [line trim  prefixMatchesRegex: '\d+(\.|\))']
]

{ #category : #accessing }
MicOrderedListBlock >> startIndex [
	^ startIndex
]

{ #category : #accessing }
MicOrderedListBlock >> startIndexFrom: line [
	startIndex ifNotNil: [ ^self ].
	startIndex := line asInteger
]
