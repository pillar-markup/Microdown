"
may be rename the class later
"
Class {
	#name : #MicInputFileAnnotationBlock,
	#superclass : #MicAnnotationBlock,
	#category : #'Microdown-Extensions'
}

{ #category : #accessing }
MicInputFileAnnotationBlock class >> tag [ 
	^ #inputfile
]

{ #category : #visiting }
MicInputFileAnnotationBlock >> accept: aVisitor [
	aVisitor visitInputFileAnnotation: self
]

{ #category : #accessing }
MicInputFileAnnotationBlock >> fileWithConfiguration: aConfiguration [
	"I search my file."

	^ aConfiguration baseDirectory resolve: self path
]

{ #category : #accessing }
MicInputFileAnnotationBlock >> path [

	^ self arguments at: 'path'
]
