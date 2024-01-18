"
A MicrodownVisitorTest is a test class for testing the behavior of MicrodownVisitor
"
Class {
	#name : 'MicrodownVisitorTest',
	#superclass : 'TestCase',
	#category : 'Microdown-Tests-Visitor',
	#package : 'Microdown-Tests',
	#tag : 'Visitor'
}

{ #category : 'tests' }
MicrodownVisitorTest >> testAllVisitMethodsExists [
	"Check that all visitSomeBlockType: used in an accept: method are implemented in MicrodownVisitor.
	See Issue https://github.com/pillar-markup/Microdown/issues/533"
	|allVisitSelectors topVisitSeletors missing |
	"We use a heuristic here, we look for message sends in the accept methods of the blocks"
	allVisitSelectors := (MicElement allSubclasses 
		collect: [ :cl | (cl lookupSelector: #accept:) allLiterals 
			select: [ :l | l isString and: [(l beginsWith: 'visit')] ] ]
			) flattened asSet.
	topVisitSeletors := (MicrodownVisitor methods 
		collect: [ :m | m selector ] 
		thenSelect: [ :m |m beginsWith: 'visit' ]) asSet.
	missing := allVisitSelectors \ topVisitSeletors.
	self assert: missing isEmpty.
]
