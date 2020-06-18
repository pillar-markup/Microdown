"
An environment is delimited by a start and end markup and it can have an argument list. 


In Pillar
```
${begin:column|width=40}$
blah blah
${end:column}$
```

Working on
```
${begin:card}$

# I'm Cool

A paragraph about the card.
I will be interpreted as part of the card.

${end:card}$ 
```




This is important to support better column in the future:

```
${slide:title=Class Methods}$

${columns}$

${column:width=60}$

+>file://figures/Point-xy-class-method.png|width=90+

${column:width=40}$

- press the button ==class== to define a class method
- in lectures, we add ==class==

${endColumns}$
```


### Implementation limits
The contents of an environment cannot really contain other blocks.

"
Class {
	#name : #MicEnvironmentBlock,
	#superclass : #MicStartStopMarkupBlock,
	#instVars : [
		'arguments',
		'name'
	],
	#category : #'Microdown-Model'
}

{ #category : #accessing }
MicEnvironmentBlock >> arguments [
	
	^ arguments
]

{ #category : #converting }
MicEnvironmentBlock >> asPillarWithTag: aTag withParameters: aDictionnary [
	| classPillar |
	classPillar := PRAbstractAnnotation findClassAcceptingTag: aTag ifNone: [ PRUndefinedAnnotation ].
	^ classPillar new parameters: aDictionnary
]

{ #category : #accessing }
MicEnvironmentBlock >> extractFirstLineFrom: aLine [

	| lineWithoutMarkup lineStream resultArray |
	lineWithoutMarkup := super extractFirstLineFrom: aLine.
	lineStream := lineWithoutMarkup readStream.
	resultArray := self findNameAndArguments: lineStream.
	name := resultArray first.
	arguments := resultArray second.
	^ lineWithoutMarkup
]

{ #category : #'as yet unclassified' }
MicEnvironmentBlock >> findNameAndArguments: aStream [
	| foundName foundArguments | 
	foundName := aStream upTo: self parserClass argumentListStartDelimiter first.
	foundArguments := ZnResourceMetaUtils parseQueryFrom: aStream.
	^ { foundName . foundArguments } asArray
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
