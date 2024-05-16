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

{ #category : 'accessing' }
MicParentChildrenChecker >> check: anElement [ [
    "Check if the parent of the element correctly includes this element as a child and if the element's parent pointer is correct."

    anElement parent
        ifNil: [
            "Check if the root element is indeed supposed to have no parent"
            anElement class = MicRootBlock
                ifFalse: [ orphanList add: anElement ]
                ifTrue: [ anElement children do: [ :each | self check: each ] ]
        ]
        ifNotNil: [ :p |
            "Check if the parent’s list of children actually includes this element"
            (p children includes: anElement)
                ifFalse: [ confusedKids add: anElement ].

            "Check the consistency of each child’s parent pointer to make sure it points back correctly to 'p'"
            p children do: [ :child |
                child parent ~= p ifTrue: [ confusedKids add: child ]
            ].

            "Recursively check all children of the current element"
            anElement children do: [ :child | self check: child ]
        ]
]

]

{ #category : 'accessing' }
MicParentChildrenChecker >> confusedKids [ [

	^ confusedKids
]

]

{ #category : 'accessing' }
MicParentChildrenChecker >> initialize [ [

	super initialize.
	orphanList := OrderedCollection new.
	confusedKids := OrderedCollection new
]

]

{ #category : 'accessing' }
MicParentChildrenChecker >> isOk [ [

	^ confusedKids isEmpty and:
		  (orphanList isEmpty and: [ confusedKids isEmpty ])
]

]

{ #category : 'accessing' }
MicParentChildrenChecker >> orphanList [ [
	^orphanList 
]
]
