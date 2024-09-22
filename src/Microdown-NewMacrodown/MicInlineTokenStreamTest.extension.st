Extension { #name : 'MicInlineTokenStreamTest' }

{ #category : '*Microdown-NewMacrodown' }
MicInlineTokenStreamTest >> testLineBreak [ 

	| src tokens |
	self skip.
	src := 'aa  bb'. 
	tokens := (MicInlineTokenStream on: src) contents.
	self assert: tokens size equals: 3.
	self assert: tokens second string equals: '  '
]

{ #category : '*Microdown-NewMacrodown' }
MicInlineTokenStreamTest >> testLineBreakBackSlashed [

	| src tokens |
	self skip.
	src := 'aa\  bb'. 
	tokens := (MicInlineTokenStream on: src) contents.
	self assert: tokens size equals: 1.
	"to me it should not lose the / but we will see this later."
	self assert: tokens first string equals: 'aa  bb'
]
