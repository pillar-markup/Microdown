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

{ #category : #parsing }
MicAnnotationBlock2 class >> parse: delimiter stream: aTokenStream for: aParser [
	| bodystring arguments tag extensionClass |
	bodystring := delimiter undelimitedSubstring.
	arguments := MicArgumentList
		            split: bodystring
		            defaultArg: #annotationKind
		            defaultValue: 'Me'.
	tag := arguments defaultValue trimBoth.

	extensionClass := self extensionClassFor: tag.
	
	^ extensionClass new
		bodystring: bodystring;
		arguments: arguments
]

{ #category : #visiting }
MicAnnotationBlock2 >> accept: aVisitor [
	^ aVisitor visitAnnotation: self
]

{ #category : #accessing }
MicAnnotationBlock2 >> arguments [

	^ arguments
]

{ #category : #accessing }
MicAnnotationBlock2 >> arguments: argumentList [

	arguments := argumentList
]

{ #category : #accessing }
MicAnnotationBlock2 >> name [
	^ arguments defaultValue
]
