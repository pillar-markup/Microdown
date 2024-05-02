Class {
	#name : 'MicReferenceCheckerVisitor',
	#superclass : 'MicrodownVisitor',
	#instVars : [
		'anchors',
		'references'
	],
	#category : 'Microdown-ReferenceChecker',
	#package : 'Microdown-ReferenceChecker'
}

{ #category : 'accessing' }
MicReferenceCheckerVisitor >> anchors [
	^ anchors
]

{ #category : 'initialization' }
MicReferenceCheckerVisitor >> initialize [

	super initialize.
	references := OrderedCollection new.
	anchors := OrderedCollection new.
]

{ #category : 'accessing' }
MicReferenceCheckerVisitor >> references [
	^ references
]

{ #category : 'initialization' }
MicReferenceCheckerVisitor >> validateReferences [
    references keys do: [ :key |
        (anchors includesKey: key) ifFalse: [
            Error signal: 'Reference to non-existent anchor: ', key
        ]
    ].
]

{ #category : 'initialization' }
MicReferenceCheckerVisitor >> visitAnchor: anAnchorBlock [
    anchors add: anAnchorBlock.
    "super visitAnchor: anAnchorBlock."
]

{ #category : 'initialization' }
MicReferenceCheckerVisitor >> visitAnchorReference: anAnchorReferenceBlock [
    references add: anAnchorReferenceBlock.
    "super visitAnchorReference: anAnchorReferenceBlock."
]
