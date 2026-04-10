Extension { #name : 'Microdown' }

{ #category : '*Microdown-HTMLExporter' }
Microdown class >> asHTMLDocument: aStringOrDoc [
	"Facade method to serialize a Microdown document or string to HTML"
	
	^ MicHTMLVisitor serializeToHTMLDoc: aStringOrDoc.
		
	
]

{ #category : '*Microdown-HTMLExporter' }
Microdown class >> asHTMLString: aStringOrDoc [
	"Facade method to render a microdown document or string to HTML"
	
	^ MicHTMLVisitor asHTMLString: aStringOrDoc.
		
	
]

{ #category : '*Microdown-HTMLExporter' }
Microdown class >> asHTMLString: aStringOrDoc configuration: aMicHTMLConfiguration [
	"Facade method to render a microdown document or string to HTML"
	
	^ MicHTMLVisitor asHTMLString: aStringOrDoc configuration: aMicHTMLConfiguration
		
	
]
