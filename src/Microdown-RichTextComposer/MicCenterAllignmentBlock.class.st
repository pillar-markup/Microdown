"
<!center
I implement a centering environment which can be rendered using RichText.
!>
"
Class {
	#name : #MicCenterAllignmentBlock,
	#superclass : #MicEnvironmentBlock,
	#category : #'Microdown-RichTextComposer-BlockExtensions'
}

{ #category : #accessing }
MicCenterAllignmentBlock class >> tag [
	^ #center
]

{ #category : #visiting }
MicCenterAllignmentBlock >> accept: aVisitor [
	^ aVisitor visitCenter: self
]
