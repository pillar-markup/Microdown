Class {
	#name : #MDTemplatingTest,
	#superclass : #TestCase,
	#category : #'Microdown-RichTextComposer-Tests'
}

{ #category : #tests }
MDTemplatingTest >> testBaselineWithoutBaselineMethodShouldNotBreak [
	
	
	self shouldnt: [MDMockBaselineOf buildMicroDownUsing: MicroDownParser builder withComment: 'balbabl'] raise: Error
]
