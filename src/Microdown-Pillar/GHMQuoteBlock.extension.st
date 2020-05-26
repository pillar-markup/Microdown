Extension { #name : #GHMQuoteBlock }

{ #category : #'*Microdown-Pillar' }
GHMQuoteBlock >> asPillar [
	self flag: #fixMe. 
	"this is not an environment in Pillar but a preformatted"
	^ PREnvironment new
		name: 'textBlock';
		setChildren:  (self splitString: text);
		yourself
]
