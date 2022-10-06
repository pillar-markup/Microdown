"
<!center
I implement a centering environment which can be rendered using RichText.
!>
"
Class {
	#name : #MicCenterAlignmentBlock,
	#superclass : #MicEnvironmentBlock,
	#category : #'Microdown-RichTextComposer-BlockExtensions'
}

{ #category : #accessing }
MicCenterAlignmentBlock class >> tag [
	^ #center
]

{ #category : #visiting }
MicCenterAlignmentBlock >> accept: aVisitor [
	^ aVisitor visitCenter: self
]
