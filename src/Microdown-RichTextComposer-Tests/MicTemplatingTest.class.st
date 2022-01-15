Class {
	#name : #MicTemplatingTest,
	#superclass : #TestCase,
	#category : #'Microdown-RichTextComposer-Tests-Composer'
}

{ #category : #tests }
MicTemplatingTest >> testBaselineWithoutBaselineMethodShouldNotBreak [
	
	
	MicMockBaselineOf buildMicroDownUsing: MicroDownParser builder withComment: 'balbabl'
]
