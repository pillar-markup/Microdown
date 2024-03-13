Extension { #name : 'Microdown' }

{ #category : '*Microdown-HTMLExporter' }
Microdown classSide >> asHTMLDocument: aStringOrDoc [
	"Facade method to serialize a Microdown document or string to HTML"
	
	^ MicHTMLVisitor serializeToHTMLDoc: aStringOrDoc.
		
	
]

{ #category : '*Microdown-HTMLExporter' }
Microdown classSide >> asHTMLString: aStringOrDoc [
	"Facade method to render a microdown document or string to HTML"
	
	^ MicHTMLVisitor asHTMLString: aStringOrDoc.
		
	
]

{ #category : '*Microdown-HTMLExporter' }
Microdown classSide >> asHTMLString: aStringOrDoc configuration: aMicHTMLConfiguration [
	"Facade method to render a microdown document or string to HTML"
	
	^ MicHTMLVisitor asHTMLString: aStringOrDoc configuration: aMicHTMLConfiguration
		
	
]
