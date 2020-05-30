Extension { #name : #PRRichTextComposer }

{ #category : #'*Microdown-RichTextComposer' }
PRRichTextComposer class >> renderComment: aSource [
	"render aSource if it looks like it contains microdown. Otherwise just return aSource"
	self halt.
	^ (aSource matchesRegex: '.*(`|!!|\*\*|^#|```|^>).*') 
			ifTrue: [ (self class environment at: #MicroDownParser ifAbsent: [ ^ aSource ]) asText: aSource ]
			ifFalse: [ aSource ] 
]

{ #category : #'*Microdown-RichTextComposer' }
PRRichTextComposer class >> renderComment: aString ofClass: aClass [ 

		| parserClass |
	parserClass := (self class environment at: #MicroDownParser ifAbsent: [ ^ aString ]).
	^ parserClass 
			asText: (aClass asMicrodown: parserClass), aString
]

{ #category : #'*Microdown-RichTextComposer' }
PRRichTextComposer class >> renderComment: aString ofPackage: aPackage [

	| parserClass |
	parserClass := (self class environment at: #MicroDownParser ifAbsent: [ ^ aString ]).
	^ parserClass 
			asText: (aPackage asMicrodown: parserClass), aString
]
