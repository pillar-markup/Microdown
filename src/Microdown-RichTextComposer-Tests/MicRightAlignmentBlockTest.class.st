"
A MicRightAllignmentBlockTest is a test class for testing the behavior of MicRightAllignmentBlock
"
Class {
	#name : 'MicRightAlignmentBlockTest',
	#superclass : 'TestCase',
	#category : 'Microdown-RichTextComposer-Tests-BlockExtensions',
	#package : 'Microdown-RichTextComposer-Tests',
	#tag : 'BlockExtensions'
}

{ #category : 'tests' }
MicRightAlignmentBlockTest >> testRightAlignment [
	| src doc center |
	src := '
<!right
This is righted
!>'.
	doc := Microdown parse: src.
	center := doc children first.
	self assert: center class equals: MicRightAlignmentBlock .
	self assert: center children first text equals: 'This is righted'
]
