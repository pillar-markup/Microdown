Class {
	#name : 'MicTemplatingTest',
	#superclass : 'TestCase',
	#category : 'Microdown-RichTextComposer-Tests-Composer',
	#package : 'Microdown-RichTextComposer-Tests',
	#tag : 'Composer'
}

{ #category : 'tests' }
MicTemplatingTest >> testBaselineWithoutBaselineMethodShouldNotBreak [
	"A baseline without baseline: method gets a comment with its name and description but no code block."

	| builder contents |
	builder := Microdown builder.
	MicMockBaselineOf buildMicroDownUsing: builder withComment: 'balbabl'.
	contents := builder contents.
	self assert: (contents includesSubstring: '# MicMockBaselineOf').
	self assert: (contents includesSubstring: 'balbabl').
	self deny: (contents includesSubstring: '```')
]
