Extension { #name : #MicCodeBlock }

{ #category : #'*Microdown-Pillar' }
MicCodeBlock >> asPillar [
	self flag: #fixme. "missing arguments"
	^ PRCodeblock new
		language: (self arguments at: #language ifAbsent: [ nil ]);
		text: self code;
		yourself
]
