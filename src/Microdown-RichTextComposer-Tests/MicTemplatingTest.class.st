Class {
	#name : #MicTemplatingTest,
	#superclass : #TestCase,
	#category : #'Microdown-RichTextComposer-Tests-Composer'
}

{ #category : #tests }
MicTemplatingTest >> testBaselineWithoutBaselineMethodShouldNotBreak [
	
	
	self shouldnt: [MicMockBaselineOf buildMicroDownUsing: MicroDownParser builder withComment: 'balbabl'] raise: Error
]
