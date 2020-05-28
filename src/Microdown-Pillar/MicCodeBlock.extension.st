Extension { #name : #MicCodeBlock }

{ #category : #'*Microdown-Pillar' }
MicCodeBlock >> asPillar [
	^ PRCodeblock new
		language: self firstTag;
		text: self code;
		yourself
]
