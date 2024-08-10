"
I represent an annotation, a tag with parameters, delimited by `{!` and `!}`.

The following example is a citation annotation with the name variable bound to the string 'Duca99a' as a parameter.

```text
{!citation|name=Duca99a!}
```

```
MicrodownParser parse: '{!citation|name=Duca99a!}'
```
"
Class {
	#name : 'MicAnnotationBlock',
	#superclass : 'MicUnEvaluatedBlock',
	#instVars : [
		'arguments'
	],
	#category : 'Microdown-Model',
	#package : 'Microdown',
	#tag : 'Model'
}

{ #category : 'accessing' }
MicAnnotationBlock class >> closingDelimiter [

 	^ AnnotationCloserMarkup
]

{ #category : 'parsing' }
MicAnnotationBlock class >> key [

	^ 'key'
]

{ #category : 'accessing' }
MicAnnotationBlock class >> openingDelimiter [

 	^ AnnotationOpenerMarkup
]

{ #category : 'parsing' }
MicAnnotationBlock class >> parse: delimiter stream: aTokenStream for: aParser [

	| bodystring arguments tag extensionClass key |
	bodystring := delimiter undelimitedSubstring.
	arguments := MicArgumentList
		             split: bodystring
		             defaultArg: #annotationKind
		             defaultValue: 'Me'.
	tag := arguments defaultValue trimBoth.

	extensionClass := self extensionClassFor: tag.
	
	key := arguments justTheArguments keyAtIndex: 1.
	(arguments at: key) ifNil: [ arguments at: extensionClass key put: key ].
	
	^ extensionClass new
		  bodyString: bodystring;
		  arguments: arguments
]

{ #category : 'visiting' }
MicAnnotationBlock >> accept: aVisitor [
	^ aVisitor visitAnnotation: self
]

{ #category : 'accessing' }
MicAnnotationBlock >> arguments [

	^ arguments
]

{ #category : 'accessing' }
MicAnnotationBlock >> arguments: argumentList [

	arguments := argumentList
]

{ #category : 'accessing' }
MicAnnotationBlock >> name [
	^ arguments defaultValue
]
