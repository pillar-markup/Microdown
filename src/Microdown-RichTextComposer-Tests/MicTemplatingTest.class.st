Class {
	#name : #MicTemplatingTest,
	#superclass : #TestCase,
	#category : #'Microdown-RichTextComposer-Tests'
}

{ #category : #tests }
MicTemplatingTest >> testBaselineWithoutBaselineMethodShouldNotBreak [
	
	
	self shouldnt: [MicMockBaselineOf buildMicroDownUsing: MicroDownParser builder withComment: 'balbabl'] raise: Error
]
