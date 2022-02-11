"
These tests should be merged in MicrodDownInlineParserTest
"
Class {
	#name : #MicInlineParserTest,
	#superclass : #TestCase,
	#pools : [
		'MicroSharedPool'
	],
	#category : #'Microdown-Tests-Parser'
}

{ #category : #accessing }
MicInlineParserTest >> splitter [
	^ MicInlineParser new
]

{ #category : #'tests - anchors' }
MicInlineParserTest >> testAnchorReference [

	| res |
	res := self splitter parse: 'abc*@anchorA@*def'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: { 'Text(abc)'. '[anchorA](anchorReference)'.
		'Text(def)' }.
	self assert: (res second isKindOf: MicAnchorReferenceBlock)
]

{ #category : #'tests - anchors' }
MicInlineParserTest >> testAnchorReferenceUnevaluated [

	"When isEvaluated class method returns false, like anchor reference's case, inline inside shoudn't be evaluated"

	| res |
	res := self splitter parse: 'abc*@def**not bold**ghi@*xyz'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: { 'Text(abc)'. '[def**not bold**ghi](anchorReference)'.
			'Text(xyz)' }
]

{ #category : #'tests - annotation' }
MicInlineParserTest >> testAnnotationWithParameters [

	| res |
	res := self splitter parse:
		       'abc', AnnotationOpenerMarkup ,'an annotation|key=cite&label=42',AnnotationCloserMarkup,'def'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: { 'Text(abc)'. AnnotationOpenerMarkup,'an annotation|key=cite&label=42', AnnotationCloserMarkup.
			'Text(def)' }.
	self assert: (res second isKindOf: MicAnnotationBlock).
	self assert: (res second arguments at: 'key') equals: 'cite'.
	self assert: (res second arguments at: 'label') equals: '42'
]

{ #category : #'tests - annotation' }
MicInlineParserTest >> testAnnotationWithParametersWithBlank [

	| res |
	res := self splitter parse: 'abc', AnnotationOpenerMarkup,'an annotation|key=&label=42', AnnotationCloserMarkup,'def'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: { 'Text(abc)'. AnnotationOpenerMarkup ,'an annotation|key=&label=42', AnnotationCloserMarkup.
			'Text(def)' }.
	self assert: (res second isKindOf: MicAnnotationBlock).
	self assert: (res second arguments at: 'key') equals: ''.
	self assert: (res second arguments at: 'label') equals: '42'
]

{ #category : #'tests - formats' }
MicInlineParserTest >> testBold [

	| res |
	res := self splitter parse: 'abc**bold**def'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: { 'Text(abc)'. 'BoldFormat(Text(bold))'. 'Text(def)' }.
	self assert: res second kind equals: #bold.

	res := self splitter parse: 'abc** b old **def'.
	self
		assert: (res collect: [ :x | x printString ]) "#('Text(abc)' 'BoldFormat(Text( b old ))' 'Text(def)')"
		equals: { 'Text(abc)'. 'BoldFormat(Text( b old ))'. 'Text(def)' }.
	self assert: res second kind equals: #bold
]

{ #category : #tests }
MicInlineParserTest >> testCurlyBraceDoesNotLeadToProblem [
	| mic |
	mic := (self splitter parse:  ' jhkjhk { a }') first.
	self assert: mic substring equals:  ' jhkjhk { a }'
]

{ #category : #'tests to make green again' }
MicInlineParserTest >> testEscapeCharacter [

	"we should have just one escape"

	| res |
	res := self splitter parse: 'not \`mono\` here'.
	self assert: (res collect: [ :x | x printString ]) equals: { 'Text(not `mono` here)' }
]

{ #category : #'tests - escape' }
MicInlineParserTest >> testEscapeCharacterAtBeginning [
	"Test the escape \ in simple case (here, bold one)"

	| res |
	res := self splitter parse: '\**test**'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: { 'Text(**test**)' }
]

{ #category : #'tests - escape' }
MicInlineParserTest >> testEscapeCharacterInLinkName [
	"Test the escape \ in link description"

	| res |
	res := self splitter parse: 'abc[\**test**](myURL)last'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: { 'Text(abc)'. '[**test**](myURL)'. 'Text(last)' }
]

{ #category : #'tests - escape' }
MicInlineParserTest >> testEscapeCharacterInNestedCase [
	"Test the escape \ in case of nested formats"

	| res |
	res := self splitter parse: 'abc_\**not bold** italic_last'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: {'Text(abc)' . 'ItalicFormat(Text(**not bold** italic))' . 'Text(last)'}.
]

{ #category : #'tests - escape' }
MicInlineParserTest >> testEscapeCharacterInNestedLinkName [
	"Test the escape \ in case of nested linknames"

	| res |
	res := self splitter parse: 'abc[\[nested\]](myURL)last'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: { 'Text(abc)'. '[[nested]](myURL)'. 'Text(last)' }
]

{ #category : #'tests to make green again' }
MicInlineParserTest >> testEscapeCharacterTwoConsecutive [
	"we should have just one escape"

	| res |
	res := self splitter parse: '\\begin\\atend\\'.
	self assert: (res collect: [ :x | x printString ]) equals: { 'Text(\begin\atend\)' }
]

{ #category : #'tests to make green again' }
MicInlineParserTest >> testEscapeCharacterWithNoCharacterAfter [

	| res |
	res := self splitter parse: '\'.
	
	self
		assert: res first substring equals: '\'
]

{ #category : #'tests - formats' }
MicInlineParserTest >> testEscapeMonospace [
	"When isEvaluated class method returns false, like monospace's case, inline inside shoudn't be evaluated"

	| res |
	res := self splitter parse: 'abc`\`monospace\``efg'.
	self
		assert: res second substring equals: '`monospace`'.
	self assert: res second class equals: MicMonospaceFormatBlock
]

{ #category : #'tests - escape' }
MicInlineParserTest >> testEscapeTripleBold [
	"Test the escape \ in case of nested formats"

	| res |
	res := self splitter parse:  'c\***bo**la'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: {'Text(c*)' . 'BoldFormat(Text(bo))' . 'Text(la)'}.
]

{ #category : #'tests - various' }
MicInlineParserTest >> testExclamationMark [

	"Test that 'bla!bla' is ok, and not a failed image, same goes for '![goo]no parenthesis'"

	| res |
	res := self splitter parse: 'bla!bla'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: { 'Text(bla!bla)' }.
	res := self splitter parse: '![goo]no parenthesis'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: { 'Text(![goo]no parenthesis)' }
]

{ #category : #'tests - figure' }
MicInlineParserTest >> testFigure [
	"Test the image annotation ![AltText](url)"

	| res |
	res := self splitter parse:
		       'abc![AltText](my_directory/image.png)last'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: { 'Text(abc)'. '![AltText](my_directory/image.png)'.
			'Text(last)' }.
	self assert: (res second isKindOf: MicFigureBlock).
	self assert: (res second reference  isKindOf: MicResourceReference)
	
]

{ #category : #'tests - figure' }
MicInlineParserTest >> testFigureWithBracketInsteadOfParentheses [
	"Test the image annotation ![AltText](url)"

	| res |
	res := self splitter parse:
		       'abc![AltText][my_directory/image.png]last'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: { 'Text(abc![AltText][my_directory/image.png]last)' }
]

{ #category : #'tests - figure' }
MicInlineParserTest >> testFigureWithParameters [

	"Test the image annotation ![AltText](url)"

	| res |
	res := self splitter parse:
		       'abc![AltText](my_directory/image.png label=42&width=90)last'.
	self
		assert: (res collect: [ :x | x printString ])
		equals:
			{ 'Text(abc)'. '![AltText](my_directory/image.png label=42&width=90)'.
			'Text(last)' }.
	self assert: (res second isKindOf: MicFigureBlock).
	self assert: (res second reference isKindOf: MicResourceReference).
	self assert: (res second arguments at: 'label') equals: '42'.
	self assert: (res second arguments at: 'width') equals: '90'
]

{ #category : #'tests - figure' }
MicInlineParserTest >> testFigureWithParametersWithBlank [

	"Test the image annotation ![AltText](url)"

	| res |
	res := self splitter parse:
		       'abc![AltText](my_directory/image.png label=&width=90)last'.
	self
		assert: (res collect: [ :x | x printString ])
		equals:
			{ 'Text(abc)'. '![AltText](my_directory/image.png label=&width=90)'.
			'Text(last)' }.
	self assert: (res second isKindOf: MicFigureBlock).
	self assert: (res second reference isKindOf: MicResourceReference).
	self assert: (res second arguments at: 'label') equals: ''.
	self assert: (res second arguments at: 'width') equals: '90'
]

{ #category : #'tests - figure' }
MicInlineParserTest >> testFigureWithParenthesesInsteadOfBracket [
	"Test the image annotation ![AltText](url)"

	| res |
	res := self splitter parse:
		       'abc!(AltText)(my_directory/image.png)last'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: { 'Text(abc!(AltText)(my_directory/image.png)last)' }
]

{ #category : #'tests - formats' }
MicInlineParserTest >> testItalic [

	| res |
	res := self splitter parse: 'abc_italics_def'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: { 'Text(abc)'. 'ItalicFormat(Text(italics))'. 'Text(def)' }.

	res := self splitter parse: 'abc_ ita lics _def'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: { 'Text(abc)'. 'ItalicFormat(Text( ita lics ))'. 'Text(def)' }
]

{ #category : #'tests - formats' }
MicInlineParserTest >> testItalicNestedInBold [

	| res |
	res := self splitter parse: 'abc**bold_italic_bold**xyz'.
	self
		assert: (res collect: [ :x | x printString ]) 
		equals: { 'Text(abc)'. 'BoldFormat(Text(bold) ItalicFormat(Text(italic)) Text(bold))'.
			'Text(xyz)' }
]

{ #category : #'tests - formats' }
MicInlineParserTest >> testItalicNestedInBoldWithSpace [

	| res |
	res := self splitter parse: 'abc**x_y_z**cba'.
	self
		assert: (res collect: [ :x | x printString ]) 
		equals: { 'Text(abc)'. 'BoldFormat(Text(x) ItalicFormat(Text(y)) Text(z))'. 'Text(cba)' }
]

{ #category : #'tests - math' }
MicInlineParserTest >> testMath [

	| res |
	res := self splitter parse: 'abc$	V_i = C_0 - C_3	$def'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: { 'Text(abc)'. '[	V_i = C_0 - C_3	](math)'.
		'Text(def)' }.
	self assert: (res second isKindOf: MicMathInlineBlock)
]

{ #category : #'tests - math' }
MicInlineParserTest >> testMath2 [

	| res |
	res := self splitter parse: 'abc$math env$def'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: { 'Text(abc)'. '[math env](math)'. 'Text(def)' }
]

{ #category : #'tests - math' }
MicInlineParserTest >> testMathshouldBeUnevaluated [

	"When isEvaluated class method returns false, like math's case, inline inside shoudn't be evaluated"

	| res |
	res := self splitter parse: 'abc$def**not bold**ghi$xyz'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: { 'Text(abc)'. '[def**not bold**ghi](math)'.
		'Text(xyz)' }
]

{ #category : #'tests - formats' }
MicInlineParserTest >> testMonospace [

	| res |
	res := self splitter parse: 'ab`block`de'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: { 'Text(ab)'. 'MonospaceFormat(Text(block))'. 'Text(de)' }
]

{ #category : #'tests - formats' }
MicInlineParserTest >> testMonospaceDoesNotTreatNestedElements [

	| res |
	res := self splitter parse: '`[* foo *])`'.
	self assert: res first substring equals: '[* foo *])'
]

{ #category : #'tests - formats' }
MicInlineParserTest >> testMonospaceUnevaluated [
	"When isEvaluated class method returns false, like monospace's case, inline inside shoudn't be evaluated"

	| res |
	res := self splitter parse: 'abc`def**not bold**ghi`xyz'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: { 'Text(abc)'. 'MonospaceFormat(Text(def**not bold**ghi))'.
			'Text(xyz)' }.
	self assert: res second class equals: MicMonospaceFormatBlock
]

{ #category : #'tests - formats' }
MicInlineParserTest >> testMultipleSequenceFormats [

	"Test with multiple annotations"

	| res |
	res := self splitter parse: 'abc**abc**xyz`xyz`last'.
	self
		assert: (res collect: [ :x | x printString ]) "#('Text(abc)' 'BoldFormat(Text(abc))' 'Text(xyz)' 'MonospaceFormat(Text(xyz))' 'Text(last)')"
		equals: { 'Text(abc)'. 'BoldFormat(Text(abc))'. 'Text(xyz)'. 'MonospaceFormat(Text(xyz))'.
		'Text(last)' }
]

{ #category : #'tests - various' }
MicInlineParserTest >> testNoAnnotation [

	| res |
	res := self splitter parse: 'abc'.
	self assert: res first printString equals: 'Text(abc)'.

	res := self splitter parse: 'abc def gh'.
	self assert: res first printString equals: 'Text(abc def gh)'
]

{ #category : #'tests - formats' }
MicInlineParserTest >> testOverlappingFormat [

	| res |
	res := self splitter parse: 'ab**boldstart_ boldend** italicEnd_de'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: #('Text(ab)' 'BoldFormat(Text(boldstart_ boldend))' 'Text( italicEnd_de)')
]

{ #category : #'tests - formats' }
MicInlineParserTest >> testOverlappingFormat2 [

	| res |
	res := self splitter parse: 'ab**boldstart_ boldend** _italicstart zz italicEnd_de'.
	self
		assert: (res collect: [ :x | x printString ]) ""
		equals: #('Text(ab)' 'BoldFormat(Text(boldstart_ boldend))' 'Text( )' 'ItalicFormat(Text(italicstart zz italicEnd))' 'Text(de)')
]

{ #category : #'tests - various' }
MicInlineParserTest >> testParseEmptyText [

	| res |
	res := self splitter parse: ''.
	self assert: res isEmpty
]

{ #category : #'tests - link' }
MicInlineParserTest >> testParseMissingStartURL [
	"Test the link annotation [LinkText]url)"

	| res |
	res := self splitter parse: '[Pharo is cool])'.
	self assert: res first class = MicTextBlock.
]

{ #category : #'tests - link' }
MicInlineParserTest >> testParseMissingStartURLInPresenceOfNestedFormat [
	"Test the link annotation [LinkText]url) _*foo*_"

	| res |
	res := self splitter parse: '[LinkText]htt) 
	_*foo*_'.
	self assert: res first class = MicTextBlock.

]

{ #category : #'tests - link' }
MicInlineParserTest >> testParseShitInMiddleURL [
	"Test the link annotation [Pharo is cool]khkjhjkh klhkjhkh (http://pharo.org)"

	| res |
	res := self splitter parse:
		       '[Pharo is cool]khkjhjkh klhkjhkh (http://pharo.org)'.

	self assert: res first class = MicTextBlock.
	self assert: res size equals: 1
]

{ #category : #'tests - raw' }
MicInlineParserTest >> testRaw [

	| res |
	res := self splitter parse: 'abc{{someRaw}}def'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: { 'Text(abc)'. '[someRaw](raw)'. 'Text(def)' }
]

{ #category : #'tests - raw' }
MicInlineParserTest >> testRawUnevaluated [

	"When isEvaluated class method returns false, like raw's case, inline inside shoudn't be evaluated"

	| res |
	res := self splitter parse: 'abc{{def**not bold**ghi}}xyz'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: { 'Text(abc)'. '[def**not bold**ghi](raw)'.
		'Text(xyz)' }
]

{ #category : #'tests - formats' }
MicInlineParserTest >> testSequenceOfFormats [
	"Test with multiple annotations"

	| res |
	res := self splitter parse: 'abc**abc**xyz`xyz`last'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: { 'Text(abc)'. 'BoldFormat(Text(abc))'. 'Text(xyz)'. 'MonospaceFormat(Text(xyz))'.
		'Text(last)' }
]

{ #category : #'tests - annotation' }
MicInlineParserTest >> testSplitAnnotation [

	| res |
	res := self splitter parse:
		       'abc',MicAnnotationOpenerDelimiter markup,'type:value|key1=val1&key2=val2',MicAnnotationCloserDelimiter markup,'def'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: { 'Text(abc)'. MicAnnotationOpenerDelimiter markup,'type:value|key1=val1&key2=val2',MicAnnotationCloserDelimiter markup.
			'Text(def)' }
]

{ #category : #'tests - annotation' }
MicInlineParserTest >> testSplitBlockAnnotation [

	| res |
	res := self splitter parse: 'abc',MicAnnotationOpenerDelimiter markup,'an annotation',MicAnnotationCloserDelimiter markup,'def'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: { 'Text(abc)'. MicAnnotationOpenerDelimiter markup,'an annotation',MicAnnotationCloserDelimiter markup. 'Text(def)' }.
	self assert: (res second isKindOf: MicAnnotationBlock)
]

{ #category : #'tests - link' }
MicInlineParserTest >> testSplitBlockLink [
	"Test the link annotation [LinkText](url)"

	| res |
	res := self splitter parse: 'abc[LinkText](myURL)last'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: { 'Text(abc)'. '[LinkText](myURL)'. 'Text(last)' }.
	self assert: (res second reference isKindOf: MicResourceReference)

]

{ #category : #'tests - link' }
MicInlineParserTest >> testSplitBlockLinkIncomplete [

	| res |
	res := self splitter parse: 'abc[LinkText]last'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: { 'Text(abc[LinkText]last)' }.
	self assert: res first class equals: MicTextBlock
]

{ #category : #'tests - link' }
MicInlineParserTest >> testSplitBlockLinkInlineImage [

	| res |
	res := self splitter parse: 'abc[![alttext](imageurl)](url)last'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: { 'Text(abc)'. '[![alttext](imageurl)](url)'.
			'Text(last)' }.

]

{ #category : #'tests - link' }
MicInlineParserTest >> testSplitBlockLinkWithBracketInsteadOfParentheses [

	"Test the link annotation [LinkText](url)"

	| res |
	res := self splitter parse: 'abc[LinkText][myURL]last'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: { 'Text(abc[LinkText][myURL]last)' }
]

{ #category : #'tests - link' }
MicInlineParserTest >> testSplitBlockLinkWithParenthesesInsteadOfBracket [

	"Test the link annotation [LinkText](url)"

	| res |
	res := self splitter parse: 'abc(LinkText)(myURL)last'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: { 'Text(abc(LinkText)(myURL)last)' }
]

{ #category : #'tests - formats' }
MicInlineParserTest >> testStrike [

	| res |
	res := self splitter parse: 'abc~strike~def'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: { 'Text(abc)'. 'StrikeFormat(Text(strike))'. 'Text(def)' }.
	self assert: res second class equals: MicStrikeFormatBlock
]

{ #category : #'tests to make green again' }
MicInlineParserTest >> testTwoConsecutiveEscapeCharacter [

	"we should have just one escape"

	| res |
	res := self splitter parse: '\\'.
	self assert: (res collect: [ :x | x printString ]) equals: { 'Text(\)' }
]

{ #category : #'tests - annotation' }
MicInlineParserTest >> testUnclosedAnnotation [

	| res |
	res := self splitter parse: 'abc<?an annotation>def'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: { 'Text(abc<?an annotation>def)' }
]

{ #category : #'tests - formats' }
MicInlineParserTest >> testUnclosedBold [

	| res |
	res := self splitter parse: 'abc**xyz'.
	self assert: res first printString equals: 'Text(abc**xyz)'
]

{ #category : #'tests - figure' }
MicInlineParserTest >> testUnclosedFigure [
	"Test the image annotation ![AltText](url)"

	| res |
	res := self splitter parse: 'abc![AltText]last'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: { 'Text(abc![AltText]last)' }
]

{ #category : #'tests - math' }
MicInlineParserTest >> testUnclosedMath [

	| res |
	res := self splitter parse: 'abc$	V_i = C_0 - C_3	&def'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: { 'Text(abc$	V_i = C_0 - C_3	&def)' }
]

{ #category : #'tests - formats' }
MicInlineParserTest >> testUnclosedStrike [

	| res |
	res := self splitter parse: 'abc~strikeédef'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: { 'Text(abc~strikeédef)' }
]

{ #category : #'tests - url' }
MicInlineParserTest >> testUrlObjectInUrlBlocks [

	| res |
	res := self splitter parse: 'abc[test](myURL)last'.
	self assert: (res second reference isKindOf: MicResourceReference)

]

{ #category : #'tests to make green again' }
MicInlineParserTest >> testUrlObjectInUrlBlocks2 [

	| res |
	res := self splitter parse:
		       'abc[pulse](https://github.com/Ducasse/NewTools-NewHelpBrowser/pulse#merged-pull-requests)last'.
	self assert: (res second reference isKindOf: MicHTTPResourceReference ).
	self flag: #tofix. "substring just returns pulse???"
	self assert: res second reference uri asString equals: 'https://github.com/Ducasse/NewTools-NewHelpBrowser/pulse#merged-pull-requests'
]

{ #category : #tests }
MicInlineParserTest >> testWrappedElementOnBold [
	| mic |
	mic := (self splitter parse: '**bold**') first.
	self assert: mic class equals: MicBoldFormatBlock.
	self assert: mic substring equals: 'bold'
]

{ #category : #tests }
MicInlineParserTest >> testWrappedElementOnNested [
	| mic |
	mic := (self splitter parse: '**_italic_**') first.
	self assert: mic wrappedElements first class equals: MicItalicFormatBlock.
	self assert: mic wrappedElements first substring equals: 'italic'.
	self flag: #fixeMe. "should check that we do not have empty mictext"
]
