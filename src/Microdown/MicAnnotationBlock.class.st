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
	#name : #MicAnnotationBlock,
	#superclass : #MicUnEvaluatedBlock,
	#instVars : [
		'arguments'
	],
	#category : #'Microdown-InlineParser'
}

{ #category : #accessing }
MicAnnotationBlock class >> closingDelimiter [

 	^ AnnotationCloserMarkup
]

{ #category : #accessing }
MicAnnotationBlock class >> openingDelimiter [

 	^ AnnotationOpenerMarkup
]

{ #category : #parsing }
MicAnnotationBlock class >> parse: delimiter stream: aTokenStream for: aParser [
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
MicAnnotationBlock >> accept: aVisitor [
	^ aVisitor visitAnnotation: self
]

{ #category : #accessing }
MicAnnotationBlock >> arguments [

	^ arguments
]

{ #category : #accessing }
MicAnnotationBlock >> arguments: argumentList [

	arguments := argumentList
]

{ #category : #accessing }
MicAnnotationBlock >> name [
	^ arguments defaultValue
]
