"
I'm a nice little tool that checks whether a document has 
- references to undeclared anchors
- duplicated anchors

I check
- figures
- math equations
- or plain references.

I use the FileCollector to support all the file input relations.
This lets the user have for example unused, broken or underway files on the side.
As soon as they are not used I do not analyse them.


# todo

when we use the checkDir or the checkFile: API, it should still do the full closure of used files (i.e. use the file collector). This is a lot simpler to understand for the user. Having a systematic approach is the way to go. 
"
Class {
	#name : 'MicReferenceChecker',
	#superclass : 'MicrodownVisitor',
	#instVars : [
		'references',
		'anchors',
		'duplicatedAnchors',
		'results'
	],
	#category : 'Microdown-BookTester',
	#package : 'Microdown-BookTester'
}

{ #category : 'accessing' }
MicReferenceChecker >> addBadReferenceAnchor: anAnchorReference [

	| micResultInstance |
	micResultInstance := MicUndefinedAnchorResult new.
	micResultInstance
		message: (MicUndefinedAnchorResult allMessages at: #anchorIsMissing);
		anchorLabel: anAnchorReference anchorLabel;
		source: anAnchorReference fromFile.
	results add: micResultInstance
]

{ #category : 'accessing' }
MicReferenceChecker >> addDuplicatedAnchor: anAnchor [

	| micResultInstance |
	micResultInstance := MicDuplicatedAnchorResult new.
	micResultInstance
		message:
			(MicDuplicatedAnchorResult allMessages at: #twoAnchorsSameName);
		anchorLabel: anAnchor anchorLabel;
		source: anAnchor fromFile.
	results add: micResultInstance
]

{ #category : 'main API' }
MicReferenceChecker >> checkDirectory: aDir [
	"Take the directory, parse all its children with microdown file parser and let the visitor visit each time then return visitor is ok which should be true if every thing is okay, the visitor turned out to treat the many documents that it visits as one, so if anchor is duplicated in another file it will detect that . "
	
	^ self checkList: aDir allFiles
]

{ #category : 'main API' }
MicReferenceChecker >> checkList: aCollection [
	"Pay attention checking a file in isolation is DIFFERENT from a list, because a document can have references between them and the checker should be shared amongst the documents since it collects the references."

	aCollection do: [ :each | 
			| document |
			document := Microdown parseFile: each.
			document accept: self ].
	^ self isOkay
]

{ #category : 'main API' }
MicReferenceChecker >> checkProject: aDocument fileSystem: fileSystem [

	| mainMic collector listOfFiles |
	mainMic := Microdown parseFile: aDocument.
	collector := MicFileCollector new.
	collector
		fileSystem: fileSystem;
		visit: mainMic.
	listOfFiles := collector visitedDocumentFiles collect: [ :file |
		               fileSystem referenceTo: file ].
	self checkList: listOfFiles.
	^ self isOkay
]

{ #category : 'visiting' }
MicReferenceChecker >> collectBadReferences [
	" should be called just after all the docs are visited otherwise the result can be wrong"

	| badReference existingAnchorNames |
	existingAnchorNames := (anchors collect: [ :each | each anchorLabel ]).
	badReference := references reject: [ :anchorReference |
		                existingAnchorNames includes:
			                anchorReference anchorLabel ].
	badReference do: [ :each | self addBadReferenceAnchor: each ]
]

{ #category : 'reporting' }
MicReferenceChecker >> duplicatedAnchors [

	^ duplicatedAnchors
]

{ #category : 'visiting' }
MicReferenceChecker >> handleAnchorOf: anElement [

	anElement hasAnchor ifFalse: [ ^ self ].
	(self hasAlreadyDefinedAs: anElement)
		ifTrue: [
				 duplicatedAnchors add: anElement .
				 self addDuplicatedAnchor: anElement .
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

	results := OrderedCollection new.
	references := OrderedCollection new.
	anchors := OrderedCollection new.
	duplicatedAnchors := OrderedCollection new
]

{ #category : 'testing' }
MicReferenceChecker >> isOk [
	self flag: #fixThisLogic.
	"isOkay vs. isOk ???"
	
	^ duplicatedAnchors isEmpty and: [
		  references allSatisfy: [ :each | self hasAlreadyDefinedAs: each ] ]
]

{ #category : 'testing' }
MicReferenceChecker >> isOkay [

	self collectBadReferences.
	^ results isEmpty
]

{ #category : 'accessing' }
MicReferenceChecker >> results [

	^ results
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
		self addDuplicatedAnchor: anAnchor
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
