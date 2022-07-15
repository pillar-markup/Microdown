"
A MicRightAllignmentBlockTest is a test class for testing the behavior of MicRightAllignmentBlock
"
Class {
	#name : #MicRightAllignmentBlockTest,
	#superclass : #TestCase,
	#category : #'Microdown-RichTextComposer-Tests-BlockExtensions'
}

{ #category : #tests }
MicRightAllignmentBlockTest >> testRightAllignment [
	| src doc center |
	src := '
<!right
This is righted
!>'.
	doc := Microdown parse: src.
	center := doc children first.
	self assert: center class equals: MicRightAllignmentBlock .
	self assert: center children first text equals: 'This is righted'
]
