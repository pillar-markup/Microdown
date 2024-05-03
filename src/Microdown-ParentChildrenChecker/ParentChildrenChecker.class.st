Class {
	#name : 'ParentChildrenChecker',
	#superclass : 'MicrodownVisitor',
	#instVars : [
		'childrenList',
		'parentsList'
	],
	#category : 'Microdown-ParentChildrenChecker',
	#package : 'Microdown-ParentChildrenChecker'
}

{ #category : 'visiting main API' }
ParentChildrenChecker >> addChild: aChild [ 
	childrenList add: aChild .
]

{ #category : 'visiting main API' }
ParentChildrenChecker >> addParent: aParent [ 
	parentsList add: aParent .
]

{ #category : 'visiting main API' }
ParentChildrenChecker >> childrenList [
    ^ childrenList 
]

{ #category : 'visiting main API' }
ParentChildrenChecker >> childrenList: anObject [
    childrenList := anObject 
]

{ #category : 'visiting main API' }
ParentChildrenChecker >> initialize [
    super initialize.
    childrenList := OrderedCollection new.
    parentsList := OrderedCollection new.
]

{ #category : 'visiting main API' }
ParentChildrenChecker >> parentsList [
    ^ parentsList 
]

{ #category : 'visiting main API' }
ParentChildrenChecker >> parentsList: anObject [
    parentsList := anObject 
]

{ #category : 'visiting main API' }
ParentChildrenChecker >> visit: anElement [
	"Check if the parent of the element correctly includes this element as a child"

	anElement parent ifNotNil: [
		(anElement parent children includes: anElement) ifFalse: [
			self addError: 'Parent does not include this element as a child' ] ] .
	
	anElement children do: [ :child |
				child parent = anElement 
					ifFalse: [ self addError: 'Child does not point back to the correct parent' ].
		 		self visit: child  ].
]
