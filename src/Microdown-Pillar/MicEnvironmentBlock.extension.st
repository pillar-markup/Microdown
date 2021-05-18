Extension { #name : #MicEnvironmentBlock }

{ #category : #'*Microdown-Pillar' }
MicEnvironmentBlock >> asPillar [
	
	| env |
	env := PREnvironment new 
			name: self name;
			parameters: arguments; yourself.
	env add: (PRParagraph withAll: (self pillarFrom: self bodyElements)).
	^ env
]

{ #category : #'*Microdown-Pillar' }
MicEnvironmentBlock >> body [

	^ String streamContents: [:s |  self bodyElements do: [ :each | s nextPutAll: each substring ] ]
]

{ #category : #'*Microdown-Pillar' }
MicEnvironmentBlock >> bodyElements [

	^ body
]

{ #category : #'*Microdown-Pillar' }
MicEnvironmentBlock >> closeMe [

	"this is a temporary solution because normally the parser should populate body with MicBlocks.
	Right now just make sure that we have structured text = inline elements. "
	body ifNotNil: [ 
		body := MicInlineSplitter new parse: body ]
]
