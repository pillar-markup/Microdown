"
i visit code blocks and make sure that evaluation is correct 
"
Class {
	#name : 'MicCodeBlockValidator',
	#superclass : 'MicrodownVisitor',
	#instVars : [
		'strategies',
		'results',
		'reportWriter'
	],
	#category : 'Microdown-BookTester-Analysis',
	#package : 'Microdown-BookTester',
	#tag : 'Analysis'
}

{ #category : 'testing' }
MicCodeBlockValidator class >> isAbstract [
	<ignoreForCoverage "This method is ignored for test coverage because it is overriden in all subclasses and these subclasses don't need to do a super-send.">
	^ false
]

{ #category : 'initialization' }
MicCodeBlockValidator >> collectStrategies [
	
	MicBookTesterStrategy allSubclasses do: [ :each |
		| strat |
		strat := each new.
		strat results: results. 
		strategies at: each handleKey put: strat  ]
]

{ #category : 'visiting' }
MicCodeBlockValidator >> failedTests [

	^ results select: [ :each | each isFailed ]
]

{ #category : 'initialization' }
MicCodeBlockValidator >> initialize [

	super initialize.
	results := OrderedCollection new.
	strategies := Dictionary new. 
	self collectStrategies
]

{ #category : 'visiting' }
MicCodeBlockValidator >> isOk [ 
	| checkingVariable |
	checkingVariable := true.
	results do: [ :each | checkingVariable := checkingVariable and: [ each isMicPaired ] ].
	^ checkingVariable
]

{ #category : 'accessing' }
MicCodeBlockValidator >> reportWriter [

	^ reportWriter
]

{ #category : 'accessing' }
MicCodeBlockValidator >> reportWriter: anObject [

	reportWriter := anObject
]

{ #category : 'visiting' }
MicCodeBlockValidator >> results [

	^ results
]

{ #category : 'accessing' }
MicCodeBlockValidator >> results: anObject [

	results := anObject
]

{ #category : 'accessing' }
MicCodeBlockValidator >> start: anObject [ 
	anObject accept: self
	
]

{ #category : 'testing' }
MicCodeBlockValidator >> validTests [

	^ results select: [ :each | each isValid ]
]

{ #category : 'visiting' }
MicCodeBlockValidator >> visitCode: aCodeBlock [
	"Creates an instance of PRBookTestResult with parameters depending of the type of the codeblock."

	
	(strategies keys includes: aCodeBlock mainExtensionTag)
		ifFalse: [ ^ self ].

	(strategies at: aCodeBlock mainExtensionTag)
		verify: aCodeBlock
]
