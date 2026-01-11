Class {
	#name : 'MicLastPeriodInCaptionCheckerTest',
	#superclass : 'TestCase',
	#instVars : [
		'fileSystem',
		'checker'
	],
	#category : 'Microdown-Rules-CodeLastPeriod',
	#package : 'Microdown-Rules',
	#tag : 'CodeLastPeriod'
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
MicLastPeriodInCaptionCheckerTest >> testFigureCheckerChecksCorrectlyMissingExtraPeriod [

	checker identifyMissingLastPeriod.
	checker checkProject: fileSystem / 'figureCaptionEndingWithPeriod.md'.
	self assert: checker isOkay
]

{ #category : 'tests - extra period' }
MicLastPeriodInCaptionCheckerTest >> testFigureCheckerChecksCorrectlyNoExtraPeriod [

	checker identifyExtraLastPeriod.
	checker checkProject: fileSystem / 'figureCaptionMissingPeriod.md'.
	self assert: checker isOkay
]

{ #category : 'tests - extra period' }
MicLastPeriodInCaptionCheckerTest >> testFigureCheckerIdentifyCorrectlyExtraPeriod [

	checker identifyExtraLastPeriod.
	checker checkProject: fileSystem / 'figureCaptionEndingWithPeriod.md'.
	self deny: checker isOkay.

	self
		assert: checker results first explanation
		equals:
		'Text: "This is the famous correctly ending period." in file/figureCaptionEndingWithPeriod.md contains a mistake: Captions should not be terminated with a period (.).'
]

{ #category : 'tests - missing period' }
MicLastPeriodInCaptionCheckerTest >> testFigureCheckerIdentifyCorrectlyMissingExtraPeriod [

	checker identifyMissingLastPeriod.
	checker checkProject: fileSystem / 'figureCaptionMissingPeriod.md'.
	self deny: checker isOkay.

	self
		assert: checker results first explanation
		equals:
		'Text: "This is the famous missing period" in file/figureCaptionMissingPeriod.md contains a mistake: Captions should be terminated with a period (.).'
]

{ #category : 'tests - missing period' }
MicLastPeriodInCaptionCheckerTest >> testMathCheckerChecksCorrectlyMissingExtraPeriod [

	checker identifyMissingLastPeriod.
	checker checkProject: fileSystem / 'equationCaptionEndingWithPeriod.md'.
	self assert: checker isOkay
]

{ #category : 'tests - extra period' }
MicLastPeriodInCaptionCheckerTest >> testMathCheckerChecksCorrectlyNoExtraPeriod [

	checker identifyExtraLastPeriod.
	checker checkProject: fileSystem / 'equationCaptionMissingPeriod.md'.
	self assert: checker isOkay
]

{ #category : 'tests - extra period' }
MicLastPeriodInCaptionCheckerTest >> testMathCheckerIdentifyCorrectlyExtraPeriod [

	checker identifyExtraLastPeriod.
	checker checkProject: fileSystem / 'equationCaptionEndingWithPeriod.md'.
	self deny: checker isOkay.

	self
		assert: checker results first explanation
		equals:
		'Text: "This is the famous correctly ending period." in file/equationCaptionEndingWithPeriod.md contains a mistake: Captions should not be terminated with a period (.).'
]

{ #category : 'tests - missing period' }
MicLastPeriodInCaptionCheckerTest >> testMathCheckerIdentifyCorrectlyMissingExtraPeriod [

	checker identifyMissingLastPeriod.
	checker checkProject: fileSystem / 'equationCaptionMissingPeriod.md'.
	self deny: checker isOkay.

	self
		assert: checker results first explanation
		equals:
		'Text: "This is the famous missing period" in file/equationCaptionMissingPeriod.md contains a mistake: Captions should be terminated with a period (.).'
]
