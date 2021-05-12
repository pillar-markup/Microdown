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
MicMathBlockTest >> testMathBlockWithParameters [

	| root |
	"what is the utility of arguments"
	root := (MicroDownParser new parse: '

&key=cite&label=42
V_i = C_0 - C_3 
&
').
	self assert: root children first class equals: MicMathBlock.
	self assert: root children first firstLine equals: 'key=cite&label=42' 
]
