Class {
	#name : 'MicTemplatingTest',
	#superclass : 'TestCase',
	#category : 'Microdown-RichTextComposer-Tests-Composer',
	#package : 'Microdown-RichTextComposer-Tests',
	#tag : 'Composer'
}

{ #category : 'tests' }
MicTemplatingTest >> testBaselineWithoutBaselineMethodShouldNotBreak [
	
	
	MicMockBaselineOf buildMicroDownUsing: Microdown builder withComment: 'balbabl'
]
