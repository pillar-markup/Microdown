Extension { #name : 'MicRichTextComposerTest' }

{ #category : '*Microdown-MathFlaky-Tests' }
MicRichTextComposerTest >> testClassExamplesNotBroken [
	"Each sample instance of the class side renders a non empty text."

	| examples |
	examples := (Pragma allNamed: #sampleInstance in: MicRichTextComposer class) collect: [ :pragma | pragma method selector ].
	self denyEmpty: examples.
	examples do: [ :selector |
			| text |
			text := MicRichTextComposer perform: selector.
			self assert: (text isKindOf: Text).
			self denyEmpty: text asString ]
]

{ #category : '*Microdown-MathFlaky-Tests' }
MicRichTextComposerTest >> testLatexMathStyle [

	| source1 source2 richText1 richText2 |
	"this checks if latex is working by making two formulas, of which the second should be taller"
	source1 :=  'foo$a+b$bar'.
	source2 :=  'foo$\frac{A}{B}$bar'.
	richText1 := self richTextForString: source1.
	richText2 := self richTextForString: source2.
	self assert: richText1 asMorph height < richText2 asMorph height
]

{ #category : '*Microdown-MathFlaky-Tests' }
MicRichTextComposerTest >> testMathEnvironment [
	| source1 source2 richText1 richText2 |
	"this checks if latex is working by making two formulas, of which the second should be taller"
	source1 :=  'foo
$$
a+b
$$
bar'.
	source2 :=  'foo
$$
\frac{A}{B}
$$
bar'.
	richText1 := self richTextForString: source1.
	richText2 := self richTextForString: source2.
	self assert: richText1 asMorph height < richText2 asMorph height
]
