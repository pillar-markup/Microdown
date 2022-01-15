Class {
	#name : #MicTemplatingTest,
	#superclass : #TestCase,
	#category : #'Microdown-RichTextComposer-Tests-Composer'
}

{ #category : #tests }
MicTemplatingTest >> testBaselineWithoutBaselineMethodShouldNotBreak [
	
	
	MicMockBaselineOf buildMicroDownUsing: Microdown builder withComment: 'balbabl'
]
