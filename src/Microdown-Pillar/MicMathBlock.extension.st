Extension { #name : #MicMathBlock }

{ #category : #'*Microdown-Pillar' }
MicMathBlock >> asPillar [ 
	| captionElements |
	captionElements := arguments at: 'caption' ifAbsent: [ nil ]. 
	captionElements isNotNil 
		ifTrue: [ arguments at: 'caption' put: (self pillarFrom: captionElements) ].
	^ PRMathEnvironment new 
	 	parameters: arguments;   
		add: (PRText content: self body);
		yourself
	
]
