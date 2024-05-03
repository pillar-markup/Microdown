Class {
	#name : 'MicParentChildrenChecker',
	#superclass : 'MicrodownVisitor',
	#instVars : [
		'orphanList',
		'badReferencingParentList',
		'confusedKids'
	],
	#category : 'Microdown-ParentChildrenChecker',
	#package : 'Microdown-ParentChildrenChecker'
}

{ #category : 'visiting main API' }
MicParentChildrenChecker >> addChild: aChild [ 
	orphanList add: aChild .
]

{ #category : 'visiting main API' }
MicParentChildrenChecker >> addParent: aParent [ 
	badReferencingParentList add: aParent .
]

{ #category : 'testing' }
MicParentChildrenChecker >> badReferencingParentList [

	^ badReferencingParentList
]

{ #category : 'visiting main API' }
MicParentChildrenChecker >> childrenList [
    ^ orphanList 
]

{ #category : 'visiting main API' }
MicParentChildrenChecker >> childrenList: anObject [
    orphanList := anObject 
]

{ #category : 'testing' }
MicParentChildrenChecker >> confusedKids [

	^ confusedKids
]

{ #category : 'visiting main API' }
MicParentChildrenChecker >> initialize [

	super initialize.
	orphanList := OrderedCollection new.
	badReferencingParentList := OrderedCollection new.
	confusedKids := OrderedCollection new
]

{ #category : 'testing' }
MicParentChildrenChecker >> isOk [

	^ badReferencingParentList isEmpty and:
		  ( orphanList isEmpty  and: [ confusedKids isEmpty ])
]

{ #category : 'testing' }
MicParentChildrenChecker >> orphanList [
	^orphanList 
]

{ #category : 'visiting main API' }
MicParentChildrenChecker >> parentsList [
    ^ badReferencingParentList 
]

{ #category : 'visiting main API' }
MicParentChildrenChecker >> parentsList: anObject [
    badReferencingParentList := anObject 
]

{ #category : 'visiting main API' }
MicParentChildrenChecker >> visit: anElement [
	"Check if the parent of the element correctly includes this element as a child"

	anElement parent
		ifNil: [
			anElement class = MicRootBlock
				ifFalse: [ orphanList add: anElement ]
				ifTrue: [ anElement children do: [ :each | self visit: each ] ] ]
		ifNotNil: [ :p |
			"We cannot identify bad parent that are refered by child not in the children
			list, because by construction the algo only considers the children of an element).  
			(p children includes: anElement) ifFalse: [ self addParent: p ]."

			p children do: [ :child |
				child parent = p ifFalse: [ confusedKids addChild: child ] ].

			anElement children do: [ :each | self visit: each ] ]
]
