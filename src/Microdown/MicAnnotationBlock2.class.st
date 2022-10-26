"
I represent an annotation delimted by `{!` and `!}`: a tag with parameters.

The following is a citation annotation with as parameters the name variable bound to the string 'Duca99a'.

```text
{!citation|name=Duca99a!}
```

```
MicroDownParser parse: '{!citation|name=Duca99a!}'
```
"
Class {
	#name : #MicAnnotationBlock2,
	#superclass : #MicUnEvaluatedBlock2,
	#instVars : [
		'arguments'
	],
	#category : #'Microdown-InlineParser'
}

{ #category : #visiting }
MicAnnotationBlock2 >> accept: aVisitor [
	^ aVisitor visitAnnotation: self
]

{ #category : #accessing }
MicAnnotationBlock2 >> arguments [

	^ arguments
]

{ #category : #visiting }
MicAnnotationBlock2 >> closeMe [
	arguments := MicArgumentList split: bodystring.
]
