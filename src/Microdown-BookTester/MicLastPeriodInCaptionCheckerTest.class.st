Class {
	#name : 'MicLastPeriodInCaptionCheckerTest',
	#superclass : 'TestCase',
	#instVars : [
		'fileSystem',
		'checker'
	],
	#category : 'Microdown-BookTester-Checker-LastPeriod',
	#package : 'Microdown-BookTester',
	#tag : 'Checker-LastPeriod'
}

{ #category : 'running' }
MicLastPeriodInCaptionCheckerTest >> generateFilesystemExample [

	| file |
	file := fileSystem workingDirectory / 'codeCaptionMissingPeriod.md'.
	file writeStreamDo: [ :stream |
			stream nextPutAll: '

```caption=This is the famous missing period
setX: xInt setY: yInt

	...
```' ].

	file := fileSystem workingDirectory / 'figureCaptionMissingPeriod.md'.
	file writeStreamDo: [ :stream |
			stream nextPutAll: '

![This is the famous missing period](figures/f.png)
' ].

	file := fileSystem workingDirectory / 'equationCaptionMissingPeriod.md'.
	file writeStreamDo: [ :stream |
			stream nextPutAll: '
$$%caption=This is the famous missing period
\frac{1}{2}
$$
].
' ].

	file := fileSystem workingDirectory / 'codeCaptionEndingWithPeriod.md'.
	file writeStreamDo: [ :stream |
			stream nextPutAll: '

```caption=This is the famous correctly ending period.
setX: xInt setY: yInt

	...
```' ].

	file := fileSystem workingDirectory / 'figureCaptionEndingWithPeriod.md'.
	file writeStreamDo: [ :stream |
			stream nextPutAll: '

![This is the famous correctly ending period.](figures/f.png)
' ].

	file := fileSystem workingDirectory / 'equationCaptionEndingWithPeriod.md'.
	file writeStreamDo: [ :stream |
			stream nextPutAll: '
$$%caption=This is the famous correctly ending period.
\frac{1}{2}
$$
].
' ]
]

{ #category : 'running' }
MicLastPeriodInCaptionCheckerTest >> setUp [

	super setUp.
	fileSystem := FileSystem memory.
	self generateFilesystemExample.

	checker := MicLastPeriodInCaptionChecker new
]

{ #category : 'tests - missing period' }
MicLastPeriodInCaptionCheckerTest >> testCodeCheckerChecksCorrectlyMissingExtraPeriod [

	checker shouldEndWithPeriod.
	checker checkProject: fileSystem / 'codeCaptionEndingWithPeriod.md'.
	self assert: checker isOkay
]

{ #category : 'tests - extra period' }
MicLastPeriodInCaptionCheckerTest >> testCodeCheckerChecksCorrectlyNoExtraPeriod [

	checker shouldNotEndWithPeriod.
	checker checkProject: fileSystem / 'codeCaptionMissingPeriod.md'.
	self assert: checker isOkay
]

{ #category : 'tests - extra period' }
MicLastPeriodInCaptionCheckerTest >> testCodeCheckerIdentifyCorrectlyExtraPeriod [

	checker shouldNotEndWithPeriod.
	checker checkProject: fileSystem / 'codeCaptionEndingWithPeriod.md'.
	self deny: checker isOkay.

	self
		assert: checker results first explanation
		equals:
		'Text: "This is the famous correctly ending period." in file /codeCaptionEndingWithPeriod.md contains a mistake: Captions should not be terminated with a period (.).'
]

{ #category : 'tests - missing period' }
MicLastPeriodInCaptionCheckerTest >> testCodeCheckerIdentifyCorrectlyMissingExtraPeriod [

	checker shouldEndWithPeriod.
	checker checkProject: fileSystem / 'codeCaptionMissingPeriod.md'.
	self deny: checker isOkay.

	self
		assert: checker results first explanation
		equals:
		'Text: "This is the famous missing period" in file /codeCaptionMissingPeriod.md contains a mistake: Captions should be terminated with a period (.).'
]

{ #category : 'tests - explanation' }
MicLastPeriodInCaptionCheckerTest >> testConfigurationJSONPart [

	self assert: MicLastPeriodInCaptionChecker objectsForJSONConfigurationPart
]

{ #category : 'tests - explanation' }
MicLastPeriodInCaptionCheckerTest >> testConfigurationPart [

	self 
		assert: (MicLastPeriodInCaptionChecker configurationPartWithNewLine: (Character cr asString)) 
		equals: '{
	"LastPeriodInCaption" : true
}'
]

{ #category : 'tests - configure' }
MicLastPeriodInCaptionCheckerTest >> testConfigureFromFalseUsesDefault [

	checker configureFrom: 'false'.
	self deny: checker isEndingWithPeriod
]

{ #category : 'tests - configure' }
MicLastPeriodInCaptionCheckerTest >> testConfigureFromNilUsesDefault [

	checker configureFrom: nil.
	self deny: checker isEndingWithPeriod.
]

{ #category : 'tests - configure' }
MicLastPeriodInCaptionCheckerTest >> testConfigureFromTrue [

	checker configureFrom: true.
	self assert: checker isEndingWithPeriod
]

{ #category : 'tests' }
MicLastPeriodInCaptionCheckerTest >> testDoublePeriod [
	| document caption |
	
	checker := MicLastPeriodInCaptionChecker new.
	document := Microdown parse: '![figure..](http://pharo.org)'.
	caption := document children first children first. 
	
	checker checkExtraPeriodInFigure: caption.
	self deny: checker results isEmpty.
]

{ #category : 'tests - missing period' }
MicLastPeriodInCaptionCheckerTest >> testFigureCheckerChecksCorrectlyMissingExtraPeriod [

	checker shouldEndWithPeriod.
	checker checkProject: fileSystem / 'figureCaptionEndingWithPeriod.md'.
	self assert: checker isOkay
]

{ #category : 'tests - extra period' }
MicLastPeriodInCaptionCheckerTest >> testFigureCheckerChecksCorrectlyNoExtraPeriod [

	checker shouldNotEndWithPeriod.
	checker checkProject: fileSystem / 'figureCaptionMissingPeriod.md'.
	self assert: checker isOkay
]

{ #category : 'tests - extra period' }
MicLastPeriodInCaptionCheckerTest >> testFigureCheckerIdentifyCorrectlyExtraPeriod [

	checker shouldNotEndWithPeriod.
	checker checkProject: fileSystem / 'figureCaptionEndingWithPeriod.md'.
	self deny: checker isOkay.

	self
		assert: checker results first explanation
		equals: 'Text: "![This is the famous correctly ending period.](figures/f.png)" in file /figureCaptionEndingWithPeriod.md contains a mistake: Captions should not be terminated with a period (.).'
		
]

{ #category : 'tests - missing period' }
MicLastPeriodInCaptionCheckerTest >> testFigureCheckerIdentifyCorrectlyMissingExtraPeriod [

	checker shouldEndWithPeriod.
	checker checkProject: fileSystem / 'figureCaptionMissingPeriod.md'.
	self deny: checker isOkay.

	self
		assert: checker results first explanation 
		equals: 'Text: "![This is the famous missing period](figures/f.png)" in file /figureCaptionMissingPeriod.md contains a mistake: Captions should be terminated with a period (.).'
		
]

{ #category : 'tests - missing period' }
MicLastPeriodInCaptionCheckerTest >> testMathCheckerChecksCorrectlyMissingExtraPeriod [

	checker shouldEndWithPeriod.
	checker checkProject: fileSystem / 'equationCaptionEndingWithPeriod.md'.
	self assert: checker isOkay
]

{ #category : 'tests - extra period' }
MicLastPeriodInCaptionCheckerTest >> testMathCheckerChecksCorrectlyNoExtraPeriod [

	checker shouldNotEndWithPeriod.
	checker checkProject: fileSystem / 'equationCaptionMissingPeriod.md'.
	self assert: checker isOkay
]

{ #category : 'tests - extra period' }
MicLastPeriodInCaptionCheckerTest >> testMathCheckerIdentifyCorrectlyExtraPeriod [

	checker shouldNotEndWithPeriod.
	checker checkProject: fileSystem / 'equationCaptionEndingWithPeriod.md'.
	self deny: checker isOkay.

	self
		assert: checker results first explanation
		equals:
		'Text: "This is the famous correctly ending period." in file /equationCaptionEndingWithPeriod.md contains a mistake: Captions should not be terminated with a period (.).'
]

{ #category : 'tests - missing period' }
MicLastPeriodInCaptionCheckerTest >> testMathCheckerIdentifyCorrectlyMissingExtraPeriod [

	checker shouldEndWithPeriod.
	checker checkProject: fileSystem / 'equationCaptionMissingPeriod.md'.
	self deny: checker isOkay.

	self
		assert: checker results first explanation
		equals:
		'Text: "This is the famous missing period" in file /equationCaptionMissingPeriod.md contains a mistake: Captions should be terminated with a period (.).'
]
