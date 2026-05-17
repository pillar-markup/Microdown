"
I'm verifying that code block either ends with a terminating period or not depending on my configuration.


For example authors may want to detect useless period as in the following code snippet

```
setX: xInt setY: yInt

	x := xInt.
	y := yInt.
```

They may want to verify systematically the inverse.
For example the following code follows that the code in a code block should not be terminated by a period.

```
setX: xInt setY: yInt

	x := xInt.
	y := yInt
```
"
Class {
	#name : 'MicLastPeriodInCodeChecker',
	#superclass : 'MicLastPeriodChecker',
	#category : 'Microdown-BookTester-Checker-LastPeriod',
	#package : 'Microdown-BookTester',
	#tag : 'Checker-LastPeriod'
}

{ #category : 'public - name' }
MicLastPeriodInCodeChecker class >> checkerName [ 
	^ 'LastPeriodInCode'
]

{ #category : 'public - name' }
MicLastPeriodInCodeChecker class >> objectsForJSONConfigurationPart [

	^ true
]

{ #category : 'checking' }
MicLastPeriodInCodeChecker >> checkExtraPeriodIn: aMicCodeBlock [

	aMicCodeBlock body trimRight last = $. ifTrue: [
			results add: (MicPeriodInCodeResult new
					 micElement: aMicCodeBlock;
					 inFile: aMicCodeBlock fromFile;
					 codeShouldEndWithPeriod: isEndingWithPeriod) ]
]

{ #category : 'checking' }
MicLastPeriodInCodeChecker >> checkMissingPeriodIn: aMicCodeBlock [

	aMicCodeBlock body trimRight last = $. ifFalse: [
			results add: (MicPeriodInCodeResult new
					 micElement: aMicCodeBlock;
					 inFile: aMicCodeBlock fromFile;
					 codeShouldEndWithPeriod: isEndingWithPeriod) ]
]

{ #category : 'initialization' }
MicLastPeriodInCodeChecker >> initialize [ 
	super initialize. 
	isEndingWithPeriod := false
]

{ #category : 'visiting' }
MicLastPeriodInCodeChecker >> visitCode: aCodeBlockElement [

	isEndingWithPeriod 
		ifTrue: [ self checkMissingPeriodIn: aCodeBlockElement ]
		ifFalse: [ self checkExtraPeriodIn: aCodeBlockElement ]
]
