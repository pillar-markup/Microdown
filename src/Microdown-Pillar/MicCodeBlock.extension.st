Extension { #name : #MicCodeBlock }

{ #category : #'*Microdown-Pillar' }
MicCodeBlock >> asPillar [
	^ PRCodeblock new
		language: self arguments;
		text: self code;
		yourself
]
