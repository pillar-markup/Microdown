"
I'm a little tool that checks whether a document has (1) references to undeclared anchors or (2) duplicated anchors. 

For now Microdown is file agnostic so this is impossible to report in which file such duplication or reference occurs. 
Once file support is introduced I should be revised to report better information to the user. 
"
Class {
	#name : 'MicReferenceChecker',
	#superclass : 'MicrodownVisitor',
	#instVars : [
		'references',
		'anchors',
		'duplicatedAnchors',
		'allTestsResults',
		'finalStatus'
	],
	#category : 'Microdown-BookTester',
	#package : 'Microdown-BookTester'
}

{ #category : 'accessing' }
MicReferenceChecker >> allTestsResults [

	^ allTestsResults
]

{ #category : 'visiting' }
MicReferenceChecker >> check: aDocument [ 
	"Pay attention checking a file in isolation is DIFFERENT from a list, because document 
	can have references between them and the checker should be shared amongst the documents 
	since it collects the references."

	aDocument accept: self.
	^ self isOk 
	
	

]

{ #category : 'visiting' }
MicReferenceChecker >> checkDirectory: aDir [
	"Take the directory, parse all its children with microdown file parser and let the visitor visit each time then return visitor is ok which should be true if every thing is okay, the visitor turned out to treat the many documents that it visits as one, so if anchor is duplicated in another file it will detect that . "
	
	^ self checkList: aDir allFiles
]

{ #category : 'visiting' }
MicReferenceChecker >> checkFile: aFile [ 
	"Will parse the given file and invite the visitor and return visitor isOk value"

	| document |
	document := Microdown parseFile: aFile. 
	^ self check: document
	
	

]

{ #category : 'visiting' }
MicReferenceChecker >> checkList: aCollection [  
	"Pay attention checking a file in isolation is DIFFERENT from a list, because document 
	can have references between them and the checker should be shared amongst the documents 
	since it collects the references."

	 aCollection do: [ :each | 
		self checkFile: each ].
	^ self isOk
]

{ #category : 'visiting' }
MicReferenceChecker >> collectBadAnchors [


 duplicatedAnchors do: [ :duplicatedAnchor |
			allTestsResults add: (self result explanation: #twoAnchorsSameName withSpecification: duplicatedAnchor anchorLabel  ) 
		 ]
	
	"references  do: 
		 [ :each |
			 anchors do: 
			[ :each2 |
			 (each anchorLabel ~= each2 anchorLabel )
			  ifTrue: [ 
								allTestsResults add: (self result explanation: #twoAnchorsSameName withSpecification: each anchorLabel ) 
				       ] 
			  ifFalse: [  ]
			 ]]"
]

{ #category : 'visiting' }
MicReferenceChecker >> collectBadReferences [


 | newList |
 newList :=( references reject: [:e | anchors anySatisfy: [ :ee | ee anchorLabel  = e anchorLabel  ]  ]) groupedBy: [:e | e anchorLabel ].
 newList keysDo: [ :label |
			allTestsResults add: (self result explanation: #anchorIsMissing withSpecification: label ) 
		 ]
	
	"references  do: 
		 [ :each |
			 anchors do: 
			[ :each2 |
			 (each anchorLabel ~= each2 anchorLabel )
			  ifTrue: [ 
								allTestsResults add: (self result explanation: #twoAnchorsSameName withSpecification: each anchorLabel ) 
				       ] 
			  ifFalse: [  ]
			 ]]"
]

{ #category : 'reporting' }
MicReferenceChecker >> duplicatedAnchors [

	^ duplicatedAnchors
]

{ #category : 'visiting' }
MicReferenceChecker >> finalStatus [ 
	^ allTestsResults isEmpty .
]

{ #category : 'visiting' }
MicReferenceChecker >> handleAnchorOf: anElement [

	anElement hasAnchor ifFalse: [ ^ self ].
	(self hasAlreadyDefinedAs: anElement)
		ifTrue: [
				 duplicatedAnchors add: anElement .
	"	    	 allTestsResults add: (self result explanation: #twoAnchorsSameName withSpecification: anElement anchorLabel )"
		 ].
	 anchors add: anElement
	
]

{ #category : 'visiting' }
MicReferenceChecker >> hasAlreadyDefinedAs: anAnchor [

	| alreadyDefined |
	alreadyDefined := false. 
	anchors do: 
		 [ :each | each anchorLabel = anAnchor anchorLabel
				ifTrue: [ alreadyDefined := true ] ].
	^ alreadyDefined
]

{ #category : 'initialization' }
MicReferenceChecker >> initialize [

	super initialize.
	
	allTestsResults := OrderedCollection new.
	
	references := OrderedCollection new.
	anchors := OrderedCollection new.
	duplicatedAnchors := OrderedCollection new
]

{ #category : 'visiting' }
MicReferenceChecker >> isFailure [
	^  self isOk not 
]

{ #category : 'testing' }
MicReferenceChecker >> isOk [

	 
	 "self collectBadReferences."
	| existingAnchorNames |
	^ duplicatedAnchors isEmpty and: [
		existingAnchorNames := anchors collect: [ :each | each anchorLabel ].
		references allSatisfy: [ :each | existingAnchorNames includes: each anchorLabel  ] ]
	  
	 " self collectBadReferences.
	  self collectBadAnchors .
	^ allTestsResults isEmpty and: [
		references allSatisfy: [ :each | self hasAlreadyDefinedAs: each ] ] "
]

{ #category : 'visiting' }
MicReferenceChecker >> result [ 
	^ MicResult 
]

{ #category : 'reporting' }
MicReferenceChecker >> unknownAnchors [
	
	| unknown ref |
	unknown := OrderedCollection new. 
	ref := references copy.
	ref do: [ :ref |
		(anchors noneSatisfy: [ :each | 
			ref anchorLabel = each anchorLabel ])
				ifTrue: [ unknown add: ref ]  ].
	^ unknown 
]

{ #category : 'visiting' }
MicReferenceChecker >> visitAnchor: anAnchor [

	| isAlready |
	isAlready := self hasAlreadyDefinedAs: anAnchor.
	isAlready ifTrue: [
		 duplicatedAnchors add: anAnchor.
		 "allTestsResults add: (self result explanation: #twoAnchorsSameName withSpecification: anAnchor anchorLabel )"
		 ].
	anchors add: anAnchor
]

{ #category : 'visiting' }
MicReferenceChecker >> visitAnchorReference: anAnchorReference [
	
	references add: anAnchorReference
]

{ #category : 'visiting' }
MicReferenceChecker >> visitFigure: aFigure [

	self handleAnchorOf: aFigure
]

{ #category : 'visiting' }
MicReferenceChecker >> visitMath: aMathEnv [

	self handleAnchorOf: aMathEnv
]
