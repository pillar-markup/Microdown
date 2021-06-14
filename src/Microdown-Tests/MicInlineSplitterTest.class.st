"
These tests should be merged in MicrodDownInlineParserTest
"
Class {
	#name : #MicInlineSplitterTest,
	#superclass : #TestCase,
	#category : #'Microdown-Tests-Parser'
}

{ #category : #access }
MicInlineSplitterTest >> splitter [
	^ MicInlineParser new
]

{ #category : #'tests - anchors' }
MicInlineSplitterTest >> testAnchorReference [

	| res |
	res := self splitter parse: 'abc*@anchorA@*def'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: { 'abc'. '[anchorA](anchorReference)'.
		'def' }.
	self assert: (res second isKindOf: MicAnchorReferenceBlock)
]

{ #category : #'tests - anchors' }
MicInlineSplitterTest >> testAnchorReferenceUnevaluated [

	"When isEvaluated class method returns false, like anchor reference's case, inline inside shoudn't be evaluated"

	| res |
	res := self splitter parse: 'abc*@def**not bold**ghi@*xyz'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: { 'abc'. '[def**not bold**ghi](anchorReference)'.
			'xyz' }
]

{ #category : #'tests - annotation' }
MicInlineSplitterTest >> testAnnotationWithParameters [

	| res |
	res := self splitter parse:
		       'abc<?an annotation|key=cite&label=42?>def'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: { 'abc'. '<?an annotation|key=cite&label=42?>'.
			'def' }.
	self assert: (res second isKindOf: MicAnnotationBlock).
	self assert: (res second arguments at: 'key') equals: 'cite'.
	self assert: (res second arguments at: 'label') equals: '42'
]

{ #category : #'tests - annotation' }
MicInlineSplitterTest >> testAnnotationWithParametersWithBlank [

	| res |
	res := self splitter parse: 'abc<?an annotation|key=&label=42?>def'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: { 'abc'. '<?an annotation|key=&label=42?>'.
			'def' }.
	self assert: (res second isKindOf: MicAnnotationBlock).
	self assert: (res second arguments at: 'key') equals: ''.
	self assert: (res second arguments at: 'label') equals: '42'
]

{ #category : #'tests - formats' }
MicInlineSplitterTest >> testBold [

	| res |
	res := self splitter parse: 'abc**bold**def'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: { 'abc'. '[bold](bold)'. 'def' }.
	self assert: res second kind equals: #bold.

	res := self splitter parse: 'abc** b old **def'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: { 'abc'. '[ b old ](bold)'. 'def' }.
	self assert: res second kind equals: #bold
]

{ #category : #'tests - escape' }
MicInlineSplitterTest >> testEscapeCharacter [
	"Test the escape \ in simple case (here, bold one)"

	| res |
	res := self splitter parse: 'abc\**test**last'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: { 'abc**test**last' }
]

{ #category : #'tests - escape' }
MicInlineSplitterTest >> testEscapeCharacterAtBeginning [
	"Test the escape \ in simple case (here, bold one)"

	| res |
	res := self splitter parse: '\**test**'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: { '**test**' }
]

{ #category : #'tests - escape' }
MicInlineSplitterTest >> testEscapeCharacterInLinkName [
	"Test the escape \ in link description"

	| res |
	res := self splitter parse: 'abc[\**test**](myURL)last'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: { 'abc'. '[**test**](/myURL)'. 'last' }
]

{ #category : #'tests - escape' }
MicInlineSplitterTest >> testEscapeCharacterInNestedCase [
	"Test the escape \ in case of nested formats"

	| res |
	res := self splitter parse: 'abc_\**not bold** italic_last'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: {'abc' . '[**not bold** italic](italic)' . 'last'}.
]

{ #category : #'tests - escape' }
MicInlineSplitterTest >> testEscapeCharacterInNestedLinkName [
	"Test the escape \ in case of nested linknames"

	| res |
	res := self splitter parse: 'abc[\[nested\]](myURL)last'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: { 'abc'. '[[nested]](/myURL)'. 'last' }
]

{ #category : #'tests to make green again' }
MicInlineSplitterTest >> testEscapeCharacterWithNoCharacterAfter [
	| res |
	self skip.
	res := self splitter start: '**bold**\'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: {'**bold**\'}.
]

{ #category : #'tests - formats' }
MicInlineSplitterTest >> testEscapeMonospace [
	"When isEvaluated class method returns false, like monospace's case, inline inside shoudn't be evaluated"

	| res |
	res := self splitter parse: 'abc`\`monospace\``efg'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: { 'abc'. '[`monospace`](monospace)'.
		'efg' }.
	self assert: res second class equals: MicMonospaceFormatBlock
]

{ #category : #'tests - various' }
MicInlineSplitterTest >> testExclamationMark [

	"Test that 'bla!bla' is ok, and not a failed image, same goes for '![goo]no parenthesis'"

	| res |
	res := self splitter parse: 'bla!bla'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: { 'bla!bla' }.
	res := self splitter parse: '![goo]no parenthesis'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: { '![goo]no parenthesis' }
]

{ #category : #'tests - figure' }
MicInlineSplitterTest >> testFigure [
	"Test the image annotation ![AltText](url)"

	| res |
	res := self splitter parse:
		       'abc![AltText](my_directory/image.png)last'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: { 'abc'. '![AltText](/my_directory/image.png)'.
			'last' }.
	self assert: (res second isKindOf: MicFigureBlock).
	self assert: res second url class equals: ZnUrl.
	self assert: res second url segments first equals: 'my_directory'.
	self assert: res second url segments second equals: 'image.png'
]

{ #category : #'tests - figure' }
MicInlineSplitterTest >> testFigureWithBracketInsteadOfParentheses [
	"Test the image annotation ![AltText](url)"

	| res |
	res := self splitter parse:
		       'abc![AltText][my_directory/image.png]last'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: { 'abc![AltText][my_directory/image.png]last' }
]

{ #category : #'tests - figure' }
MicInlineSplitterTest >> testFigureWithParameters [

	"Test the image annotation ![AltText](url)"

	| res |
	res := self splitter parse:
		       'abc![AltText](my_directory/image.png?label=42&width=90)last'.
	self
		assert: (res collect: [ :x | x printString ])
		equals:
			{ 'abc'. '![AltText](/my_directory/image.png?label=42&width=90)'.
			'last' }.
	self assert: (res second isKindOf: MicFigureBlock).
	self assert: res second url class equals: ZnUrl.
	self assert: res second url segments first equals: 'my_directory'.
	self assert: res second url segments second equals: 'image.png'.
	self assert: (res second arguments at: 'label') equals: '42'.
	self assert: (res second arguments at: 'width') equals: '90'
]

{ #category : #'tests - figure' }
MicInlineSplitterTest >> testFigureWithParametersWithBlank [

	"Test the image annotation ![AltText](url)"

	| res |
	res := self splitter parse:
		       'abc![AltText](my_directory/image.png?label=&width=90)last'.
	self
		assert: (res collect: [ :x | x printString ])
		equals:
			{ 'abc'. '![AltText](/my_directory/image.png?label=&width=90)'.
			'last' }.
	self assert: (res second isKindOf: MicFigureBlock).
	self assert: res second url class equals: ZnUrl.
	self assert: res second url segments first equals: 'my_directory'.
	self assert: res second url segments second equals: 'image.png'.
	self assert: (res second arguments at: 'label') equals: ''.
	self assert: (res second arguments at: 'width') equals: '90'
]

{ #category : #'tests - figure' }
MicInlineSplitterTest >> testFigureWithParenthesesInsteadOfBracket [
	"Test the image annotation ![AltText](url)"

	| res |
	res := self splitter parse:
		       'abc!(AltText)(my_directory/image.png)last'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: { 'abc!(AltText)(my_directory/image.png)last' }
]

{ #category : #'tests - formats' }
MicInlineSplitterTest >> testItalic [

	| res |
	res := self splitter parse: 'abc_italics_def'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: { 'abc'. '[italics](italic)'. 'def' }.

	res := self splitter parse: 'abc_ ita lics _def'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: { 'abc'. '[ ita lics ](italic)'. 'def' }
]

{ #category : #'tests - formats' }
MicInlineSplitterTest >> testItalicNestedInBold [

	| res |
	res := self splitter parse: 'abc**bold_italic_bold**xyz'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: { 'abc'. '[bold [italic](italic) bold](bold)'.
			'xyz' }
]

{ #category : #'tests - formats' }
MicInlineSplitterTest >> testItalicNestedInBoldWithSpace [

	| res |
	res := self splitter parse: 'abc**x_y_z**cba'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: { 'abc'. '[x [y](italic) z](bold)'. 'cba' }
]

{ #category : #'tests - math' }
MicInlineSplitterTest >> testMath [

	| res |
	res := self splitter parse: 'abc$	V_i = C_0 - C_3	$def'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: { 'abc'. '[	V_i = C_0 - C_3	](math)'.
		'def' }.
	self assert: (res second isKindOf: MicMathInlineBlock)
]

{ #category : #'tests - math' }
MicInlineSplitterTest >> testMath2 [

	| res |
	res := self splitter parse: 'abc$math env$def'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: { 'abc'. '[math env](math)'. 'def' }
]

{ #category : #'tests - math' }
MicInlineSplitterTest >> testMathshouldBeUnevaluated [

	"When isEvaluated class method returns false, like math's case, inline inside shoudn't be evaluated"

	| res |
	res := self splitter parse: 'abc$def**not bold**ghi$xyz'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: { 'abc'. '[def**not bold**ghi](math)'.
		'xyz' }
]

{ #category : #'tests - formats' }
MicInlineSplitterTest >> testMonospace [

	| res |
	res := self splitter parse: 'abc`block`def'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: { 'abc'. '[block](monospace)'. 'def' }
]

{ #category : #'tests - formats' }
MicInlineSplitterTest >> testMonospaceUnevaluated [
	"When isEvaluated class method returns false, like monospace's case, inline inside shoudn't be evaluated"

	| res |
	res := self splitter parse: 'abc`def**not bold**ghi`xyz'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: { 'abc'. '[def**not bold**ghi](monospace)'.
			'xyz' }.
	self assert: res second class equals: MicMonospaceFormatBlock
]

{ #category : #'tests - formats' }
MicInlineSplitterTest >> testMultipleSequenceFormats [

	"Test with multiple annotations"

	| res |
	res := self splitter parse: 'abc**abc**xyz`xyz`last'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: { 'abc'. '[abc](bold)'. 'xyz'. '[xyz](monospace)'.
		'last' }
]

{ #category : #'tests - various' }
MicInlineSplitterTest >> testNoAnnotation [

	| res |
	res := self splitter parse: 'abc'.
	self assert: res first printString equals: 'abc'.

	res := self splitter parse: 'abc def gh'.
	self assert: res first printString equals: 'abc def gh'
]

{ #category : #'tests - various' }
MicInlineSplitterTest >> testParseEmptyText [

	| res |
	res := self splitter parse: ''.
	self assert: res isEmpty
]

{ #category : #'tests - raw' }
MicInlineSplitterTest >> testRaw [

	| res |
	res := self splitter parse: 'abc{{someRaw}}def'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: { 'abc'. '[someRaw](raw)'. 'def' }
]

{ #category : #'tests - raw' }
MicInlineSplitterTest >> testRawUnevaluated [

	"When isEvaluated class method returns false, like raw's case, inline inside shoudn't be evaluated"

	| res |
	res := self splitter parse: 'abc{{def**not bold**ghi}}xyz'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: { 'abc'. '[def**not bold**ghi](raw)'.
		'xyz' }
]

{ #category : #'tests - formats' }
MicInlineSplitterTest >> testSequenceOfFormats [
	"Test with multiple annotations"

	| res |
	res := self splitter parse: 'abc**abc**xyz`xyz`last'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: { 'abc'. '[abc](bold)'. 'xyz'. '[xyz](monospace)'.
		'last' }
]

{ #category : #'tests - annotation' }
MicInlineSplitterTest >> testSplitAnnotation [

	| res |
	res := self splitter parse:
		       'abc<?type:value|key1=val1&key2=val2?>def'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: { 'abc'. '<?type:value|key1=val1&key2=val2?>'.
			'def' }
]

{ #category : #'tests - annotation' }
MicInlineSplitterTest >> testSplitBlockAnnotation [

	| res |
	res := self splitter parse: 'abc<?an annotation?>def'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: { 'abc'. '<?an annotation?>'. 'def' }.
	self assert: (res second isKindOf: MicAnnotationBlock)
]

{ #category : #'tests - link' }
MicInlineSplitterTest >> testSplitBlockLink [
	"Test the link annotation [LinkText](url)"

	| res |
	res := self splitter parse: 'abc[LinkText](myURL)last'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: { 'abc'. '[LinkText](/myURL)'. 'last' }.
	self assert: res second url class equals: ZnUrl.
	self assert: res second url segments first equals: 'myURL'
]

{ #category : #'tests - link' }
MicInlineSplitterTest >> testSplitBlockLinkIncomplete [

	| res |
	res := self splitter parse: 'abc[LinkText]last'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: { 'abc[LinkText]last' }.
	self assert: res first class equals: MicTextBlock
]

{ #category : #'tests - link' }
MicInlineSplitterTest >> testSplitBlockLinkInlineImage [

	| res |
	res := self splitter parse: 'abc[![alttext](imageurl)](url)last'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: { 'abc'. '[![alttext](/imageurl)](/url)'.
			'last' }.
	self
		assert: res second children first url segments first
		equals: 'imageurl'
]

{ #category : #'tests - link' }
MicInlineSplitterTest >> testSplitBlockLinkWithBracketInsteadOfParentheses [

	"Test the link annotation [LinkText](url)"

	| res |
	res := self splitter parse: 'abc[LinkText][myURL]last'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: { 'abc[LinkText][myURL]last' }
]

{ #category : #'tests - link' }
MicInlineSplitterTest >> testSplitBlockLinkWithParenthesesInsteadOfBracket [

	"Test the link annotation [LinkText](url)"

	| res |
	res := self splitter parse: 'abc(LinkText)(myURL)last'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: { 'abc(LinkText)(myURL)last' }
]

{ #category : #'tests - formats' }
MicInlineSplitterTest >> testStrike [

	| res |
	res := self splitter parse: 'abc~strike~def'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: { 'abc'. '[strike](strike)'. 'def' }.
	self assert: res second class equals: MicStrikeFormatBlock
]

{ #category : #'tests to make green again' }
MicInlineSplitterTest >> testTwoConsecutiveEscapeCharacter [
	"we should have just one escape"
	| res |
	self skip.
	res := self splitter start: '\\'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: {'\'}.
]

{ #category : #'tests - annotation' }
MicInlineSplitterTest >> testUnclosedAnnotation [

	| res |
	res := self splitter parse: 'abc<?an annotation>def'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: { 'abc<?an annotation>def' }
]

{ #category : #'tests - formats' }
MicInlineSplitterTest >> testUnclosedBold [

	| res |
	res := self splitter parse: 'abc**xyz'.
	self assert: res first printString equals: 'abc**xyz'
]

{ #category : #'tests - figure' }
MicInlineSplitterTest >> testUnclosedFigure [
	"Test the image annotation ![AltText](url)"

	| res |
	res := self splitter parse: 'abc![AltText]last'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: { 'abc![AltText]last' }
]

{ #category : #'tests - math' }
MicInlineSplitterTest >> testUnclosedMath [

	| res |
	res := self splitter parse: 'abc$	V_i = C_0 - C_3	&def'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: { 'abc$	V_i = C_0 - C_3	&def' }
]

{ #category : #'tests - formats' }
MicInlineSplitterTest >> testUnclosedStrike [

	| res |
	res := self splitter parse: 'abc~strikeédef'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: { 'abc~strikeédef' }
]

{ #category : #'tests - url' }
MicInlineSplitterTest >> testUrlObjectInUrlBlocks [

	| res |
	res := self splitter parse: 'abc[test](myURL)last'.
	self assert: res second url class equals: ZnUrl.
	self assert: res second url segments first equals: 'myURL'
]

{ #category : #'tests to make green again' }
MicInlineSplitterTest >> testUrlObjectInUrlBlocks2 [

	| res |
	res := self splitter parse:
		       'abc[pulse](https://github.com/Ducasse/NewTools-NewHelpBrowser/pulse#merged-pull-requests)last'.
	self assert: res second url class equals: ZnUrl.
	self flag: #tofix. "substring just returns pulse???"
	self assert: res second url segments first equals: 'Ducasse'
]

{ #category : #tests }
MicInlineSplitterTest >> testWrappedElementOnBold [
	| mic |
	mic := (self splitter parse: '**bold**') first.
	self assert: mic class equals: MicBoldFormatBlock.
	self assert: mic substring equals: 'bold'
]

{ #category : #tests }
MicInlineSplitterTest >> testWrappedElementOnNested [
	| mic |
	mic := (self splitter parse: '**_italic_**') first.
	self assert: mic wrappedElements first class equals: MicItalicFormatBlock.
	self assert: mic wrappedElements first substring equals: 'italic'.
	self flag: #fixeMe. "should check that we do not have empty mictext"
]
