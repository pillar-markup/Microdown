Class {
	#name : #BCCodeSemanticActionTest,
	#superclass : #TestCase,
	#instVars : [
		'sample'
	],
	#category : #BeautifullComments
}

{ #category : #'test - bogus entry' }
BCCodeSemanticActionTest >> semanticActionClass [

	^ BCSemanticAction
]

{ #category : #'test - bogus entry' }
BCCodeSemanticActionTest >> testArrayShouldNotBreak [

	self deny:
		(self semanticActionClass fromTokens: #( 1 #+ 2 #* 3 )) hasEntity.
	self deny:
		(self semanticActionClass fromTokens: #( 1 #+ 2 #* )) hasEntity
]

{ #category : #'test - bogus entry' }
BCCodeSemanticActionTest >> testChevronWithBrokenArguments [

	self assert:
		(self semanticActionClass fromTokens: #( Point #>> 2 )) entity isNil.
	self assert:
		(self semanticActionClass fromTokens: #( Point class #>> 2 )) entity
			isNil.

	self assert:
		(self semanticActionClass fromTokens: #( Point #>> true )) entity
			isNil.
	self assert:
		(self semanticActionClass fromTokens: #( Point #>> Point )) entity
			isNil
]

{ #category : #'test - bogus entry' }
BCCodeSemanticActionTest >> testChevronWithBrokenReceiver [

	self assert:
		(self semanticActionClass fromTokens: #( 1 #>> 2 )) entity isNil.
	self assert:
		(self semanticActionClass fromTokens: #( true #>> 2 )) entity isNil.
	self assert:
		(self semanticActionClass fromTokens: #( $t #>> 2 )) entity isNil.
	self assert:
		(self semanticActionClass fromTokens:
			 #( ClassThatDoesNotExist #>> 2 )) entity isNil.

	self assert:
		(self semanticActionClass fromTokens: #( true class #>> 2 )) entity
			isNil.
	self assert:
		(self semanticActionClass fromTokens: #( $t class #>> 2 )) entity
			isNil.
	self assert: (self semanticActionClass fromTokens:
			 #( ClassThatDoesNotExist class #>> 2 )) entity isNil
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

	self assert:
		(self semanticActionClass fromTokens: #( Transcript )) hasEntity
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

	| text |
	text := (PRMonospaceFormat with: (PRText content: 'Point2 class'))
		        children first text.
	self assert: (self semanticActionClass from: text) entity isNil
]

{ #category : #'tests - metaclass' }
BCCodeSemanticActionTest >> testReferenceToABrokenMetaClass2 [

	| text |
	text := (PRMonospaceFormat with: (PRText content: 'Point grgrgr'))
		        children first text.
	self assert: (self semanticActionClass from: text) entity isNil
]

{ #category : #'tests - class' }
BCCodeSemanticActionTest >> testReferenceToAClass [

	| text |
	text := (PRMonospaceFormat with: (PRText content: 'Point')) children
		        first text.
	self
		assert: (self semanticActionClass from: text) entity
		equals: Point
]

{ #category : #'tests - metaclass' }
BCCodeSemanticActionTest >> testReferenceToAMetaClass [

	| text |
	text := (PRMonospaceFormat with: (PRText content: 'Point class'))
		        children first text.
	self
		assert: (self semanticActionClass from: text) entity
		equals: Point class
]

{ #category : #'tests - methods' }
BCCodeSemanticActionTest >> testReferenceToAMethod [

	| text |
	text := (PRMonospaceFormat with:
		         (PRText content: 'Point >> #setX:setY:')) children first
		        text.
	self
		assert: (self semanticActionClass from: text) entity name
		equals: 'Point>>#setX:setY:'
]

{ #category : #'tests - methods' }
BCCodeSemanticActionTest >> testReferenceToANonExistingMethod [

	| text |
	text := (PRMonospaceFormat with: (PRText content: 'Point >> 12+3 '))
		        children first text.
	self assert: (self semanticActionClass from: text) entity isNil
]

{ #category : #'tests - methods' }
BCCodeSemanticActionTest >> testReferenceToANonExistingMethodBecauseOfBogusClass [

	| text |
	text := (PRMonospaceFormat with:
		         (PRText content: 'Point222 >> #setX:setY:')) children first
		        text.
	self assert: (self semanticActionClass from: text) entity isNil
]

{ #category : #'tests - methods' }
BCCodeSemanticActionTest >> testReferenceToANonExistingMethodBecauseOfNoSymbol [

	| text |
	self skip.
	"for now scantoken convert 'setX:setY: into #setX:setY:'
	so I cannot distinguish"

	text := (PRMonospaceFormat with:
		         (PRText content: 'Point >> setX:setY:')) children first
		        text.
	self assert: (self semanticActionClass from: text) entity isNil
]

{ #category : #'tests - package' }
BCCodeSemanticActionTest >> testReferenceToANonExistingPackage [

	| text |
	text := (PRMonospaceFormat with: (PRText content: #Pillar)) children
		        first text.
	self assert: (self semanticActionClass from: text) entity isNil
]

{ #category : #'tests - package' }
BCCodeSemanticActionTest >> testReferenceToAPackage [

	| text |
	text := (PRMonospaceFormat with:
		         (PRText content: #'''Pillar-ExporterRichText''')) children
		        first text.
	self
		assert: (self semanticActionClass from: text) entity name
		equals: 'Pillar-ExporterRichText'
]

{ #category : #'tests - class' }
BCCodeSemanticActionTest >> testReferenceToNonExistingClass [

	| text |
	text := (PRMonospaceFormat with: (PRText content: 'Point22'))
		        children first text.
	self deny: (self semanticActionClass from: text) hasEntity
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
