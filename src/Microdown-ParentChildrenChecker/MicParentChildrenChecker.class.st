Class {
	#name : 'MicParentChildrenChecker',
	#superclass : 'Object',
	#instVars : [
		'orphanList',
		'confusedKids'
	],
	#category : 'Microdown-ParentChildrenChecker',
	#package : 'Microdown-ParentChildrenChecker'
}

{ #category : 'visiting main API' }
MicParentChildrenChecker >> check: anElement [
	"Check if the parent of the element correctly includes this element as a child"

	anElement parent
		ifNil: [
			anElement class = MicRootBlock
				ifFalse: [ orphanList add: anElement ]
				ifTrue: [ anElement children do: [ :each | self check: each ] ] ]
		ifNotNil: [ :p | "We cannot identify bad parent that are refered by child not in the children
			list, because by construction the algo only considers the children of an element).  
			(p children includes: anElement) ifFalse: [ self addParent: p ]."
			p children do: [ :child |
				child parent = p ifFalse: [ confusedKids add: child ] ].

			anElement children do: [ :each | self check: each ] ]
]

{ #category : 'accessing' }
MicParentChildrenChecker >> confusedKids [

	^ confusedKids
]

{ #category : 'visiting main API' }
MicParentChildrenChecker >> initialize [

	super initialize.
	orphanList := OrderedCollection new.
	confusedKids := OrderedCollection new
]

{ #category : 'testing' }
MicParentChildrenChecker >> isOk [

	^ confusedKids isEmpty and:
		  (orphanList isEmpty and: [ confusedKids isEmpty ])
]

{ #category : 'accessing' }
MicParentChildrenChecker >> orphanList [
	^orphanList 
]
