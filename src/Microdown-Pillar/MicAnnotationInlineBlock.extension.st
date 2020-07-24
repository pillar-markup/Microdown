Extension { #name : #MicAnnotationInlineBlock }

{ #category : #'*Microdown-Pillar' }
MicAnnotationInlineBlock >> asPillar [

	| argumentsSplitter classPillar |
	argumentsSplitter := MicArgumentsSplitter withString: substring.
	name := argumentsSplitter name.
	arguments := argumentsSplitter arguments.
	"Since an annotation is represented by specific classes depending on the tag, 
	we should dynamically find it."
	classPillar := PRAbstractAnnotation findClassAcceptingTag: name ifNone: [ PRUndefinedAnnotation ].
	^ classPillar new parameters: arguments
]

{ #category : #'*Microdown-Pillar' }
MicAnnotationInlineBlock class >> hasAssociatedPillarClass [
	^ false
]
