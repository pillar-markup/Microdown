"
<!right
I implement a right allignment block for RichText
!>
"
Class {
	#name : #MicRightAllignmentBlock,
	#superclass : #MicEnvironmentBlock,
	#category : #'Microdown-RichTextComposer-BlockExtensions'
}

{ #category : #accessing }
MicRightAllignmentBlock class >> tag [
	^ #right
]

{ #category : #visiting }
MicRightAllignmentBlock >> accept: aVisitor [
	^ aVisitor visitRightAllignment: self
]
