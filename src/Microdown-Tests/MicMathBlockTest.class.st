Class {
	#name : #MicMathBlockTest,
	#superclass : #MicBlockTest,
	#category : #'Microdown-Tests-Parser'
}

{ #category : #tests }
MicMathBlockTest >> subjectClass [ 
	^ MicMathBlock 
]

{ #category : #tests }
MicMathBlockTest >> testMathBlockIsMathBlock [

	| root |
	root := self parserClass parse: '

',MathOpeningBlockMarkup,'
V_i = C_0 - C_3
', MathClosingBlockMarkup.
	self assert: root children first class equals: MicMathBlock 
]

{ #category : #tests }
MicMathBlockTest >> testMathBlockWithBackslashCommands [
	"check that backslash are not expanded for math blocks"
	| root math |
	root := self parserClass parse: '

',MathOpeningBlockMarkup,'
f(a) = \frac{1}{2\pi i} \oint_{\gamma} \frac{f(z)}{z - a} dz
', MathClosingBlockMarkup.
	math := root children first.
	self assert: math class equals: MicMathBlock.
	self assert: math body equals: 'f(a) = \frac{1}{2\pi i} \oint_{\gamma} \frac{f(z)}{z - a} dz'.
]

{ #category : #tests }
MicMathBlockTest >> testMathBlockWithBadClosure [

	| root |
	"a MicMathBlock can use the MicMathInlineBlock delimiter"
	root := self parserClass new parse: '

',MathOpeningBlockMarkup,'key=cite&label=42
V_i = C_0 - C_3 
$'.
	self assert: root children first body equals: 'V_i = C_0 - C_3 
$'
]

{ #category : #tests }
MicMathBlockTest >> testMathBlockWithParameters [

	| root math |
	root := self parserClass new parse: '

',MathOpeningBlockMarkup,'key=cite&label=42
V_i = C_0 - C_3 
', MathClosingBlockMarkup.
	math := root children first.
	self assert: math class equals: MicMathBlock.
	self assert: math firstLine equals: 'key=cite&label=42'.
	self assert: (math arguments at: 'key') equals: 'cite'.
	self assert: (math arguments at: 'label') equals: '42'
]

{ #category : #tests }
MicMathBlockTest >> testMathBlockWithParametersAndLatexComment [

	| root math |
	root := self parserClass new parse: '

',MathOpeningBlockMarkup,'%key=cite&label=42
V_i = C_0 - C_3 
', MathClosingBlockMarkup.
	math := root children first.
	self assert: math class equals: MicMathBlock.
	self assert: math firstLine equals: 'key=cite&label=42'.
	self assert: (math arguments at: 'key') equals: 'cite'.
	self assert: (math arguments at: 'label') equals: '42'
]

{ #category : #tests }
MicMathBlockTest >> testMathBlockWithParametersCaption [

	| root math |
	root := self parserClass new parse: '

', MathOpeningBlockMarkup, 'key=cite&label=42&caption=Ze great formula
V_i = C_0 - C_3 
', MathClosingBlockMarkup.
	math := root children first.
	self assert: math class equals: MicMathBlock.
	self
		assert: math firstLine
		equals: 'key=cite&label=42&caption=Ze great formula'.
	self assert: (math arguments at: 'key') equals: 'cite'.
	self assert: (math arguments at: 'label') equals: '42'.
	self
		assert: (math arguments at: 'caption') first substring
		equals: 'Ze great formula'.
	self assert: math caption equals: 'Ze great formula'
]

{ #category : #tests }
MicMathBlockTest >> testMathBlockWithParametersCaptionAndFormatting [

	| root math |
	root := self parserClass new parse: '

' , MathOpeningBlockMarkup
		        , 'key=cite&label=42&caption=Ze **great** formula
V_i = C_0 - C_3 
' , MathClosingBlockMarkup.
	math := root children first.
	self assert: math class equals: MicMathBlock.
	self
		assert: math firstLine
		equals: 'key=cite&label=42&caption=Ze **great** formula'.
	self assert: (math arguments at: 'key') equals: 'cite'.
	self assert: (math arguments at: 'label') equals: '42'.
	self
		assert: (math arguments at: 'caption') first blockName asLowercase
		equals: 'text'.
	self
		assert: math testCaptionString asString
		equals:
		'an Array(Text(Ze ) BoldFormat{ Text(great) } Text( formula))'.
	self
		assert: math captionElements second blockName asLowercase
		equals: 'boldformat'
]

{ #category : #tests }
MicMathBlockTest >> testMathBlockWithParametersWithBlank [

	| root math |
	root := self parserClass new parse: '

', MathOpeningBlockMarkup,'key=&label=42
V_i = C_0 - C_3 
', MathClosingBlockMarkup.
	math := root children first.
	self assert: math class equals: MicMathBlock.
	self assert: math firstLine equals: 'key=&label=42'.
	self assert: (math arguments at: 'key') equals: ''.
	self assert: (math arguments at: 'label') equals: '42'
]
