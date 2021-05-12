Class {
	#name : #MicMathBlockTest,
	#superclass : #MicBlockTest,
	#category : #'Microdown-Tests'
}

{ #category : #tests }
MicMathBlockTest >> testMathBlockIsMathBlock [

	| root |
	root := (MicroDownParser new parse: '

&
V_i = C_0 - C_3
&


').
	self assert: root children first class equals: MicMathBlock 
]

{ #category : #tests }
MicMathBlockTest >> testMathBlockWithBadClosure [

	| root |
	self skip.
	"a MicMathBlock can use the MicMathInlineBlock delimiter"
	root := (MicroDownParser new parse: '

&key=cite&label=42
V_i = C_0 - C_3 
$
').
	self assert: root children first printString equals: '

$key=cite&label=42
V_i = C_0 - C_3 
$
'.
]

{ #category : #tests }
MicMathBlockTest >> testMathBlockWithParameters [

	| root math |
	root := (MicroDownParser new parse: '

&key=cite&label=42
V_i = C_0 - C_3 
&
').
	math := root children first.
	self assert: math class equals: MicMathBlock.
	self assert: math firstLine equals: 'key=cite&label=42'.
	self assert: (math arguments at: 'key') equals: 'cite'.
	self assert: (math arguments at: 'label') equals: '42'
]
