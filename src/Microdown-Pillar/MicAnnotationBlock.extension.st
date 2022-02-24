Extension { #name : #MicAnnotationBlock }

{ #category : #'*Microdown-Pillar' }
MicAnnotationBlock >> associatedPillarClass [ 

	^  PRAbstractAnnotation findClassAcceptingTag: self name ifNone: [ PRUndefinedAnnotation ]
	
]
