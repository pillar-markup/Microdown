"
i visit code blocks and make sure that evaluation is correct 
"
Class {
	#name : 'MicBookTesterVisitor',
	#superclass : 'MicrodownVisitor',
	#instVars : [
		'strategies',
		'results'
	],
	#category : 'Microdown-BookTester',
	#package : 'Microdown-BookTester'
}

{ #category : 'testing' }
MicBookTesterVisitor class >> isAbstract [
	<ignoreForCoverage "This method is ignored for test coverage because it is overriden in all subclasses and these subclasses don't need to do a super-send.">
	^ false
]

{ #category : 'initialization' }
MicBookTesterVisitor >> collectStrategies [
	
	MicBookTesterStrategy allSubclasses do: [ :each |
		| strat |
		strat := each new.
		strat results: results. 
		strategies at: each handleKey put: strat  ]
]

{ #category : 'visiting' }
MicBookTesterVisitor >> failedTests [

	^ results select: [ :each | each isFailed ]
]

{ #category : 'initialization' }
MicBookTesterVisitor >> initialize [

	super initialize.
	results := OrderedCollection new.
	strategies := Dictionary new. 
	self collectStrategies
]

{ #category : 'visiting' }
MicBookTesterVisitor >> isOk [ 
	| checkingVariable |
	checkingVariable := true.
	results do: [ :each | checkingVariable := checkingVariable and: [ each isMicPaired ] ].
	^ checkingVariable
]

{ #category : 'visiting' }
MicBookTesterVisitor >> results [

	^ results
]

{ #category : 'accessing' }
MicBookTesterVisitor >> start: anObject [ 
	anObject accept: self
	
]

{ #category : 'testing' }
MicBookTesterVisitor >> validTests [

	^ results select: [ :each | each isValid ]
]

{ #category : 'visiting' }
MicBookTesterVisitor >> visitCode: aCodeBlock [
	"Creates an instance of PRBookTestResult with parameters depending of the type of the codeblock."

	(strategies keys includes: aCodeBlock mainExtensionTag)
		ifFalse: [ ^ self ].

	(strategies at: aCodeBlock mainExtensionTag)
		verify: aCodeBlock
]
