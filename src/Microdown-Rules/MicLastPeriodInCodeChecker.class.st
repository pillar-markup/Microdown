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
	#category : 'Microdown-Rules-CodeLastPeriod',
	#package : 'Microdown-Rules',
	#tag : 'CodeLastPeriod'
}

{ #category : 'visiting' }
MicLastPeriodInCodeChecker >> visitCode: aCodeBlockElement [

	codeShouldEndWithPeriod 
		ifTrue: [ self checkMissingPeriodIn: aCodeBlockElement ]
		ifFalse: [ self checkExtraPeriodIn: aCodeBlockElement ]
]
