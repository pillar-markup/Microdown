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
		'arguments'
	],
	#category : #'Microdown-ModelInline'
}

{ #category : #documentation }
MicAnnotationBlock class >> addDocumentDefinedAnnotations: aBuilder [
	| currentDefinedTags |
	currentDefinedTags := self allSubclasses collect: [ :subclass | subclass tag -> subclass name].
	aBuilder newLine.
	aBuilder header: [ aBuilder text: 'Defined annotations' ] withLevel: 2.
	aBuilder unorderedListDuring: [ 
		currentDefinedTags do: [:tagAndClass | 
	
			aBuilder item: [ 
				aBuilder 
					bold: [aBuilder text: tagAndClass key];
					text: ' defined by ';
					monospace: tagAndClass value
					]]
		 ]
]

{ #category : #documentation }
MicAnnotationBlock class >> buildMicroDownUsing: aBuilder withComment: aString [
	
	super buildMicroDownUsing: aBuilder withComment: aString.
	self addDocumentDefinedAnnotations: aBuilder
]

{ #category : #accessing }
MicAnnotationBlock class >> closingDelimiter [

 	^ AnnotationCloserMarkup
]

{ #category : #constructor }
MicAnnotationBlock class >> from: aStartInteger to: anEndInteger withSubstring: aString withChildren: aChildren [

	| splitter tag extensionClass |
	splitter := MicArgumentList
		            split: aString
		            defaultArg: #annotationKind
		            defaultValue: 'Me'.
	tag := splitter defaultValue trimBoth.

	extensionClass := self extensionClassFor: tag.

	^ extensionClass new
		  start: aStartInteger;
		  end: anEndInteger;
		  substring: aString;
		  children: aChildren;
		  arguments: splitter;
		  closeMe;
		  cleanSubstring;
		  yourself
]

{ #category : #accessing }
MicAnnotationBlock class >> openingDelimiter [

 	^ AnnotationOpenerMarkup
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
	^ self class closingDelimiter
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
MicAnnotationBlock >> openingDelimiter [
	^ self class openingDelimiter
]

{ #category : #accessing }
MicAnnotationBlock >> printOn: aStream [

	aStream nextPutAll: self openingDelimiter.
	aStream nextPutAll: self substring.
	aStream nextPutAll: self closingDelimiter.
]
