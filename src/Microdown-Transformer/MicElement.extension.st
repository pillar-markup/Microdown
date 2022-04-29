Extension { #name : #MicElement }

{ #category : #'*Microdown-Transformer' }
MicElement >> inlineInputFiles [
	"Assume all input has been resolved."
	MicFileIncluder new visit: self
]
