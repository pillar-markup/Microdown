"
<!right
I implement a right allignment block for RichText
!>
"
Class {
	#name : #MicRightAlignmentBlock,
	#superclass : #MicEnvironmentBlock,
	#category : #'Microdown-RichTextComposer-BlockExtensions'
}

{ #category : #accessing }
MicRightAlignmentBlock class >> tag [
	^ #right
]

{ #category : #visiting }
MicRightAlignmentBlock >> accept: aVisitor [
	^ aVisitor visitRightAlignment: self
]
