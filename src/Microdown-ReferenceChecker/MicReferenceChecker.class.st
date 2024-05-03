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

{ #category : 'reporting' }
MicReferenceChecker >> duplicatedAnchors [

	^ duplicatedAnchors
]

{ #category : 'visiting' }
MicReferenceChecker >> handleAnchorOf: anElement [

	anElement hasAnchor ifTrue: [
		(anchors includes: anElement anchor)
			ifTrue: [ duplicatedAnchors add: anElement anchor ]
			ifFalse: [ anchors add: anElement anchor ] ]
		
	"Pay attention if we want to report all the occurrences of the 
				anchor definition we would have to count the one already included
				in anchors - Imagine that you have File1/anc1 File2/anc1 and File3/anc1
				the reporting should be anc1 is File1, File2 and File3" 
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

	(anchors includes: anAnchor label) 
		ifTrue: [
			duplicatedAnchors add: anAnchor label
			"Pay attention if we want to report all the occurrences of the 
				anchor definition we would have to count the one already included
				in anchors - Imagine that you have File1/anc1 File2/anc1 and File3/anc1
				the reporting should be anc1 is File1, File2 and File3" ]
		ifFalse: [ anchors add: anAnchor label ]
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
