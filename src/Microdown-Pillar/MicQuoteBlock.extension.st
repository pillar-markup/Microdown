Extension { #name : #MicQuoteBlock }

{ #category : #'*Microdown-Pillar' }
MicQuoteBlock >> asPillar [
	self flag: #fixMe. 
	"this is not an environment in Pillar but a preformatted"
	^ PREnvironment new
		name: 'textBlock';
		setChildren:  (self splitString: text);
		yourself
]
