"
I represent an annotation delimted by `<?` and '?>`: a tag with parameters.

The following is a citation annotation with as parameters the name variable bound to the string 'Duca99a'.

```
<?citation|name=Duca99a?>
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
	| splitter |
	splitter := MicArgumentsSplitter withString: substring.
	name := splitter name trimBoth.
	arguments := splitter arguments.
]

{ #category : #accessing }
MicAnnotationBlock >> closingDelimiter [

 	^ MicAnnotationCloserDelimiter markup
]

{ #category : #accessing }
MicAnnotationBlock >> kind [

	^ #annotation
]

{ #category : #accessing }
MicAnnotationBlock >> name [
	^ name
]

{ #category : #accessing }
MicAnnotationBlock >> name: aName [
	name := aName
]

{ #category : #accessing }
MicAnnotationBlock >> openingDelimiter [

 	^ MicAnnotationOpenerDelimiter markup
]

{ #category : #accessing }
MicAnnotationBlock >> printOn: aStream [

	aStream nextPutAll: self openingDelimiter.
	aStream nextPutAll: self substring.
	aStream nextPutAll: self closingDelimiter.
]
