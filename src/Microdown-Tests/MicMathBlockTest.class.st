Class {
	#name : 'MicMathBlockTest',
	#superclass : 'MicBlockTest',
	#category : 'Microdown-Tests-Parser',
	#package : 'Microdown-Tests',
	#tag : 'Parser'
}

{ #category : 'tests' }
MicMathBlockTest >> subjectClass [ 
	^ MicMathBlock 
]

{ #category : 'tests' }
MicMathBlockTest >> testAnchor [

	| root math |
	"note that in the following  
	$$%label=eq11
	...
	The % is needed else it does not work on github and the label is part of the equation."
	
	root := self parserClass new parse: '

',MathOpeningBlockMarkup,'%key=cite&anchor=42
V_i = C_0 - C_3 
', MathClosingBlockMarkup.
	math := root children first.
	self assert: math class equals: MicMathBlock.
	self assert: math firstLine equals: 'key=cite&anchor=42'.
	self assert: math anchor equals: '42'
]

{ #category : 'tests - reification' }
MicMathBlockTest >> testMathAnchorIsReified [

	| root math |
	root := Microdown parse: '
$$ % anchor=42&caption=Ze **great** formula
V_i = C_0 - C_3 
$$'.
	math := root children first.
	self assert: math anchor equals: '42'.

]

{ #category : 'tests' }
MicMathBlockTest >> testMathBlockIsMathBlock [

	| root |
	root := self parserClass parse: '

',MathOpeningBlockMarkup,'
V_i = C_0 - C_3
', MathClosingBlockMarkup.
	self assert: root children first class equals: MicMathBlock 
]

{ #category : 'tests' }
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

{ #category : 'tests' }
MicMathBlockTest >> testMathBlockWithBadClosure [

	| root |
	"a MicMathBlock can contain a MicMathInlineBlock delimiter.
	Here we have 
	$$ 
	not terminated by $$
	"
	
	root := self parserClass new parse: '

',MathOpeningBlockMarkup,'key=cite&anchor=42
V_i = C_0 - C_3 
$'.
	self assert: root children first body equals: 'V_i = C_0 - C_3 
$'
]

{ #category : 'tests' }
MicMathBlockTest >> testMathBlockWithParameters [

	| root math |
	root := self parserClass new parse: '

',MathOpeningBlockMarkup,'anchor=42
V_i = C_0 - C_3 
', MathClosingBlockMarkup.
	math := root children first.
	self assert: math class equals: MicMathBlock.
	self assert: math firstLine equals: 'anchor=42'.
	self assert: math anchor equals: '42'
]

{ #category : 'tests' }
MicMathBlockTest >> testMathBlockWithParametersAndLatexComment [

	| root math |
	"note that in the following  
	$$%label=eq11
	...
	The % is needed else it does not work on github and the label is part of the equation."
	
	root := self parserClass new parse: '

',MathOpeningBlockMarkup,'%key=cite&anchor=42
V_i = C_0 - C_3 
', MathClosingBlockMarkup.
	math := root children first.
	self assert: math class equals: MicMathBlock.
	self assert: math firstLine equals: 'key=cite&anchor=42'.
	self assert: (math arguments at: 'key') equals: 'cite'.
	self assert: math anchor equals: '42'
]

{ #category : 'tests' }
MicMathBlockTest >> testMathBlockWithParametersCaption [

	| root math |
	root := self parserClass new parse: '

' , MathOpeningBlockMarkup
		        , 'key=cite&anchor=42&caption=Ze great formula
V_i = C_0 - C_3 
' , MathClosingBlockMarkup.
	math := root children first.
	self assert: math class equals: MicMathBlock.
	self
		assert: math firstLine
		equals: 'key=cite&anchor=42&caption=Ze great formula'.
	self assert: (math arguments at: 'key') equals: 'cite'.
	self assert: math anchor equals: '42'.
	self
		assert: (math arguments at: 'caption') first bodyString
		equals: 'Ze great formula'.
	self assert: math caption equals: 'an Array(Text(Ze great formula))'
]

{ #category : 'tests' }
MicMathBlockTest >> testMathBlockWithParametersCaptionAndFormatting [

	| root math |
	root := self parserClass new parse: '

' , MathOpeningBlockMarkup
		        , 'key=cite&anchor=42&caption=Ze **great** formula
V_i = C_0 - C_3 
' , MathClosingBlockMarkup.
	math := root children first.
	self assert: math class equals: MicMathBlock.
	self
		assert: math firstLine
		equals: 'key=cite&anchor=42&caption=Ze **great** formula'.
	self assert: (math arguments at: 'key') equals: 'cite'.
	self assert: math anchor equals: '42'.
	self
		assert: (math arguments at: 'caption') first blockName asLowercase
		equals: 'text'.
	self
		assert: math caption
		equals:
		'an Array(Text(Ze ) BoldFormat{ Text(great) } Text( formula))'.
	self
		assert: math captionElements second blockName asLowercase
		equals: 'boldformat'
]

{ #category : 'tests' }
MicMathBlockTest >> testMathBlockWithParametersWithBlank [

	| root math |
	root := self parserClass new parse: '

', MathOpeningBlockMarkup,'key=&anchor=42
V_i = C_0 - C_3 
', MathClosingBlockMarkup.
	math := root children first.
	self assert: math class equals: MicMathBlock.
	self assert: math firstLine equals: 'key=&anchor=42'.
	self assert: (math arguments at: 'key') equals: ''.
	self assert: math anchor equals: '42'
]

{ #category : 'tests - reification' }
MicMathBlockTest >> testMathCaptionIsReified [
	"And as such their parent is the math block"
	
	| root math |
	root := Microdown parse: '
$$ % key=cite&anchor=42&caption=Ze **great** formula
V_i = C_0 - C_3 
$$'.
	math := root children first.
	self
		assert: math captionElements second class 
		equals: MicBoldFormatBlock.
	self 
		assert: math captionElements first parent 
		equals: math
]
