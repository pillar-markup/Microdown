Extension { #name : 'MicListItemBlock' }

{ #category : '*Microdown-HTMLExporter' }
MicListItemBlock >> hasChildren [
	"Answer <true> if the receiver has any children"
	
	^ self children size > 1
]

{ #category : '*Microdown-HTMLExporter' }
MicListItemBlock >> hasNestedChildren [
	"Answer <true> if the receiver's children are list items and they are nested"

	^ (self children second isKindOf: MicListItemBlock) and: [
		self children second nestedLevel > self nestedLevel  ]
]

{ #category : '*Microdown-HTMLExporter' }
MicListItemBlock >> listItemText [

	^ text
]
