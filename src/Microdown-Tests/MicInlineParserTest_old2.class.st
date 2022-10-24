Class {
	#name : #'MicInlineParserTest_old2',
	#superclass : #TestCase,
	#pools : [
		'MicMicrodownSharedPool'
	],
	#category : #'Microdown-Tests-InlineParser'
}

{ #category : #accessing }
MicInlineParserTest_old2 >> splitter [
	^ MicInlineParser2 new
]

{ #category : #'tests - anchors' }
MicInlineParserTest_old2 >> testAnchorReference [

	| res |
	res := (self splitter parse: '*@foobar@*') first.
	self assert: (res isKindOf: MicAnchorReferenceBlock2).
	self assert: res substring equals: 'foobar'
]

{ #category : #'tests - anchors' }
MicInlineParserTest_old2 >> testAnchorReferenceUnevaluated [

	"When isEvaluated class method returns false, like anchor reference's case, inline inside shoudn't be evaluated"

	| res |
	res := (self splitter parse: '*@def**not bold**ghi@*') first.
	self
		assert: res substring equals: 'def**not bold**ghi'
]

{ #category : #'tests - annotation' }
MicInlineParserTest_old2 >> testAnnotationWithParameters [

	| res |
	res := self splitter parse:
		       'abc', AnnotationOpenerMarkup ,'foo|key=cite&label=42',AnnotationCloserMarkup,'def'.
	self assert: (res second isKindOf: MicAnnotationBlock2).
	self assert: (res second arguments at: 'key') equals: 'cite'.
	self assert: (res second arguments at: 'label') equals: '42'
]

{ #category : #'tests - annotation' }
MicInlineParserTest_old2 >> testAnnotationWithParametersWithBlank [

	| res |
	res := (self splitter parse: AnnotationOpenerMarkup,'an annotation|key=&label=42', AnnotationCloserMarkup) first.
	self assert: (res isKindOf: MicAnnotationBlock2).
	self assert: (res arguments at: 'key') equals: ''.
	self assert: (res arguments at: 'label') equals: '42'
]

{ #category : #'tests - formats' }
MicInlineParserTest_old2 >> testBold [

	| res |
	res := (self splitter parse: '**foobar**') first.
	self
		assert: (res isKindOf: MicBoldFormatBlock2);
		assert: res children first substring equals: 'foobar'
]

{ #category : #'tests - formats' }
MicInlineParserTest_old2 >> testBold_atLeft [

	| res |
	res := (self splitter parse: '**foobar**bbb') first.
	self
		assert: (res isKindOf: MicBoldFormatBlock2);
		assert: res children first substring equals: 'foobar'.
]

{ #category : #'tests - formats' }
MicInlineParserTest_old2 >> testBold_atRight [

	| res |
	res := (self splitter parse: 'aaa**foobar**') second.
	self
		assert: (res isKindOf: MicBoldFormatBlock2);
		assert: res children first substring equals: 'foobar'.
]

{ #category : #'tests - formats' }
MicInlineParserTest_old2 >> testBold_inContext [

	| res |
	res := (self splitter parse: 'aaa**foobar**bbb') second.
	self
		assert: (res isKindOf: MicBoldFormatBlock2);
		assert: res children first substring equals: 'foobar'.
]

{ #category : #tests }
MicInlineParserTest_old2 >> testChildrenElementOnNested [
	| mic |
	mic := (self splitter parse: '**_italic_**') first.
	self assert: mic children first class equals: MicItalicFormatBlock2.
	self assert: mic children first children first substring equals: 'italic'.
]

{ #category : #tests }
MicInlineParserTest_old2 >> testCurlyBraceDoesNotLeadToProblem [
	| mic |
	mic := (self splitter parse:  ' jhkjhk { a }') first.
	self assert: mic substring equals:  ' jhkjhk { a }'
]

{ #category : #'tests to make green again' }
MicInlineParserTest_old2 >> testEscapeCharacter [

	"we should have just one escape"

	| res |
	res := (self splitter parse: 'not \`mono\` here') first.
	self assert: res substring equals: 'not `mono` here'
]

{ #category : #'tests - escape' }
MicInlineParserTest_old2 >> testEscapeCharacterAtBeginning [
	"Test the escape \ in simple case (here, bold one)"

	| res |
	res := (self splitter parse: '\**test**') first.
	self
		assert: res substring
		equals: '**test**'
]

{ #category : #'tests - escape' }
MicInlineParserTest_old2 >> testEscapeCharacterInLinkName [
	"Test the escape \ in link description"

	| res |
	res := (self splitter parse: '[\**test**](myURL)') first.
	self
		assert: (res isKindOf: MicLinkBlock2);
		assert: res children first substring equals: '**test**'
	
]

{ #category : #'tests - escape' }
MicInlineParserTest_old2 >> testEscapeCharacterInNestedCase [
	"Test the escape \ in case of nested formats"

	| res |
	res := (self splitter parse: 'abc_\**not bold** italic_last') second.
	self assert: (res isKindOf: MicItalicFormatBlock2 ).
	self assert: (res children first isKindOf: MicTextBlock2 ).
	self assert: res children first substring equals: '**not bold** italic'
]

{ #category : #'tests - escape' }
MicInlineParserTest_old2 >> testEscapeCharacterInNestedLinkName [
	"Test the escape \ in case of nested linknames"

	| res |
	res := (self splitter parse: 'abc[\[nested\]](myURL)last') second.
	self
		assert: (res children first substring)
		equals: '[nested]'
]

{ #category : #'tests to make green again' }
MicInlineParserTest_old2 >> testEscapeCharacterTwoConsecutive [
	"we should have just one escape"

	| res |
	res := (self splitter parse: '\\begin\\atend\\') first.
	self assert: res substring equals: '\begin\atend\'
]

{ #category : #'tests to make green again' }
MicInlineParserTest_old2 >> testEscapeCharacterWithNoCharacterAfter [

	| res |
	res := self splitter parse: '\'.
	
	self
		assert: res first substring equals: '\'
]

{ #category : #tests }
MicInlineParserTest_old2 >> testEscapeEncode [
	| roundTrip |
	self assert: (MicInlineParser escapeEncode: '') equals: ''.
	self assert: (MicInlineParser escapeEncode: 'abc') equals: 'abc'.
	self assert: (MicInlineParser escapeEncode: 'abc\') equals: 'abc\'.
	self assert: (MicInlineParser escapeEncode: '\') equals: '\'.
	roundTrip := [ :str | MicInlineParser escapeDecode: (MicInlineParser escapeEncode: str) ].
	self assert: (roundTrip value: 'aa\\bb') equals: 'aa\bb'.
	self assert: (roundTrip value: '\aa\\bb') equals: 'aa\bb'.
	self assert: (roundTrip value: 'aa\`bb') equals: 'aa`bb'.
	self assert: (roundTrip value: 'aa\@b@b') equals: 'aa@b@b'.
	self assert: (roundTrip value: '\\') equals: '\'.
]

{ #category : #'tests - formats' }
MicInlineParserTest_old2 >> testEscapeMonospace [
	"When isEvaluated class method returns false, like monospace's case, inline inside shoudn't be evaluated"

	| res |
	res := self splitter parse: 'abc`\`monospace\``efg'.
	self
		assert: res second substring equals: '`monospace`'.
	self assert: res second class equals: MicMonospaceFormatBlock2
]

{ #category : #tests }
MicInlineParserTest_old2 >> testEscapeReEscape [
	| roundTrip |
	roundTrip := [ :str :keep | 
		MicInlineParser escapeReescape: (MicInlineParser escapeEncode: str)  except:  keep ].
	
	self assert: (roundTrip value: '' value: 'aa') equals: ''.
	self assert: (roundTrip value: 'abc' value: '') equals: 'abc'.
	self assert: (roundTrip value: 'aa\\bb' value: '' ) equals: 'aa\\bb'.
	self assert: (roundTrip value: '\aa\\bb' value: 'a') equals: 'aa\\bb'.
]

{ #category : #'tests - escape' }
MicInlineParserTest_old2 >> testEscapeTripleBold [
	"Test the escape \ in case of nested formats"

	| res |
	res := self splitter parse:  'ccc\***bbb**aaa'.
	self
		assert: res first substring equals: 'ccc*';
		assert: res second children first substring equals: 'bbb'.
]

{ #category : #'tests - various' }
MicInlineParserTest_old2 >> testExclamationMark [

	"Test that 'bla!bla' is ok, and not a failed image, same goes for '![goo]no parenthesis'"

	| res |
	res := (self splitter parse: 'bla!bla') first.
	self
		assert: res substring equals: 'bla!bla'.
	res := (self splitter parse: '![goo]no parenthesis') first.
	self
		assert: res substring equals: '![goo]no parenthesis' 
]

{ #category : #'tests - figure' }
MicInlineParserTest_old2 >> testFigure [
	"Test the image annotation ![AltText](url)"

	| res |
	res := (self splitter parse:
		       'abc![AltText](my_directory/image.png)last') second.
	self assert: (res isKindOf: MicFigureBlock2).
	self assert: res children first substring equals: 'AltText'.
	self assert: res url equals: 'my_directory/image.png'.
	self assert: (res reference isKindOf: MicResourceReference)
	
]

{ #category : #'tests - figure' }
MicInlineParserTest_old2 >> testFigureWithBracketInsteadOfParentheses [
	"Test the image annotation ![AltText](url)"

	| res |
	res := (self splitter parse: 'abc![AltText][my_directory/image.png]last') first.
	self assert: res substring equals: 'abc![AltText][my_directory/image.png]last'
]

{ #category : #'tests - figure' }
MicInlineParserTest_old2 >> testFigureWithParameters [

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
MicInlineParserTest_old2 >> testFigureWithParametersWithBlank [

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
MicInlineParserTest_old2 >> testFigureWithParenthesesInsteadOfBracket [
	"Test the image annotation ![AltText](url)"

	| res |
	res := self splitter parse:
		       'abc!(AltText)(my_directory/image.png)last'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: { 'Text(abc!(AltText)(my_directory/image.png)last)' }
]

{ #category : #'tests - formats' }
MicInlineParserTest_old2 >> testItalic [

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
MicInlineParserTest_old2 >> testItalicNestedInBold [

	| res |
	res := self splitter parse: 'abc**bold_italic_bold**xyz'.
	self
		assert: (res collect: [ :x | x printString ]) 
		equals: { 'Text(abc)'. 'BoldFormat(Text(bold) ItalicFormat(Text(italic)) Text(bold))'.
			'Text(xyz)' }
]

{ #category : #'tests - formats' }
MicInlineParserTest_old2 >> testItalicNestedInBoldWithSpace [

	| res |
	res := self splitter parse: 'abc**x_y_z**cba'.
	self
		assert: (res collect: [ :x | x printString ]) 
		equals: { 'Text(abc)'. 'BoldFormat(Text(x) ItalicFormat(Text(y)) Text(z))'. 'Text(cba)' }
]

{ #category : #'tests - math' }
MicInlineParserTest_old2 >> testMath [

	| res |
	res := self splitter parse: 'abc$	V_i = C_0 - C_3	$def'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: { 'Text(abc)'. '[	V_i = C_0 - C_3	](math)'.
		'Text(def)' }.
	self assert: (res second isKindOf: MicMathInlineBlock)
]

{ #category : #'tests - math' }
MicInlineParserTest_old2 >> testMath2 [

	| res |
	res := self splitter parse: 'abc$math env$def'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: { 'Text(abc)'. '[math env](math)'. 'Text(def)' }
]

{ #category : #'tests - math' }
MicInlineParserTest_old2 >> testMathshouldBeUnevaluated [

	"When isEvaluated class method returns false, like math's case, inline inside shoudn't be evaluated"

	| res |
	res := self splitter parse: 'abc$def**not bold**ghi$xyz'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: { 'Text(abc)'. '[def**not bold**ghi](math)'.
		'Text(xyz)' }
]

{ #category : #'tests - formats' }
MicInlineParserTest_old2 >> testMonospace [

	| res |
	res := self splitter parse: 'ab`block`de'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: { 'Text(ab)'. 'MonospaceFormat(block)'. 'Text(de)' }
]

{ #category : #'tests - formats' }
MicInlineParserTest_old2 >> testMonospaceDoesNotTreatNestedElements [

	| res |
	res := self splitter parse: '`[* foo *])`'.
	self assert: res first substring equals: '[* foo *])'
]

{ #category : #'tests - formats' }
MicInlineParserTest_old2 >> testMonospaceUnevaluated [
	"When isEvaluated class method returns false, like monospace's case, inline inside shoudn't be evaluated"

	| res |
	res := self splitter parse: 'abc`def**not bold**ghi`xyz'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: { 'Text(abc)'. 'MonospaceFormat(def**not bold**ghi)'.
			'Text(xyz)' }.
	self assert: res second class equals: MicMonospaceFormatBlock
]

{ #category : #'tests - formats' }
MicInlineParserTest_old2 >> testMultipleSequenceFormats [

	"Test with multiple annotations"

	| res |
	res := self splitter parse: 'abc**abc**xyz`xyz`last'.
	self
		assert: (res collect: [ :x | x printString ]) "#('Text(abc)' 'BoldFormat(Text(abc))' 'Text(xyz)' 'MonospaceFormat(Text(xyz))' 'Text(last)')"
		equals: { 'Text(abc)'. 'BoldFormat(Text(abc))'. 'Text(xyz)'. 'MonospaceFormat(xyz)'.
		'Text(last)' }
]

{ #category : #'tests - various' }
MicInlineParserTest_old2 >> testNoAnnotation [

	| res |
	res := self splitter parse: 'abc'.
	self assert: res first printString equals: 'Text(abc)'.

	res := self splitter parse: 'abc def gh'.
	self assert: res first printString equals: 'Text(abc def gh)'
]

{ #category : #'tests - formats' }
MicInlineParserTest_old2 >> testOverlappingFormat [

	| res |
	res := self splitter parse: 'ab**boldstart_ boldend** italicEnd_de'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: #('Text(ab)' 'BoldFormat(Text(boldstart_ boldend))' 'Text( italicEnd_de)')
]

{ #category : #'tests - formats' }
MicInlineParserTest_old2 >> testOverlappingFormat2 [

	| res |
	res := self splitter parse: 'ab**boldstart_ boldend** _italicstart zz italicEnd_de'.
	self
		assert: (res collect: [ :x | x printString ]) ""
		equals: #('Text(ab)' 'BoldFormat(Text(boldstart_ boldend))' 'Text( )' 'ItalicFormat(Text(italicstart zz italicEnd))' 'Text(de)')
]

{ #category : #'tests - various' }
MicInlineParserTest_old2 >> testParseEmptyText [

	| res |
	res := self splitter parse: ''.
	self assert: res isEmpty
]

{ #category : #'tests - link' }
MicInlineParserTest_old2 >> testParseMissingStartURL [
	"Test the link annotation [LinkText]url)"

	| res |
	res := self splitter parse: '[Pharo is cool])'.
	self assert: res first class = MicTextBlock.
]

{ #category : #'tests - link' }
MicInlineParserTest_old2 >> testParseMissingStartURLInPresenceOfNestedFormat [
	"Test the link annotation [LinkText]url) _*foo*_"

	| res |
	res := self splitter parse: '[LinkText]htt) 
	_*foo*_'.
	self assert: res first class = MicTextBlock.

]

{ #category : #'tests - link' }
MicInlineParserTest_old2 >> testParseShitInMiddleURL [
	"Test the link annotation [Pharo is cool]khkjhjkh klhkjhkh (http://pharo.org)"

	| res |
	res := self splitter parse:
		       '[Pharo is cool]khkjhjkh klhkjhkh (http://pharo.org)'.

	self assert: res first class = MicTextBlock.
	self assert: res size equals: 1
]

{ #category : #'tests - raw' }
MicInlineParserTest_old2 >> testRaw [

	| res |
	res := self splitter parse: 'abc{{someRaw}}def'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: { 'Text(abc)'. '[someRaw](raw)'. 'Text(def)' }
]

{ #category : #'tests - raw' }
MicInlineParserTest_old2 >> testRawUnevaluated [

	"When isEvaluated class method returns false, like raw's case, inline inside shoudn't be evaluated"

	| res |
	res := self splitter parse: 'abc{{def**not bold**ghi}}xyz'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: { 'Text(abc)'. '[def**not bold**ghi](raw)'.
		'Text(xyz)' }
]

{ #category : #'tests - formats' }
MicInlineParserTest_old2 >> testSequenceOfFormats [
	"Test with multiple annotations"

	| res |
	res := self splitter parse: 'abc**abc**xyz`xyz`last'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: { 'Text(abc)'. 'BoldFormat(Text(abc))'. 'Text(xyz)'. 'MonospaceFormat(xyz)'.
		'Text(last)' }
]

{ #category : #'tests - annotation' }
MicInlineParserTest_old2 >> testSplitAnnotation [

	| res |
	res := self splitter parse:
		       'abc',AnnotationOpenerMarkup,'type:value|key1=val1&key2=val2', AnnotationCloserMarkup, 'def'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: { 'Text(abc)'. AnnotationOpenerMarkup,'type:value|key1=val1&key2=val2',AnnotationCloserMarkup .
			'Text(def)' }
]

{ #category : #'tests - annotation' }
MicInlineParserTest_old2 >> testSplitBlockAnnotation [

	| res |
	res := self splitter 
		parse: 'abc', AnnotationOpenerMarkup ,'an annotation', AnnotationCloserMarkup ,'def'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: { 'Text(abc)'. AnnotationOpenerMarkup ,'an annotation',AnnotationCloserMarkup . 'Text(def)' }.
	self assert: (res second isKindOf: MicAnnotationBlock)
]

{ #category : #'tests - link' }
MicInlineParserTest_old2 >> testSplitBlockLink [
	"Test the link annotation [LinkText](url)"

	| res |
	res := self splitter parse: 'abc[LinkText](myURL)last'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: { 'Text(abc)'. '[LinkText](myURL)'. 'Text(last)' }.
	self assert: (res second reference isKindOf: MicResourceReference)

]

{ #category : #'tests - link' }
MicInlineParserTest_old2 >> testSplitBlockLinkIncomplete [

	| res |
	res := self splitter parse: 'abc[LinkText]last'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: { 'Text(abc[LinkText]last)' }.
	self assert: res first class equals: MicTextBlock
]

{ #category : #'tests - link' }
MicInlineParserTest_old2 >> testSplitBlockLinkInlineImage [

	| res |
	res := self splitter parse: 'abc[![alttext](imageurl)](url)last'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: { 'Text(abc)'. '[![alttext](imageurl)](url)'.
			'Text(last)' }.

]

{ #category : #'tests - link' }
MicInlineParserTest_old2 >> testSplitBlockLinkWithBracketInsteadOfParentheses [

	"Test the link annotation [LinkText](url)"

	| res |
	res := self splitter parse: 'abc[LinkText][myURL]last'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: { 'Text(abc[LinkText][myURL]last)' }
]

{ #category : #'tests - link' }
MicInlineParserTest_old2 >> testSplitBlockLinkWithParenthesesInsteadOfBracket [

	"Test the link annotation [LinkText](url)"

	| res |
	res := self splitter parse: 'abc(LinkText)(myURL)last'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: { 'Text(abc(LinkText)(myURL)last)' }
]

{ #category : #'tests - formats' }
MicInlineParserTest_old2 >> testStrike [

	| res |
	res := self splitter parse: 'abc~strike~def'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: { 'Text(abc)'. 'StrikeFormat(Text(strike))'. 'Text(def)' }.
	self assert: res second class equals: MicStrikeFormatBlock
]

{ #category : #'tests to make green again' }
MicInlineParserTest_old2 >> testTwoConsecutiveEscapeCharacter [

	"we should have just one escape"

	| res |
	res := self splitter parse: '\\'.
	self assert: (res collect: [ :x | x printString ]) equals: { 'Text(\)' }
]

{ #category : #'tests - annotation' }
MicInlineParserTest_old2 >> testUnclosedAnnotation [

	| res |
	res := self splitter parse: 'abc<?an annotation>def'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: { 'Text(abc<?an annotation>def)' }
]

{ #category : #'tests - formats' }
MicInlineParserTest_old2 >> testUnclosedBold [

	| res |
	res := self splitter parse: 'abc**xyz'.
	self assert: res first printString equals: 'Text(abc**xyz)'
]

{ #category : #'tests - figure' }
MicInlineParserTest_old2 >> testUnclosedFigure [
	"Test the image annotation ![AltText](url)"

	| res |
	res := self splitter parse: 'abc![AltText]last'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: { 'Text(abc![AltText]last)' }
]

{ #category : #'tests - math' }
MicInlineParserTest_old2 >> testUnclosedMath [

	| res |
	res := self splitter parse: 'abc$	V_i = C_0 - C_3	&def'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: { 'Text(abc$	V)'. 'ItalicFormat(Text(i = C))'. 'Text(0 - C_3	&def)' }
]

{ #category : #tests }
MicInlineParserTest_old2 >> testUnclosedOpeners [
	| openers |
	openers := MicAbstractDelimiter subclasses select: [ :d | d hasSubclasses not and: [d isOpener  ]] thenCollect: [ :d | d markup ].
	openers do: [ :opener |
		Microdown parse: 'foo', opener.
		Microdown parse: opener,'bar'.
		Microdown parse: 'foo',opener,'bar'.
		 ]
]

{ #category : #'tests - math' }
MicInlineParserTest_old2 >> testUnclosedRaw [

	| res |
	res := self splitter parse: 'abc{{	V_i = C_0 - C_3	&def'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: { 'Text(abc{{	V)'. 'ItalicFormat(Text(i = C))'. 'Text(0 - C_3	&def)' }
]

{ #category : #'tests - formats' }
MicInlineParserTest_old2 >> testUnclosedStrike [

	| res |
	res := self splitter parse: 'abc~strikeédef'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: { 'Text(abc~strikeédef)' }
]

{ #category : #'tests - url' }
MicInlineParserTest_old2 >> testUrlObjectInUrlBlocks [

	| res |
	res := self splitter parse: 'abc[test](myURL)last'.
	self assert: (res second reference isKindOf: MicResourceReference)

]

{ #category : #'tests to make green again' }
MicInlineParserTest_old2 >> testUrlObjectInUrlBlocks2 [

	| res |
	res := self splitter parse:
		       'abc[pulse](https://github.com/Ducasse/NewTools-NewHelpBrowser/pulse#merged-pull-requests)last'.
	self assert: (res second reference isKindOf: MicHTTPResourceReference ).
	self assert: res second reference fullName equals: 'https://github.com/Ducasse/NewTools-NewHelpBrowser/pulse#merged-pull-requests'
]

{ #category : #tests }
MicInlineParserTest_old2 >> testWrappedElementOnBold [
	| mic |
	mic := (self splitter parse: '**bold**') first.
	self assert: mic class equals: MicBoldFormatBlock.
	self assert: mic children first substring equals: 'bold'
]

{ #category : #tests }
MicInlineParserTest_old2 >> testWrappedElementOnNested [
	| mic |
	mic := (self splitter parse: '**_italic_**') first.
	self assert: mic wrappedElements first class equals: MicItalicFormatBlock.
	self assert: mic wrappedElements first substring equals: 'italic'.
	self flag: #fixeMe. "should check that we do not have empty mictext"
]
