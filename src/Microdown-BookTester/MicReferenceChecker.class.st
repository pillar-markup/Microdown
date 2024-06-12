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
		'duplicatedAnchors'
	],
	#category : 'Microdown-BookTester',
	#package : 'Microdown-BookTester'
}

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

	aCollection do: [ :each | self checkFile: each ].
	^ self isOk 
	
	

]

{ #category : 'reporting' }
MicReferenceChecker >> duplicatedAnchors [

	^ duplicatedAnchors
]

{ #category : 'visiting' }
MicReferenceChecker >> handleAnchorOf: anElement [

	anElement hasAnchor ifFalse: [ ^ self ].
	(self hasAlreadyDefinedAs: anElement)
		ifTrue: [ duplicatedAnchors add: anElement ].
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
	references := OrderedCollection new.
	anchors := OrderedCollection new.
	duplicatedAnchors := OrderedCollection new
]

{ #category : 'testing' }
MicReferenceChecker >> isOk [

	^ duplicatedAnchors isEmpty and: [
		references allSatisfy: [ :each | self hasAlreadyDefinedAs: each ] ]
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
	isAlready ifTrue: [ duplicatedAnchors add: anAnchor ].
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
