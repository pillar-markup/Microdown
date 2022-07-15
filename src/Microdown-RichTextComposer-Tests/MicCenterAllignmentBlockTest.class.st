"
A MicCenterAllignmentBlockTest is a test class for testing the behavior of MicCenterAllignmentBlock
"
Class {
	#name : #MicCenterAllignmentBlockTest,
	#superclass : #TestCase,
	#category : #'Microdown-RichTextComposer-Tests-BlockExtensions'
}

{ #category : #tests }
MicCenterAllignmentBlockTest >> testCenter [
	| src doc center |
	src := '
<!center
This is centered
!>'.
	doc := Microdown parse: src.
	center := doc children first.
	self assert: center class equals: MicCenterAllignmentBlock.
	self assert: center children first text equals: 'This is centered'
]
