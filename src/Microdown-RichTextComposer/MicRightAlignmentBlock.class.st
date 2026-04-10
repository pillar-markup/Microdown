"
<!right
I implement a right allignment block for RichText
!>
"
Class {
	#name : 'MicRightAlignmentBlock',
	#superclass : 'MicEnvironmentBlock',
	#category : 'Microdown-RichTextComposer-BlockExtensions',
	#package : 'Microdown-RichTextComposer',
	#tag : 'BlockExtensions'
}

{ #category : 'accessing' }
MicRightAlignmentBlock class >> tag [
	^ #right
]

{ #category : 'visiting' }
MicRightAlignmentBlock >> accept: aVisitor [
	^ aVisitor visitRightAlignment: self
]
