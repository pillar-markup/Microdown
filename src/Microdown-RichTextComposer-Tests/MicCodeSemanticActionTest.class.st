Class {
	#name : #MicCodeSemanticActionTest,
	#superclass : #TestCase,
	#category : #'Microdown-RichTextComposer-Tests-Composer'
}

{ #category : #'test - bogus entry' }
MicCodeSemanticActionTest >> semanticActionClass [

	^ MicSemanticAction
]

{ #category : #'test - bogus entry' }
MicCodeSemanticActionTest >> testArrayShouldNotBreak [

	self deny: (self semanticActionClass fromTokens: #( 1 #+ 2 #* 3 )) hasEntity.
	self deny: (self semanticActionClass fromTokens: #( 1 #+ 2 #* )) hasEntity
]

{ #category : #'test - bogus entry' }
MicCodeSemanticActionTest >> testChevronWithBrokenArguments [

	self assert: (self semanticActionClass fromTokens: #( Point #>> 2 )) entity isNil.
	self assert: (self semanticActionClass fromTokens: #( Point class #>> 2 )) entity isNil.

	self assert: (self semanticActionClass fromTokens: #( Point #>> true )) entity isNil.
	self assert: (self semanticActionClass fromTokens: #( Point #>> Point )) entity isNil
]

{ #category : #'test - bogus entry' }
MicCodeSemanticActionTest >> testChevronWithBrokenReceiver [

	self assert: (self semanticActionClass fromTokens: #( 1 #>> 2 )) entity isNil.
	self assert: (self semanticActionClass fromTokens: #( true #>> 2 )) entity isNil.
	self assert: (self semanticActionClass fromTokens: #( $t #>> 2 )) entity isNil.
	self assert: (self semanticActionClass fromTokens:  #( ClassThatDoesNotExist #>> 2 )) entity isNil.

	self assert: (self semanticActionClass fromTokens: #( true class #>> 2 )) entity isNil.
	self assert: (self semanticActionClass fromTokens: #( $t class #>> 2 )) entity isNil.
	self assert: (self semanticActionClass fromTokens: #( ClassThatDoesNotExist class #>> 2 )) entity isNil
]

{ #category : #'test - bogus entry' }
MicCodeSemanticActionTest >> testDoubleDollars [

	self deny: (self semanticActionClass from: '$$') hasEntity
]

{ #category : #'test - bogus entry' }
MicCodeSemanticActionTest >> testEmptyString [

	self deny: (self semanticActionClass from: '') hasEntity
]

{ #category : #'test - bogus entry' }
MicCodeSemanticActionTest >> testGlobalAccess [

	self assert: (self semanticActionClass fromTokens: #( Transcript )) hasEntity
	"the semantics action is working even if it is refers to a global because the class of global is 
	used by the browse invocation when clicking on it. "
]

{ #category : #'test - bogus entry' }
MicCodeSemanticActionTest >> testMoreSpaces [

	self deny: (self semanticActionClass from: '    ') hasEntity
]

{ #category : #'test - bogus entry' }
MicCodeSemanticActionTest >> testOneSpace [

	self deny: (self semanticActionClass from: ' ') hasEntity
]

{ #category : #'tests - metaclass' }
MicCodeSemanticActionTest >> testReferenceToABrokenMetaClass [

	self assert: (self semanticActionClass from: 'Point2 class') entity isNil
]

{ #category : #'tests - metaclass' }
MicCodeSemanticActionTest >> testReferenceToABrokenMetaClass2 [

	self assert: (self semanticActionClass from: 'Point grgrgr') entity isNil
]

{ #category : #'tests - class' }
MicCodeSemanticActionTest >> testReferenceToAClass [

	self
		assert: (self semanticActionClass from:  'Point') entity
		equals: Point
]

{ #category : #'tests - metaclass' }
MicCodeSemanticActionTest >> testReferenceToAMetaClass [

	self
		assert: (self semanticActionClass from: 'Point class') entity
		equals: Point class
]

{ #category : #'tests - methods' }
MicCodeSemanticActionTest >> testReferenceToAMethod [

	self
		assert: (self semanticActionClass from: 'Point >> #setX:setY:') entity name
		equals: 'Point>>#setX:setY:'
]

{ #category : #'tests - methods' }
MicCodeSemanticActionTest >> testReferenceToANonExistingMethod [

	self assert: (self semanticActionClass from: 'Point >> 12+3 ') entity isNil
]

{ #category : #'tests - methods' }
MicCodeSemanticActionTest >> testReferenceToANonExistingMethodBecauseOfBogusClass [

	self assert: (self semanticActionClass from: 'Point222 >> #setX:setY:') entity isNil
]

{ #category : #'tests - methods' }
MicCodeSemanticActionTest >> testReferenceToANonExistingMethodBecauseOfNoSymbol [

	self assert: (self semanticActionClass from: 'Point >> setX:setY2:') entity isNil
]

{ #category : #'tests - package' }
MicCodeSemanticActionTest >> testReferenceToANonExistingPackage [

	self assert: (self semanticActionClass from: #Pillar) entity isNil
]

{ #category : #'tests - package' }
MicCodeSemanticActionTest >> testReferenceToAPackage [

	self
		assert: (self semanticActionClass from: #'''Microdown''') entity name
		equals: 'Microdown'
]

{ #category : #'tests - class' }
MicCodeSemanticActionTest >> testReferenceToNonExistingClass [

	self deny: (self semanticActionClass from: 'Point22') hasEntity
]

{ #category : #'test - bogus entry' }
MicCodeSemanticActionTest >> testScannerShouldNotFail [

	self deny: (self semanticActionClass from: 'half"baked') hasEntity.
	self deny: (self semanticActionClass from: '') hasEntity.
	self deny: (self semanticActionClass from: 'half"baked') hasEntity.
	self deny: (self semanticActionClass from: 16rFFFD asCharacter asString) hasEntity.
]

{ #category : #'test - bogus entry' }
MicCodeSemanticActionTest >> testTwoBogusElements [

	self assert:
		(self semanticActionClass fromTokens: #( 1 #+ )) entity isNil.
	self assert:
		(self semanticActionClass fromTokens: #( true #foo )) entity isNil.
	self assert:
		(self semanticActionClass fromTokens: #( Point #foo )) entity isNil
]

{ #category : #'test - bogus entry' }
MicCodeSemanticActionTest >> testTwoSpaces [

	self deny: (self semanticActionClass from: '  ') hasEntity
]
