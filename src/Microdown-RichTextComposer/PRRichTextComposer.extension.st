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

	| builder |
	builder := MicroDownParser builder.
	aClass buildMicroDownUsing: builder withComment: aString.
	self flag: #fixMe.
	"I do not like the asText: the interaction between parser, richtext composer should be 
	more obvious"
	^ MicroDownParser asText: builder contents
]

{ #category : #'*Microdown-RichTextComposer' }
PRRichTextComposer class >> renderComment: aString ofPackage: aPackage [
	
	| builder |
	builder := MicroDownParser builder.
	aPackage buildMicroDownUsing: builder withComment: aString.
	self flag: #fixMe.
	"I do not like the asText: the interaction between parser, richtext composer should be 
	more obvious"
	^ MicroDownParser asText: builder contents
]
