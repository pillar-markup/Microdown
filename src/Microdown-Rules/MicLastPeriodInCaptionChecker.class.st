"
I'm verifying that caption in figure, math equation or code block either ends with a terminating period or not depending on my configuration.


For example authors may want to detect a missing period as in the following elements:

```caption='This is the famous missing period'
setX: xInt setY: yInt

	...
```

```
!['This is the famous missing period' ](figures/f.png)
```

```
$$%caption='This is the famous missing period'
\frac{1}{2}
$$
```
"
Class {
	#name : 'MicLastPeriodInCaptionChecker',
	#superclass : 'MicLastPeriodChecker',
	#instVars : [
		'levelThreshold'
	],
	#category : 'Microdown-Rules-LastPeriod',
	#package : 'Microdown-Rules',
	#tag : 'LastPeriod'
}

{ #category : 'public - name' }
MicLastPeriodInCaptionChecker class >> checkerName [ 
	^ 'LastPeriodInCaption'
]

{ #category : 'public - name' }
MicLastPeriodInCaptionChecker class >> objectsForJSONConfigurationPart [

	^ true
]

{ #category : 'visiting - inline elements' }
MicLastPeriodInCaptionChecker >> checkExtraPeriodInCode: aCode [
	"we should revise the API of elements to be able to identify adorment for Equation, Figure and code block."

	| captionText |
	captionText := self computeMathCaptionOf: aCode.
	captionText ifEmpty: [ ^ self ].

	captionText trimRight last = $. ifTrue: [
			results add: (MicPeriodInCaptionResult new
					 micElement: aCode;
					 inFile: aCode fromFile;
					 codeShouldEndWithPeriod: isEndingWithPeriod) ]
]

{ #category : 'visiting - inline elements' }
MicLastPeriodInCaptionChecker >> checkExtraPeriodInFigure: aFigure [
	"we should revise the API of elements to be able to identify adorment for Equation, Figure and code block."

	aFigure caption trimRight last = $. ifTrue: [
			results add: (MicPeriodInCaptionResult new
					 micElement: aFigure;
					 inFile: aFigure fromFile;
					 codeShouldEndWithPeriod: isEndingWithPeriod) ]
]

{ #category : 'visiting - inline elements' }
MicLastPeriodInCaptionChecker >> checkExtraPeriodInMath: aMath [
	"we should revise the API of elements to be able to identify adorment for Equation, Figure and code block."

	| captionText |
	captionText := self computeMathCaptionOf: aMath.
	captionText ifEmpty: [ ^ self ].
	captionText trimRight last = $. ifTrue: [
			results add: (MicPeriodInCaptionResult new
					 micElement: aMath;
					 inFile: aMath fromFile;
					 codeShouldEndWithPeriod: isEndingWithPeriod) ]
]

{ #category : 'visiting - inline elements' }
MicLastPeriodInCaptionChecker >> checkMissingPeriodInCode: aCode [

	| captionText |
	captionText := self computeMathCaptionOf: aCode.
	captionText ifEmpty: [ ^ self ].

	captionText trimRight last = $. ifFalse: [
			results add: (MicPeriodInCaptionResult new
					 micElement: aCode;
					 inFile: aCode fromFile;
					 codeShouldEndWithPeriod: isEndingWithPeriod) ]
]

{ #category : 'visiting - inline elements' }
MicLastPeriodInCaptionChecker >> checkMissingPeriodInFigure: aFigure [

	aFigure caption trimRight last = $. ifFalse: [
			results add: (MicPeriodInCaptionResult new
					 micElement: aFigure;
					 inFile: aFigure fromFile;
					 codeShouldEndWithPeriod: isEndingWithPeriod) ]
]

{ #category : 'visiting - inline elements' }
MicLastPeriodInCaptionChecker >> checkMissingPeriodInMath: aMath [

	
	| captionText |
	captionText := self computeMathCaptionOf: aMath.
	captionText ifEmpty: [ ^ self ].

	captionText trimRight last = $. ifFalse: [
			results add: (MicPeriodInCaptionResult new
					 micElement: aMath;
					 inFile: aMath fromFile;
					 codeShouldEndWithPeriod: isEndingWithPeriod) ]
]

{ #category : 'helpers' }
MicLastPeriodInCaptionChecker >> computeMathCaptionOf: aMath [

	^ ' ' join: (aMath captionElements collect: [ :each | each text ])
]

{ #category : 'visiting - inline elements' }
MicLastPeriodInCaptionChecker >> visitCode: anEquation [
	"we should revise the API of elements to be able to identify adorment for Equation, Figure and code block."

	"this way we could share the same logic between all the elements."

	isEndingWithPeriod
		ifTrue: [ self checkMissingPeriodInCode: anEquation ]
		ifFalse: [ self checkExtraPeriodInCode: anEquation ]
]

{ #category : 'visiting - inline elements' }
MicLastPeriodInCaptionChecker >> visitFigure: aFigure [

	isEndingWithPeriod
		ifTrue: [ self checkMissingPeriodInFigure: aFigure ]
		ifFalse: [ self checkExtraPeriodInFigure: aFigure ]
]

{ #category : 'visiting - inline elements' }
MicLastPeriodInCaptionChecker >> visitMath: anEquation [
	"we should revise the API of elements to be able to identify adorment for Equation, Figure and code block."
	"this way we could share the same logic between all the elements."

	isEndingWithPeriod
		ifTrue: [ self checkMissingPeriodInMath: anEquation ]
		ifFalse: [ self checkExtraPeriodInMath: anEquation ]
]
