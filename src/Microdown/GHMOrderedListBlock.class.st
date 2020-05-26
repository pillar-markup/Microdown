"
I represent an ordered list of list items
"
Class {
	#name : #GHMOrderedListBlock,
	#superclass : #GHMListBlock,
	#instVars : [
		'startIndex'
	],
	#category : #'Microdown-Model'
}

{ #category : #testing }
GHMOrderedListBlock >> addLineAndReturnNextNode: line [
	"Create a new item, and insert it into me."
	"line is on the format '1. item text'"

	self startIndexFrom: line.
	^ super addLineAndReturnNextNode: line
]

{ #category : #testing }
GHMOrderedListBlock >> canConsumeLine: line [
	"to consume this line there must be a UnorderdListItem start at the right indentation"

	^ (super canConsumeLine: line) and: [line trim  prefixMatchesRegex: '\d+(\.|\))']
]

{ #category : #accessing }
GHMOrderedListBlock >> startIndex [
	^ startIndex
]

{ #category : #accessing }
GHMOrderedListBlock >> startIndexFrom: line [
	startIndex ifNotNil: [ ^self ].
	startIndex := line asInteger
]
