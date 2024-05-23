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
	#category : 'Microdown-ReferenceChecker',
	#package : 'Microdown-ReferenceChecker'
}

{ #category : 'visiting' }
MicReferenceChecker >> attachFile: anElement [ 

 "get the file from the root of the parsed tree to add it along the anchors later so we know in what file are the anchors or elements that caused the problem , what worth noting here is in the cases where anchor is not an object that will not work  "

	|fakeElement|
	fakeElement := anElement  .
 (anElement isKindOf: MicRootBlock ) 
	ifTrue: [
		 ^ (fakeElement propertyAt: #file ifAbsent: [ ])  ] 
	ifFalse: [ 
					fakeElement := fakeElement parent .
					self attachFile: fakeElement 
				]

]

{ #category : 'visiting' }
MicReferenceChecker >> checkDirectory: aDir [
	"Take the directory, parse all its children with microdown file parser and let the visitor visit each time then return visitor is ok which should be true if every thing is okay, the visitor turned out to treat the many documents that it visits as one, so if anchor is duplicated in another file it will detect that . "
	
	| parsedFile |
	aDir allFiles do: [ :each |
        (parsedFile := Microdown parseFile: each) accept: self.
    ].

	^ self isOk 

]

{ #category : 'visiting' }
MicReferenceChecker >> checkFile: aFile [ 
	"Will parse the given file and invite the visitor and return visitor isOk value"

	| parsedFile |
	parsedFile := Microdown parseFile: aFile. 
	parsedFile accept: self.
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

	^ (anchors
		  detect: [ :each | each label = anAnchor anchorLabel ]
		  ifNone: [ #(  ) ]) isNotEmpty
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
		references allSatisfy: [ :each | anchors includes: each ] ]
]

{ #category : 'reporting' }
MicReferenceChecker >> unknownAnchors [
	
	| unk |
	unk := references copy.
	anchors do: [ :each | 
		unk remove: each ifAbsent: [  ] ].
	^ unk
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
	
	references add: anAnchorReference bodyString
]

{ #category : 'visiting' }
MicReferenceChecker >> visitFigure: aFigure [

	self handleAnchorOf: aFigure
]

{ #category : 'visiting' }
MicReferenceChecker >> visitMath: aMathEnv [

	self handleAnchorOf: aMathEnv
]
