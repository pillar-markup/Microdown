Class {
	#name : #MicrodownVisitor,
	#superclass : #Object,
	#category : #'Microdown-Visitor'
}

{ #category : #'visit-block' }
MicrodownVisitor >> visitRoot: aRoot [

	aRoot children do: [ :each | each accept: self ]
]
