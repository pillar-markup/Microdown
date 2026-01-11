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

{ #category : 'tests - extra period' }
MicLastPeriodInCaptionCheckerTest >> testCheckerChecksCorrectlyNoExtraPeriod [

	checker identifyExtraLastPeriod.
	checker checkProject: fileSystem / 'codeNotEndingWithPeriod.md'.
	self assert: checker isOkay
]

{ #category : 'tests - extra period' }
MicLastPeriodInCaptionCheckerTest >> testCheckerIdentifyCorrectlyExtraPeriod [

	checker identifyExtraLastPeriod.
	checker checkProject: fileSystem / 'codeEndingWithPeriod.md'.
	self deny: checker isOkay.

	self assert: checker results first explanation equals: 'Text: "setX: xInt setY: yInt

	x := xInt.
	y := yInt." in file/codeEndingWithPeriod.md contains a mistake: It should not be terminated with a period (.).'
]

{ #category : 'tests - extra period' }
MicLastPeriodInCaptionCheckerTest >> testCheckerIdentifyCorrectlyExtraPeriodWithExtraEmptyLines [
	checker identifyExtraLastPeriod.
	checker checkProject: fileSystem / 'codeEndingWithPeriodAndEmptyLines.md'.
	self deny: checker isOkay.

	self assert: checker results first explanation equals: 'Text: "setX: xInt setY: yInt

	x := xInt.
	y := yInt.           " in file/codeEndingWithPeriodAndEmptyLines.md contains a mistake: It should not be terminated with a period (.).'
]

{ #category : 'tests - extra period' }
MicLastPeriodInCaptionCheckerTest >> testCheckerIdentifyCorrectlyExtraPeriodWithExtraSpaces [

	checker identifyExtraLastPeriod.
	checker checkProject: fileSystem / 'codeEndingWithPeriodAndEmptyLines.md'.
	self deny: checker isOkay.

	self assert: checker results first explanation equals: 'Text: "setX: xInt setY: yInt

	x := xInt.
	y := yInt.           " in file/codeEndingWithPeriodAndEmptyLines.md contains a mistake: It should not be terminated with a period (.).'
]

{ #category : 'tests - missing period' }
MicLastPeriodInCaptionCheckerTest >> testFigureCheckerChecksCorrectlyMissingExtraPeriod [

	checker identifyMissingLastPeriod.
	checker checkProject: fileSystem / 'figureCaptionEndingWithPeriod.md'.
	self assert: checker isOkay
]

{ #category : 'tests - missing period' }
MicLastPeriodInCaptionCheckerTest >> testFigureCheckerIdentifyCorrectlyMissingExtraPeriod [

	checker identifyMissingLastPeriod.
	checker checkProject: fileSystem / 'figureCaptionMissingPeriod.md'.
	self deny: checker isOkay.

	self
		assert: checker results first explanation
		equals:
		'Text: "This is the famous missing period" in file/figureCaptionMissingPeriod.md contains a mistake: It should be terminated with a period (.).'
]
