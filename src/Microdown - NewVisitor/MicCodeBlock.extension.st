Extension { #name : #MicCodeBlock }

{ #category : #'*Microdown - NewVisitor' }
MicCodeBlock >> eval: aString [
	arguments := arguments copyWith: 'eval' -> aString
]

{ #category : #'*Microdown - NewVisitor' }
MicCodeBlock >> lineNumber: aString [
	arguments := arguments copyWith: 'lineNumber' -> aString
]
