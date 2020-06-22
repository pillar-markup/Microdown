Extension { #name : #MicAnnotationInlineBlock }

{ #category : #'*Microdown-Pillar' }
MicAnnotationInlineBlock >> asPillar [
	| lineStream resultArray classPillar |
	
	lineStream := substring readStream.
	resultArray := MicArgumentsSplitter findNameAndArguments: lineStream.
	name := resultArray first.
	arguments := resultArray second.
	
	classPillar := PRAbstractAnnotation findClassAcceptingTag: name ifNone: [ PRUndefinedAnnotation ].
	^ classPillar new parameters: arguments
]
