Extension { #name : #PRRichTextComposer }

{ #category : #'*Microdown-RichTextComposer' }
PRRichTextComposer class >> renderComment: aString ofClass: aClass [ 

	| builder |
	builder := MicroDownParser builder.
	aClass buildMicroDownUsing: builder withComment: aString.
	self flag: #fixMe.
	"I do not like the asText: the interaction between parser, richtext composer should be 
	more obvious"
	^ [ MicroDownParser asText: builder contents ] on: MicParsingError do: [ builder contents  ]
]

{ #category : #'*Microdown-RichTextComposer' }
PRRichTextComposer class >> renderComment: aString ofPackage: aPackage [
	
	| builder |
	builder := MicroDownParser  builder.
	aPackage buildMicroDownUsing: builder withComment: aString.
	self flag: #fixMe.
	"I do not like the asText: the interaction between parser, richtext composer should be 
	more obvious"
		^ [ MicroDownParser asText: builder contents ] on: MicParsingError do: [ builder contents  ]
]
