Extension { #name : #MicAnnotationBlock }

{ #category : #'*Microdown-Pillar' }
MicAnnotationBlock >> associatedPillarClass [ 

	^  PRAbstractAnnotation findClassAcceptingTag: name ifNone: [ PRUndefinedAnnotation ]
	
]
