"
An environment is delimited by a start and end markup and it can have an argument list. 

${begin:column|width=40}$
blah blah
${end:column}$


Working on
${begin:card}$

# I'm Cool

A paragraph about the card.
I will be interpreted as part of the card.

${end:card}$ 





This is important to support better column in the future

${slide:title=Class Methods}$

${columns}$

${column:width=60}$

+>file://figures/Point-xy-class-method.png|width=90+

${column:width=40}$

- press the button ==class== to define a class method
- in lectures, we add ==class==

${endColumns}$

```
Point class >> x: xInteger y: yInteger 
  ""Answer an instance of me with coordinates xInteger and yInteger.""

  ^ self basicNew setX: xInteger setY: yInteger
```


"
Class {
	#name : #MicEnvironmentBlock,
	#superclass : #GHMStartStopMarkupBlock,
	#instVars : [
		'arguments',
		'name'
	],
	#category : #Microdown
}

{ #category : #accessing }
MicEnvironmentBlock >> arguments [
	
	^ arguments ifNil: [ | foundIndex |
		foundIndex := firstLine indexOf: parser argumentListStartDelimiter first.
		arguments := foundIndex = 0
			ifTrue: [ Dictionary new ]
			ifFalse: [ ZnResourceMetaUtils parseQueryFrom: (firstLine copyFrom: foundIndex to: firstLine size) readStream ] ]
]

{ #category : #accessing }
MicEnvironmentBlock >> extractFirstLineFrom: aLine [

	| lineWithoutMarkup lineStream |
	lineWithoutMarkup := super extractFirstLineFrom: aLine.
	lineStream := lineWithoutMarkup readStream.
	name := lineStream upTo: parser argumentListStartDelimiter first.
	arguments := ZnResourceMetaUtils parseQueryFrom: lineStream.
	^ lineWithoutMarkup
]

{ #category : #markups }
MicEnvironmentBlock >> lineStartMarkup [

	^ parser environmentOpeningBlockMarkup 
]

{ #category : #markups }
MicEnvironmentBlock >> lineStopMarkup [

	^ parser environmentClosingBlockMarkup 
]

{ #category : #accessing }
MicEnvironmentBlock >> name [

	^ name
]
