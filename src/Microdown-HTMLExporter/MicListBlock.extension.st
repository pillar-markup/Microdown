Extension { #name : #MicListBlock }

{ #category : #'*Microdown-HTMLExporter' }
MicListBlock >> listItemText [
	"I just need the first children which contains the text, currently #text concatenates all children's text"
	
	^ self children first text
]
