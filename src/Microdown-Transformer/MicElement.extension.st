Extension { #name : 'MicElement' }

{ #category : '*Microdown-Transformer' }
MicElement >> inlineInputFiles [
	"Assume all input has been resolved."
	"The file includer is modifying the document on which it is acting."
	
	MicFileIncluder new visit: self
]
