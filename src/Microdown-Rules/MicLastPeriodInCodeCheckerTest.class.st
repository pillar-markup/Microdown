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
MicLastPeriodInCodeCheckerTest >> testCheckerChecksCorrectlyMissingExtraPeriod [

	checker shouldEndWithPeriod.
	checker checkProject: fileSystem / 'codeEndingWithPeriod.md'.
	self assert: checker isOkay.

]

{ #category : 'tests - missing period' }
MicLastPeriodInCodeCheckerTest >> testCheckerChecksCorrectlyMissingExtraPeriodWithExtraEmptyLines [

	checker shouldEndWithPeriod.
	checker checkProject: fileSystem / 'codeEndingWithPeriodAndEmptyLinesWithTabSpaces.md'.
	self assert: checker isOkay
]

{ #category : 'tests - missing period' }
MicLastPeriodInCodeCheckerTest >> testCheckerChecksCorrectlyMissingExtraPeriodWithExtraSpaces [
	"may be the author wants all the code to finish with an extra period.
	so we configure the checker to do so."

	checker shouldEndWithPeriod.
	checker checkProject: fileSystem / 'codeEndingWithPeriodAndExtraSpaces.md'.
	self assert: checker isOkay
]

{ #category : 'tests - extra period' }
MicLastPeriodInCodeCheckerTest >> testCheckerChecksCorrectlyNoExtraPeriod [

	checker shouldNotEndWithPeriod.
	checker checkProject: fileSystem / 'codeNotEndingWithPeriod.md'.
	self assert: checker isOkay
]

{ #category : 'tests - extra period' }
MicLastPeriodInCodeCheckerTest >> testCheckerIdentifyCorrectlyExtraPeriod [

	checker shouldNotEndWithPeriod.
	checker checkProject: fileSystem / 'codeEndingWithPeriod.md'.
	self deny: checker isOkay.

	self assert: checker results first explanation equals: '- Text: "setX: xInt setY: yInt

	x := xInt.
	y := yInt." in file/codeEndingWithPeriod.md contains a mistake: It should not be terminated with a period (.).'
]

{ #category : 'tests - extra period' }
MicLastPeriodInCodeCheckerTest >> testCheckerIdentifyCorrectlyExtraPeriodWithExtraEmptyLines [

	checker shouldNotEndWithPeriod.
	checker checkProject: fileSystem / 'codeEndingWithPeriodAndEmptyLinesWithTabSpaces.md'.
	self deny: checker isOkay.

	self assert: checker results first explanation equals: '- Text: "setX: xInt setY: yInt

	x := xInt.
	y := yInt.

		
            " in file/codeEndingWithPeriodAndEmptyLinesWithTabSpaces.md contains a mistake: It should not be terminated with a period (.).'  
]

{ #category : 'tests - extra period' }
MicLastPeriodInCodeCheckerTest >> testCheckerIdentifyCorrectlyExtraPeriodWithExtraSpaces [

	checker shouldNotEndWithPeriod.
	checker checkProject: fileSystem / 'codeEndingWithPeriodAndEmptyLinesWithTabSpaces.md'.
	self deny: checker isOkay.

	self assert: checker results first explanation equals: '- Text: "setX: xInt setY: yInt

	x := xInt.
	y := yInt.

		
            " in file/codeEndingWithPeriodAndEmptyLinesWithTabSpaces.md contains a mistake: It should not be terminated with a period (.).'
]

{ #category : 'tests - missing period' }
MicLastPeriodInCodeCheckerTest >> testCheckerIdentifyCorrectlyMissingExtraPeriod [
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

	self assert: MicLastPeriodInCodeChecker configurationJSONPart equals: 'true' 
]

{ #category : 'tests - explanation' }
MicLastPeriodInCodeCheckerTest >> testConfigurationPart [

	self 
		assert: (MicLastPeriodInCodeChecker configurationPartWithNewLine: (Character cr asString)) 
		equals: '{
	"LastPeriodInCode" : "true"
}'
	
]

{ #category : 'tests - configure' }
MicLastPeriodInCodeCheckerTest >> testConfigureFromEmptyString [

	checker configureFrom: ''.
	self deny: checker isEndingWithPeriod
]

{ #category : 'tests - configure' }
MicLastPeriodInCodeCheckerTest >> testConfigureFromGarbage [

	checker configureFrom: 234.
	self deny: checker isEndingWithPeriod
]

{ #category : 'tests - configure' }
MicLastPeriodInCodeCheckerTest >> testConfigureFromNil [

	checker configureFrom: nil.
	self deny: checker isEndingWithPeriod
]

{ #category : 'tests - configure' }
MicLastPeriodInCodeCheckerTest >> testConfigureFromNo [

	checker configureFrom: 'no'.
	self deny: checker isEndingWithPeriod
]

{ #category : 'tests - configure' }
MicLastPeriodInCodeCheckerTest >> testConfigureFromYes [
	
	checker configureFrom: 'yes'.
	self deny: checker isEndingWithPeriod
]
