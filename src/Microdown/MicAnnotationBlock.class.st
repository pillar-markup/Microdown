"
I represent an annotation, a tag with parameters, delimited by `{!` and `!}`.
I'm composed of a tag and a list of valued keys following the syntax `tag|key1=value1&key2=value2`

The following example is a citation annotation with the name variable bound to the string 'Duca99a' as a parameter.

```text
{!citation|ref=Duca99a!}
```

```
MicrodownParser parse: '{!citation|ref=Duca99a!}'
```

Note that the first key (that should be defined on the class side via the key method) can be omitted.
So 

```text
{!citation|ref=Duca99a!}
```

is equivalent to 

```text
{!citation|Duca99a!}
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

	| bodystring arguments tag extensionClass |
	bodystring := delimiter undelimitedSubstring.
	arguments := MicArgumentList
		             split: bodystring
		             defaultArg: #annotationKind
		             defaultValue: 'Me'.
	tag := arguments defaultValue trimBoth.

	extensionClass := self extensionClassFor: tag.
	
	arguments justTheArguments ifNotEmpty: [ | key |
		key := arguments justTheArguments keyAtIndex: 1.
	(arguments at: key) ifNil: [ arguments at: extensionClass key put: key ]]. 
	
	
	
	^ extensionClass new
		  bodyString: bodystring;
		  arguments: arguments
]

{ #category : 'parsing' }
MicAnnotationBlock class >> tag [
	"Return the identifier of annotation e.g. tag in tag|key=value"
	
	^ self subclassResponsibility 
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
