Extension { #name : 'Microdown' }

{ #category : '*Microdown-RichTextComposer' }
Microdown class >> asRichText: aStringOrDoc [
	"Facade method to render a microdown document or string to Text"
	^ MicRichTextComposer asRichText: aStringOrDoc.
		
	
]
