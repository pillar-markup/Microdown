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
	#category : 'Microdown-Rules-CodeLastPeriod',
	#package : 'Microdown-Rules',
	#tag : 'CodeLastPeriod'
}

{ #category : 'visiting - inline elements' }
MicLastPeriodInCaptionChecker >> visitFigure: aFigure [

	codeShouldEndWithPeriod
		ifTrue: [ self checkMissingPeriodIn: aFigure ]
		ifFalse: [ self checkExtraPeriodIn: aFigure ]
]
