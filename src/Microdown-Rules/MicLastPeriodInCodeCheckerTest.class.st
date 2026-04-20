Class {
	#name : 'MicLastPeriodInCodeCheckerTest',
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
MicLastPeriodInCodeCheckerTest >> generateFilesystemExample [

	| file |
	file := fileSystem workingDirectory / 'codeEndingWithPeriod.md'.
	file writeStreamDo: [ :stream |
			stream nextPutAll: '

Authors may want to detect useless period as in the following code snippet

```
setX: xInt setY: yInt

	x := xInt.
	y := yInt.
```
' ].

	file := fileSystem workingDirectory / 'codeNotEndingWithPeriod.md'.
	file writeStreamDo: [ :stream |
			stream nextPutAll: '

Here the code does not a useless period.
```
setX: xInt setY: yInt

	x := xInt.
	y := yInt
```
' ].

	file := fileSystem workingDirectory / 'codeEndingWithPeriodAndExtraSpaces.md'.
	file writeStreamDo: [ :stream |
			stream nextPutAll: '

Authors may want to detect useless period as in the following code snippet

```
setX: xInt setY: yInt

	x := xInt.
	y := yInt.             
```
' ].


	file := fileSystem workingDirectory / 'codeEndingWithPeriodAndEmptyLinesWithTabSpaces.md'.
	file writeStreamDo: [ :stream |
			stream nextPutAll: '

Authors may want to detect useless period as in the following code snippet

```
setX: xInt setY: yInt

	x := xInt.
	y := yInt.

		
            
```
' ].
	

]

{ #category : 'running' }
MicLastPeriodInCodeCheckerTest >> setUp [

	super setUp.
	fileSystem := FileSystem memory.
	self generateFilesystemExample.

	checker := MicLastPeriodInCodeChecker new.
	
]

{ #category : 'tests - missing period' }
MicLastPeriodInCodeCheckerTest >> testChecksCorrectlyMissingPeriod [

	checker shouldEndWithPeriod.
	checker checkProject: fileSystem / 'codeEndingWithPeriod.md'.
	self assert: checker isOkay.

]

{ #category : 'tests - missing period' }
MicLastPeriodInCodeCheckerTest >> testChecksCorrectlyMissingPeriodWithExtraEmptyLines [

	checker shouldEndWithPeriod.
	checker checkProject: fileSystem / 'codeEndingWithPeriodAndEmptyLinesWithTabSpaces.md'.
	self assert: checker isOkay
]

{ #category : 'tests - missing period' }
MicLastPeriodInCodeCheckerTest >> testChecksCorrectlyMissingPeriodWithExtraSpaces [
	"may be the author wants all the code to finish with an extra period.
	so we configure the checker to do so."

	checker shouldEndWithPeriod.
	checker checkProject: fileSystem / 'codeEndingWithPeriodAndExtraSpaces.md'.
	self assert: checker isOkay
]

{ #category : 'tests - missing period' }
MicLastPeriodInCodeCheckerTest >> testChecksMissingPeriod [
	"may be the author wants all the code to finish with an extra period.
	so we configure the checker to do so."

	checker shouldEndWithPeriod.
	checker checkProject: fileSystem / 'codeNotEndingWithPeriod.md'.
	self deny: checker isOkay.

	self assert: checker results first explanation equals: '- Text: "setX: xInt setY: yInt

	x := xInt.
	y := yInt" in file/codeNotEndingWithPeriod.md contains a mistake: It should be terminated with a period (.).'
]

{ #category : 'tests - explanation' }
MicLastPeriodInCodeCheckerTest >> testConfigurationJSONPart [

	self assert: MicLastPeriodInCodeChecker configurationJSONPart
]

{ #category : 'tests - explanation' }
MicLastPeriodInCodeCheckerTest >> testConfigurationPart [

	self 
		assert: (MicLastPeriodInCodeChecker configurationPartWithNewLine: (Character cr asString)) 
		equals: '{
	"LastPeriodInCode" : true
}'
]

{ #category : 'tests - configure' }
MicLastPeriodInCodeCheckerTest >> testConfigureFromEmptyStringUsesDefault [

	checker configureFrom: ''.
	self deny: checker isEndingWithPeriod
]

{ #category : 'tests - configure' }
MicLastPeriodInCodeCheckerTest >> testConfigureFromGarbage [

	checker configureFrom: 234.
	self deny: checker isEndingWithPeriod
]

{ #category : 'tests - configure' }
MicLastPeriodInCodeCheckerTest >> testConfigureFromNilUsesDefault [

	checker configureFrom: nil.
	self deny: checker isEndingWithPeriod
]

{ #category : 'tests - configure' }
MicLastPeriodInCodeCheckerTest >> testConfigureWithBoolean [
	
	checker configureFrom: true.
	self assert: checker isEndingWithPeriod
]

{ #category : 'tests - configure' }
MicLastPeriodInCodeCheckerTest >> testConfigureWithBooleanStringUsesDefault [
	
	checker configureFrom: 'true'.
	self deny: checker isEndingWithPeriod
]

{ #category : 'tests' }
MicLastPeriodInCodeCheckerTest >> testDefault [
	| checker |
	checker := MicLastPeriodChecker new.
	self deny: checker isEndingWithPeriod.
]

{ #category : 'tests - missing period' }
MicLastPeriodInCodeCheckerTest >> testDefaultIsToDetectEndingPeriod [

	checker checkProject: fileSystem / 'codeEndingWithPeriod.md'.
	self deny: checker isOkay

]

{ #category : 'tests - extra period' }
MicLastPeriodInCodeCheckerTest >> testNotTerminatedByPeriodPass [

	checker shouldNotEndWithPeriod.
	checker checkProject: fileSystem / 'codeNotEndingWithPeriod.md'.
	self assert: checker isOkay
]

{ #category : 'tests - extra period' }
MicLastPeriodInCodeCheckerTest >> testTerminatedByPeriodPass [

	checker shouldNotEndWithPeriod.
	checker checkProject: fileSystem / 'codeEndingWithPeriod.md'.
	self deny: checker isOkay.

	self assert: checker results first explanation equals: '- Text: "setX: xInt setY: yInt

	x := xInt.
	y := yInt." in file/codeEndingWithPeriod.md contains a mistake: It should not be terminated with a period (.).'
]

{ #category : 'tests - extra period' }
MicLastPeriodInCodeCheckerTest >> testTerminatedByPeriodWithExtraEmptyLinesPass [

	checker shouldNotEndWithPeriod.
	checker checkProject: fileSystem / 'codeEndingWithPeriodAndEmptyLinesWithTabSpaces.md'.
	self deny: checker isOkay.

	self assert: checker results first explanation equals: '- Text: "setX: xInt setY: yInt

	x := xInt.
	y := yInt.

		
            " in file/codeEndingWithPeriodAndEmptyLinesWithTabSpaces.md contains a mistake: It should not be terminated with a period (.).'  
]

{ #category : 'tests - extra period' }
MicLastPeriodInCodeCheckerTest >> testTerminatedByPeriodWithExtraSpacesPass [

	checker shouldNotEndWithPeriod.
	checker checkProject: fileSystem / 'codeEndingWithPeriodAndEmptyLinesWithTabSpaces.md'.
	self deny: checker isOkay.

	self assert: checker results first explanation equals: '- Text: "setX: xInt setY: yInt

	x := xInt.
	y := yInt.

		
            " in file/codeEndingWithPeriodAndEmptyLinesWithTabSpaces.md contains a mistake: It should not be terminated with a period (.).'
]
