Class {
	#name : 'ParentChildrenCheckerTest',
	#superclass : 'TestCase',
	#instVars : [
		'checker'
	],
	#category : 'Microdown-ParentChildrenChecker',
	#package : 'Microdown-ParentChildrenChecker'
}

{ #category : 'running' }
ParentChildrenCheckerTest >> setUp [
    checker := ParentChildrenChecker new.

]

{ #category : 'tests' }
ParentChildrenCheckerTest >> testAddChild [
    "Test adding a child to the childrenList."
    checker addChild: #child1.
    self assert: (checker childrenList size = 1).
    self assert: (checker childrenList includes: #child1).

]

{ #category : 'tests' }
ParentChildrenCheckerTest >> testAddParent [
    "Test adding a parent to the parentsList."
    checker addParent: #parent1.
    self assert: (checker parentsList size = 1).
    self assert: (checker parentsList includes: #parent1).
]

{ #category : 'running' }
ParentChildrenCheckerTest >> testInitialization [
    "Test that collections are initialized properly and are empty."
    self assert: checker childrenList isEmpty.
    self assert: checker parentsList isEmpty.

]

{ #category : 'tests' }
ParentChildrenCheckerTest >> testMultipleAdds [
    "Test adding multiple different children and parents."
    checker addChild: #child1.
    checker addChild: #child2.
    checker addParent: #parent1.
    checker addParent: #parent2.
    self assert: (checker childrenList size = 2).
    self assert: (checker parentsList size = 2).
    self assert: (checker childrenList includes: #child1).
    self assert: (checker childrenList includes: #child2).
    self assert: (checker parentsList includes: #parent1).
    self assert: (checker parentsList includes: #parent2).

]
