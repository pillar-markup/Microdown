Class {
	#name : 'ParentChildrenChecker',
	#superclass : 'MicrodownVisitor',
	#category : 'Microdown-ParentChildrenChecker',
	#package : 'Microdown-ParentChildrenChecker'
}

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
