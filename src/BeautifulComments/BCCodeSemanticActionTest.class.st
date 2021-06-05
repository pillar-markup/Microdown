Class {
	#name : #BCCodeSemanticActionTest,
	#superclass : #TestCase,
	#instVars : [
		'sample'
	],
	#category : #BeautifulComments
}

{ #category : #'test - bogus entry' }
BCCodeSemanticActionTest >> semanticActionClass [

	^ BCSemanticAction
]

{ #category : #'test - bogus entry' }
BCCodeSemanticActionTest >> testArrayShouldNotBreak [

	self deny: (self semanticActionClass fromTokens: #( 1 #+ 2 #* 3 )) hasEntity.
	self deny: (self semanticActionClass fromTokens: #( 1 #+ 2 #* )) hasEntity
]

{ #category : #'test - bogus entry' }
BCCodeSemanticActionTest >> testChevronWithBrokenArguments [

	self assert: (self semanticActionClass fromTokens: #( Point #>> 2 )) entity isNil.
	self assert: (self semanticActionClass fromTokens: #( Point class #>> 2 )) entity isNil.

	self assert: (self semanticActionClass fromTokens: #( Point #>> true )) entity isNil.
	self assert: (self semanticActionClass fromTokens: #( Point #>> Point )) entity isNil
]

{ #category : #'test - bogus entry' }
BCCodeSemanticActionTest >> testChevronWithBrokenReceiver [

	self assert: (self semanticActionClass fromTokens: #( 1 #>> 2 )) entity isNil.
	self assert: (self semanticActionClass fromTokens: #( true #>> 2 )) entity isNil.
	self assert: (self semanticActionClass fromTokens: #( $t #>> 2 )) entity isNil.
	self assert: (self semanticActionClass fromTokens:  #( ClassThatDoesNotExist #>> 2 )) entity isNil.

	self assert: (self semanticActionClass fromTokens: #( true class #>> 2 )) entity isNil.
	self assert: (self semanticActionClass fromTokens: #( $t class #>> 2 )) entity isNil.
	self assert: (self semanticActionClass fromTokens: #( ClassThatDoesNotExist class #>> 2 )) entity isNil
]

{ #category : #'test - bogus entry' }
BCCodeSemanticActionTest >> testDoubleDollars [

	self deny: (self semanticActionClass from: '$$') hasEntity
]

{ #category : #'test - bogus entry' }
BCCodeSemanticActionTest >> testEmptyString [

	self deny: (self semanticActionClass from: '') hasEntity
]

{ #category : #'test - bogus entry' }
BCCodeSemanticActionTest >> testGlobalAccess [

	self assert: (self semanticActionClass fromTokens: #( Transcript )) hasEntity
	"the semantics action is working even if it is refers to a global because the class of global is 
	used by the browse invocation when clicking on it. "
]

{ #category : #'test - bogus entry' }
BCCodeSemanticActionTest >> testMoreSpaces [

	self deny: (self semanticActionClass from: '    ') hasEntity
]

{ #category : #'test - bogus entry' }
BCCodeSemanticActionTest >> testOneSpace [

	self deny: (self semanticActionClass from: ' ') hasEntity
]

{ #category : #'tests - metaclass' }
BCCodeSemanticActionTest >> testReferenceToABrokenMetaClass [

	self assert: (self semanticActionClass from: 'Point2 class') entity isNil
]

{ #category : #'tests - metaclass' }
BCCodeSemanticActionTest >> testReferenceToABrokenMetaClass2 [

	self assert: (self semanticActionClass from: 'Point grgrgr') entity isNil
]

{ #category : #'tests - class' }
BCCodeSemanticActionTest >> testReferenceToAClass [

	self
		assert: (self semanticActionClass from:  'Point') entity
		equals: Point
]

{ #category : #'tests - metaclass' }
BCCodeSemanticActionTest >> testReferenceToAMetaClass [

	self
		assert: (self semanticActionClass from: 'Point class') entity
		equals: Point class
]

{ #category : #'tests - methods' }
BCCodeSemanticActionTest >> testReferenceToAMethod [

	self
		assert: (self semanticActionClass from: 'Point >> #setX:setY:') entity name
		equals: 'Point>>#setX:setY:'
]

{ #category : #'tests - methods' }
BCCodeSemanticActionTest >> testReferenceToANonExistingMethod [

	self assert: (self semanticActionClass from: 'Point >> 12+3 ') entity isNil
]

{ #category : #'tests - methods' }
BCCodeSemanticActionTest >> testReferenceToANonExistingMethodBecauseOfBogusClass [

	self assert: (self semanticActionClass from: 'Point222 >> #setX:setY:') entity isNil
]

{ #category : #'tests - methods' }
BCCodeSemanticActionTest >> testReferenceToANonExistingMethodBecauseOfNoSymbol [

	self assert: (self semanticActionClass from: 'Point >> setX:setY2:') entity isNil
]

{ #category : #'tests - package' }
BCCodeSemanticActionTest >> testReferenceToANonExistingPackage [

	self assert: (self semanticActionClass from: #Pillar) entity isNil
]

{ #category : #'tests - package' }
BCCodeSemanticActionTest >> testReferenceToAPackage [

	self
		assert: (self semanticActionClass from: #'''BeautifulComments''') entity name
		equals: 'BeautifulComments'
]

{ #category : #'tests - class' }
BCCodeSemanticActionTest >> testReferenceToNonExistingClass [

	self deny: (self semanticActionClass from: 'Point22') hasEntity
]

{ #category : #'test - bogus entry' }
BCCodeSemanticActionTest >> testTwoBogusElements [

	self assert:
		(self semanticActionClass fromTokens: #( 1 #+ )) entity isNil.
	self assert:
		(self semanticActionClass fromTokens: #( true #foo )) entity isNil.
	self assert:
		(self semanticActionClass fromTokens: #( Point #foo )) entity isNil
]

{ #category : #'test - bogus entry' }
BCCodeSemanticActionTest >> testTwoSpaces [

	self deny: (self semanticActionClass from: '  ') hasEntity
]
