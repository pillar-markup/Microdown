Extension { #name : #MicAbstractBlock }

{ #category : #'*Microdown-DocumentBrowser' }
MicAbstractBlock >> canSave [
	"Called by the document browser. Polymorphic with MicResourceReferences"
	^ false
]

{ #category : #'*Microdown-DocumentBrowser' }
MicAbstractBlock >> contents [
	"polymorphic with MicResourceReference - returns the source code of me - here generated"
	^ MicTextualMicrodownExporter new visit: self
]

{ #category : #'*Microdown-DocumentBrowser' }
MicAbstractBlock >> isHeader [
	^ false
]
