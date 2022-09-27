Extension { #name : #MicAbstractBlock }

{ #category : #'*Microdown-DocumentBrowser' }
MicAbstractBlock >> canSave [
	"Called by the document browser. Polymorphic with MicResourceReferences"
	^ false
]

{ #category : #'*Microdown-DocumentBrowser' }
MicAbstractBlock >> contents [
	"polymorphic with MicResourceReference - returns the source code of me - here generated"
	^ 'You cannot edit subsections of a document.
Select the whole document for editing'
]

{ #category : #'*Microdown-DocumentBrowser' }
MicAbstractBlock >> isHeader [
	^ false
]
