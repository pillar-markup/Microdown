Extension { #name : #MicAnnotationInlineBlock }

{ #category : #'*Microdown-Pillar' }
MicAnnotationInlineBlock >> asPillar [
	| lineStream resultArray micBlock |
	self flag: #toFix. 
	"I would prefer to have a separate objects and do not over reuse an EnvironmentBlock for that."
	micBlock := MicEnvironmentBlock new.
	lineStream := substring readStream.
	resultArray := micBlock findNameAndArguments: lineStream.
	name := resultArray first.
	arguments := resultArray second.
	^ micBlock asPillarWithTag: name withParameters: arguments 
]
