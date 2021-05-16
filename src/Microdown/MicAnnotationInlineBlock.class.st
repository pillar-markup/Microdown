"
I represent an annotation delimted by `<?` and '?>`: a tag with parameters.

The following is a citation annotation with as parameters the name variable bound to the string 'Duca99a'.

```
<?citation|name=Duca99a?>
```


"
Class {
	#name : #MicAnnotationInlineBlock,
	#superclass : #MicAbstractInlineBlock,
	#instVars : [
		'name',
		'arguments'
	],
	#category : #'Microdown-ModelInline'
}

{ #category : #accessing }
MicAnnotationInlineBlock >> arguments [
	^ arguments
]

{ #category : #accessing }
MicAnnotationInlineBlock >> closingDelimiter [

 	^ MicAnnotationCloserDelimiter markup
]

{ #category : #accessing }
MicAnnotationInlineBlock >> name [
	^ name
]

{ #category : #accessing }
MicAnnotationInlineBlock >> openingDelimiter [

 	^ MicAnnotationOpenerDelimiter markup
]

{ #category : #accessing }
MicAnnotationInlineBlock >> printOn: aStream [

	aStream nextPutAll: self openingDelimiter.
	Halt once.
	aStream nextPutAll: self substring.
	aStream nextPutAll: self closingDelimiter.
]
