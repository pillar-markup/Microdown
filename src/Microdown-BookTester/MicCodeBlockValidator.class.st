"
I visit code blocks and make sure that their 'evaluation' is correct.
I generate a list of analysis results (subclasses of `MicResult`) that then will be consumed by the `MicAnalysisReportBuilder`. 
This evaluation is specified by a tag. 

- 'example' tag verifies that the code is returning the expected result.
- 'sync' verifies if the code is in sync with the one in the image. 

New code block validation can easily be added by adding subclasses to `MicCodeBlockTesterStrategy`.
"
Class {
	#name : 'MicCodeBlockValidator',
	#superclass : 'MicChecker',
	#instVars : [
		'strategies'
	],
	#category : 'Microdown-BookTester-CodeBlockAnalysis',
	#package : 'Microdown-BookTester',
	#tag : 'CodeBlockAnalysis'
}

{ #category : 'public - name' }
MicCodeBlockValidator class >> checkerName [ 
	^ 'CodeBlockValidator'
]

{ #category : 'testing' }
MicCodeBlockValidator class >> isAbstract [
	<ignoreForCoverage "This method is ignored for test coverage because it is overriden in all subclasses and these subclasses don't need to do a super-send.">
	^ false
]

{ #category : 'initialization' }
MicCodeBlockValidator >> collectStrategies [
	
	MicCodeBlockTesterStrategy allSubclasses do: [ :each |
		| strat |
		strat := each new.
		strat results: results. 
		strategies at: each handleKey put: strat  ]
]

{ #category : 'visiting' }
MicCodeBlockValidator >> failedTests [

	^ results select: [ :each | each isFailed ]
]

{ #category : 'accessing' }
MicCodeBlockValidator >> fileSystem: aFileReference [
	
	self deprecated: 'use rootDirectory' 
		transformWith: '`@receiver fileSystem: `@arg' -> '`@receiver rootDirectory: `@arg'.
	self rootDirectory: aFileReference.
]

{ #category : 'initialization' }
MicCodeBlockValidator >> initialize [

	super initialize.
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
