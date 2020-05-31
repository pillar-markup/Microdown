"
I'm a builder that encapsulates how bloc and inline are build to represent correct microdown expressions. 

Here is an example

```language=pharo
aBuilder 
	buildCodeblockTag: #pharo 
	withBody: '1 + 2'
```

will produce the code bloc.

### Implementation notes
The design of the builder may be different. Feel free to join and improve it. We also need covering more elements.
"
Class {
	#name : #MicBuilder,
	#superclass : #Object,
	#instVars : [
		'stream',
		'parserClass'
	],
	#category : #'Microdown-Model'
}

{ #category : #building }
MicBuilder >> buildCodeblockTag: aString withBody: aString2 [ 
	
	stream
		nextPutAll: parserClass codeblockMarkup ; 
		nextPutAll: 'language=', aString;
		cr;
		nextPutAll: aString2;
		cr;
		nextPutAll: parserClass codeblockMarkup;
		cr.
	
]

{ #category : #building }
MicBuilder >> buildHeader: aString [
	
	stream
		nextPutAll: parserClass headerMarkup ; 
		nextPutAll: aString;
		cr
	
]

{ #category : #building }
MicBuilder >> buildHeader: aString level: aNumber [
	
	stream
		nextPutAll: (parserClass headerMarkup repeat: aNumber); 
		nextPutAll: aString;
		cr
	
]

{ #category : #building }
MicBuilder >> buildText: aString [
	
	stream nextPutAll: aString.
	stream cr.

]

{ #category : #accessing }
MicBuilder >> contents [

	^ stream contents
]

{ #category : #initialization }
MicBuilder >> initialize [
	super initialize.
	stream := self reset.
	"we need to have access to markups. May be we should use SharedPool for the parser
	but it looks overkill. Then we could let different parser to be passed around but 
	we do not see the actual scenarios that support this. So simple first."
	parserClass := MicroDownParser
]

{ #category : #initialization }
MicBuilder >> reset [
	^ String new writeStream
]

{ #category : #initialization }
MicBuilder >> stream: aStream [
	"This way the builder can work with others streams."
	
	stream := aStream
]
