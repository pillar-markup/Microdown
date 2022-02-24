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
	#superclass : #MicInlineElement,
	#instVars : [
		'name',
		'arguments'
	],
	#category : #'Microdown-ModelInline'
}

{ #category : #constructor }
MicAnnotationBlock class >> from: aStartInteger to: anEndInteger withSubstring: aString withChildren: aChildren [
	
	| splitter tag klass |
	splitter := MicArgumentsSplitter split: aString defaultArg: #annotationKind defaultValue: 'Me'.
	tag := splitter defaultValue trimBoth.
	
	klass := self subclasses detect: [ :each | each tag = tag ] ifNone: [ self ].

	^ klass new 
		start: aStartInteger; 
		end: anEndInteger; 
		substring: aString; 
		children: aChildren; 
		arguments: splitter;
		cleanSubstring; 
		closeMe; 
		yourself.	
]

{ #category : #accessing }
MicAnnotationBlock class >> tag [
	^ #empty
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
MicAnnotationBlock >> arguments: anArguments [
	arguments := anArguments
]

{ #category : #visiting }
MicAnnotationBlock >> closeMe [ 

	
]

{ #category : #accessing }
MicAnnotationBlock >> closingDelimiter [

 	^ AnnotationCloserMarkup
]

{ #category : #accessing }
MicAnnotationBlock >> kind [

	^ #annotation
]

{ #category : #accessing }
MicAnnotationBlock >> name [
	^ arguments defaultValue
]

{ #category : #accessing }
MicAnnotationBlock >> name: aName [
	self halt: 'should not - picked out from arguments'
]

{ #category : #accessing }
MicAnnotationBlock >> openingDelimiter [

 	^ AnnotationOpenerMarkup
]

{ #category : #accessing }
MicAnnotationBlock >> parameterAt: aKey put: aValue [
	self halt: 'Is this needed???'.
	^ arguments at: aKey put: aValue
]

{ #category : #accessing }
MicAnnotationBlock >> printOn: aStream [

	aStream nextPutAll: self openingDelimiter.
	aStream nextPutAll: self substring.
	aStream nextPutAll: self closingDelimiter.
]
