"
An environment is delimited by a start and end markup and it can have an argument list. 
By default I do not handle any form of formatting in the potential arguments.

## Syntax


```
<?

?>
```


This class needs another pass to support nested mic elements inside its delimiter.

In Pillar
```
${begin:column|width=40}$
blah blah
${end:column}$
```

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

{ #category : #visiting }
MicEnvironmentBlock >> accept: aVisitor [
 	^ aVisitor visitEnvironmentBlock: self
]

{ #category : #accessing }
MicEnvironmentBlock >> arguments [
	
	^ arguments
]

{ #category : #accessing }
MicEnvironmentBlock >> extractFirstLineFrom: aLine [

	| lineWithoutMarkup argumentsSplitter |
	lineWithoutMarkup := super extractFirstLineFrom: aLine.
	argumentsSplitter := MicArgumentsSplitter withString: lineWithoutMarkup.
	name := argumentsSplitter name.
	arguments := argumentsSplitter arguments.
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
