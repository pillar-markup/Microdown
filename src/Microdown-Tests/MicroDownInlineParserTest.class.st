Class {
	#name : #MicroDownInlineParserTest,
	#superclass : #TestCase,
	#instVars : [
		'parser'
	],
	#category : #'Microdown-Tests'
}

{ #category : #parsing }
MicroDownInlineParserTest >> parse: aString [

	"self new parse: 'foo_abbb_zz' "

	| contents doc elements |
	doc := self parserClass parse: aString.
	contents := doc children first text.
	elements := MicInlineSplitter new parse: contents.
	doc children: { (MicParagraphBlock new children: elements) }.
	^ doc
]

{ #category : #parsing }
MicroDownInlineParserTest >> parseAndReturnElementsOfParagraphFor: aString [ 
 	"self new parse: 'foo_abbb_zz' "
 	^ (self parse: aString) children first children
 
]

{ #category : #parsing }
MicroDownInlineParserTest >> parser [
	^ self parserClass new 
]

{ #category : #parsing }
MicroDownInlineParserTest >> parserClass [ 
	^ MicroDownParser 
]

{ #category : #tests }
MicroDownInlineParserTest >> rawTestingFor: aString [

 	| elements |
 	elements := self parseAndReturnElementsOfParagraphFor: 'abc{{', aString, '}}def'.
 	self assert: elements size equals: 3.
 	self assert: elements first substring equals: 'abc'.
 	self assert: elements second substring equals: aString.
 	self assert: elements second kind equals: 'raw'.
 	self assert: elements second openingDelimiter equals: '{{'.
 	self assert: elements second closingDelimiter equals: '}}'
]

{ #category : #'tests - anchors' }
MicroDownInlineParserTest >> testAnchorReferenceWithoutClosure [
 	| elements |
 	elements := (self parseAndReturnElementsOfParagraphFor: 'abc*@anchorsdef').
 	self assert: elements size equals: 1.
 	self assert: elements first substring equals: 'abc*@anchorsdef'
]

{ #category : #'tests - anchors' }
MicroDownInlineParserTest >> testAnchorRefernce [
 	| elements |
 	elements := (self parseAndReturnElementsOfParagraphFor: 'abc*@anchors@*def').
 	self assert: elements size equals: 3.
 	self assert: elements first substring equals: 'abc'.
 	self assert: elements second substring equals: 'anchors'.
 	self assert: elements second kind equals: 'anchorReference'.
 	self assert: elements second openingDelimiter equals: '*@'.
 	self assert: elements second closingDelimiter equals: '@*'
]

{ #category : #'tests to make green' }
MicroDownInlineParserTest >> testAnnotationBasic [
 	| elements annotation |
	self skip.
 	elements := self parseAndReturnElementsOfParagraphFor: 'needed <?footnote | value=A foonote is annotation.?>'.
	"pay attention an annotation is inside a paragraph (else this is an environment)"
	annotation := elements second.
	
 	self assert: annotation substring equals: 'footnote | value=A foonote is annotation.'.
	
	self halt.
 	self assert: annotation kind equals: 'annotation'.
 	self assert: annotation openingDelimiter equals: '<?'.
 	self assert: annotation closingDelimiter equals: '?>'
 
]

{ #category : #'tests - annotations' }
MicroDownInlineParserTest >> testAnnotationPrintString [
 	| elements |
	self skip.
	self flag: #fixMe.
 	elements := self parseAndReturnElementsOfParagraphFor: 'abc<?footnote | value=A foonote is annotation.&width=90?>def'.
 	self assert: elements size equals: 3.
 	self assert: elements second printString equals: '<?footnote|value=A foonote is annotation.&width=90?>'.
 
]

{ #category : #'tests - annotations' }
MicroDownInlineParserTest >> testAnnotations [
 	| elements |
 	elements := self parseAndReturnElementsOfParagraphFor: 'abc<?footnote | value=A foonote is annotation.?>def'.
 	self assert: elements size equals: 3.
 	self assert: elements first substring equals: 'abc'.
 	self assert: elements second substring equals: 'footnote | value=A foonote is annotation.'.
 	self assert: elements second kind equals: 'annotation'.
 	self assert: elements second openingDelimiter equals: '<?'.
 	self assert: elements second closingDelimiter equals: '?>'
 
]

{ #category : #'tests - annotations' }
MicroDownInlineParserTest >> testAnnotationsWithoutClosure [
 	| elements |
 	elements := self parseAndReturnElementsOfParagraphFor: 'abc<?footnote | value=A foonote is anannotation.def'.
 	self assert: elements size equals: 1.
 	self assert: elements first substring equals: 'abc<?footnote | value=A foonote is anannotation.def'
 
]

{ #category : #'tests - format' }
MicroDownInlineParserTest >> testBold [
 	| elements |
 	elements := self parseAndReturnElementsOfParagraphFor: 'abc**bolds**def'.
 	self assert: elements size equals: 3.
 	self assert: elements first substring equals: 'abc'.
	
 	self assert: elements second substring equals: 'bolds'.
 	self assert: elements second kind equals: 'bold'.
	
 	self assert: elements second openingDelimiter equals: '**'
 
]

{ #category : #'tests - format' }
MicroDownInlineParserTest >> testBoldsAndCorrectNestedItalics [

 	| elements bold italic |
 	elements := self parseAndReturnElementsOfParagraphFor: 'abc**_italicitalic_**def'.
 	self assert: elements size equals: 3.
 	self assert: elements first substring equals: 'abc'.
	bold := elements second.
	italic := bold children first.
	self assert: bold kind equals: 'bold'.
	self assert: italic kind equals: 'italic'.
		
 	self assert: italic substring equals: 'italicitalic'.
	self flag: #fixme. 
	"self assert: bold substring equals: 'italicitalic'"
 	
	

 
]

{ #category : #'tests to make green' }
MicroDownInlineParserTest >> testBoldsAndNestedItalics [ 
 	| elements |
	self skip.
	"MicBoldInline substring return _bolds_ but we were expecting to obtain bolds and to have it wrapped in italics"
 	elements := (self parseAndReturnElementsOfParagraphFor: 'abc**_bolds_**def').
 	self assert: elements size equals: 3.
 	self assert: elements first substring equals: 'abc'.
 	self assert: elements second substring equals: 'bolds'.
 	self assert: elements second kind equals: 'bold'.
 	self assert: elements second openingDelimiter equals: '**'
 
]

{ #category : #'tests - format' }
MicroDownInlineParserTest >> testBoldsAndNestedItalicsWithClosureAfterOpenItalics [

 	| elements |
 	elements := self parseAndReturnElementsOfParagraphFor: 'abc**_bolds**_def'.
 	self assert: elements size equals: 3.
 	self assert: elements first substring equals: 'abc'.
 	self assert: elements second substring equals: '_bolds'.
	self assert: elements third substring equals: '_def'.
 	self assert: elements second kind equals: 'bold'.
 	self assert: elements second openingDelimiter equals: '**'
 
]

{ #category : #'tests - format' }
MicroDownInlineParserTest >> testBoldsWithoutClosure [ 

 	| elements |
 	elements := self parseAndReturnElementsOfParagraphFor: 'abc**boldsdef'.
 	self assert: elements size equals: 1.
 	self assert: elements first substring equals: 'abc**boldsdef'
 
]

{ #category : #'tests - others' }
MicroDownInlineParserTest >> testEscape [

 	| elements |
 	elements := self parseAndReturnElementsOfParagraphFor: 'abc\_bolds_def'.
 	self assert: elements size equals: 1.
 	self assert: elements first substring equals: 'abc_bolds_def'.
 	self assert: elements first kind equals: 'basic'.
 
]

{ #category : #'tests - figure' }
MicroDownInlineParserTest >> testFigure [
 	| elements |
 	elements := self parseAndReturnElementsOfParagraphFor: 'abc![caption](url?parameters=value)def'.
 	self assert: elements size equals: 3.
 	self assert: elements first substring equals: 'abc'.
 	self assert: elements second caption equals: 'caption'.
 	self assert: elements second kind equals: 'figure'.
	
	self flag: #tofix.
	"the path should be correctly managed."
	
 	self assert: elements second openingDelimiter equals: '!['.
 	self assert: elements second closingDelimiter equals: ')'
]

{ #category : #'tests to make green' }
MicroDownInlineParserTest >> testFigureWithParameters [
 	| elements figure |
		self skip.
	self flag: #fixMe.
 	elements := self parseAndReturnElementsOfParagraphFor: '![caption terminating with a .](http://www.pharo.org/pharoLogo.png?label=fig2&width=80)'.
 	self assert: elements size equals: 1.
 	figure := elements first.
 	self assert: figure caption equals: 'caption terminating with a .'.
 	self assert: figure kind equals: 'figure'.
	self flag: #tofix.
	"parameters are empty and it look like the path is not parsed!"
	self assert: figure parameters size equals: 2. 
	
	
	

]

{ #category : #'tests - header' }
MicroDownInlineParserTest >> testHeaderLevel4 [
	| source root |
	source := (self parser headerMarkup repeat: 4), '    Level four'.
	root := self parser parse: source.
	self assert: root children size equals: 1.
	self assert: root children first headerString equals: 'Level four'.
	self assert: root children first level equals: 4
]

{ #category : #'tests - header' }
MicroDownInlineParserTest >> testHeaderLevel4WithBold [

	| source root |
	source := (self parser headerMarkup repeat: 4), 'Level **four** `mono` end'.
	root := self parser parse: source.
	self assert: root children size equals: 1.
	self assert: root children first children first substring equals: 'Level '.
	self assert: root children first children second substring equals: 'four'.
	self assert: root children first children third substring equals: ' '.
	self assert: root children first children fourth substring equals: 'mono'.
	self assert: root children first children fifth substring equals: ' end'.
	self assert: root children first level equals: 4.
]

{ #category : #'tests - format' }
MicroDownInlineParserTest >> testItalic [
 	| elements |
 	elements := self parseAndReturnElementsOfParagraphFor: 'abc_italics_def'.
 	self assert: elements size equals: 3.
 	self assert: elements first substring equals: 'abc'.
 	self assert: elements second substring equals: 'italics'.
 	self assert: elements second kind equals: 'italic'.
 	self assert: elements second openingDelimiter equals: '_'
]

{ #category : #'tests to make green' }
MicroDownInlineParserTest >> testItalicsAndNestedBolds [
 	| elements |
	self skip.
	"MicItalicInline substring return **italics** but we expected to have italic wrapped in bold"
 	elements := (self parseAndReturnElementsOfParagraphFor: 'abc_**italics**_def').
 	self assert: elements size equals: 3.
 	self assert: elements first substring equals: 'abc'.
 	self assert: elements second substring equals: 'italics'.
 	self assert: elements second kind equals: 'italic'.
 	self assert: elements second openingDelimiter equals: '_'
]

{ #category : #'tests - format' }
MicroDownInlineParserTest >> testItalicsAndNestedBoldsWithClosureAfterOpenBolds [

 	| elements |
 	elements := self parseAndReturnElementsOfParagraphFor: 'abc_**italics_**def'.
 	self assert: elements size equals: 3.
 	self assert: elements first substring equals: 'abc'.
 	self assert: elements second substring equals: '**italics'.
	self assert: elements third substring equals: '**def'.
 	self assert: elements second kind equals: 'italic'.
 	self assert: elements second openingDelimiter equals: '_'
 
]

{ #category : #'tests - format' }
MicroDownInlineParserTest >> testItalicsWithoutClosure [

 	| elements |
 	elements := self parseAndReturnElementsOfParagraphFor: 'abc_italicsdef'.
 	self assert: elements size equals: 1.
 	self assert: elements first substring equals: 'abc_italicsdef'
]

{ #category : #'tests - link' }
MicroDownInlineParserTest >> testLink [
 	| elements |
 	elements := (self parseAndReturnElementsOfParagraphFor: 'abc[Pharo.Org](http://www.pharo.org)def').
 	self assert: elements size equals: 3.
 	self assert: elements first substring equals: 'abc'.
	
 	self assert: elements second caption equals: 'Pharo.Org'.
 	self assert: elements second kind equals: 'linkName'.
	self assert: elements second url printString equals: 'http://www.pharo.org/'.
	
	
 	self assert: elements second openingDelimiter equals: '['.
 	self assert: elements second closingDelimiter equals: ')'
]

{ #category : #'tests - link' }
MicroDownInlineParserTest >> testLinkWithParameters [
 	| elements |
 	elements := (self parseAndReturnElementsOfParagraphFor: 'abc[GH Ducasse](https://github.com/Ducasse?tab=repositories)def').
 	self assert: elements size equals: 3.
 	self assert: elements first substring equals: 'abc'.
 	self assert: elements second substring equals: 'GH Ducasse'.
 	self assert: elements second kind equals: 'linkName'.
	
	self assert: elements second url printString equals: 'https://github.com/Ducasse?tab=repositories'.
	
 	self assert: elements second openingDelimiter equals: '['.
 	self assert: elements second closingDelimiter equals: ')'
]

{ #category : #'tests - others' }
MicroDownInlineParserTest >> testMath [
 	| elements |
 	elements := (self parseAndReturnElementsOfParagraphFor: 'abc$V_i = C_0 - C_3$def').
 	self assert: elements size equals: 3.
 	self assert: elements first substring equals: 'abc'.
 	self assert: elements second substring equals: 'V_i = C_0 - C_3'.
 	self assert: elements second kind equals: 'math'.
 	self assert: elements second openingDelimiter equals: '$'
]

{ #category : #'tests - format' }
MicroDownInlineParserTest >> testMonospace [

 	| elements |
 	elements := self parseAndReturnElementsOfParagraphFor: 'abc`monospaces`def'.
 	self assert: elements size equals: 3.
 	self assert: elements first substring equals: 'abc'.
 	self assert: elements second substring equals: 'monospaces'.
 	self assert: elements second kind equals: 'monospace'.
 	self assert: elements second openingDelimiter equals: '`'

]

{ #category : #'tests - format' }
MicroDownInlineParserTest >> testMonospacesWithoutClosure [
 	| elements |
 	elements := self parseAndReturnElementsOfParagraphFor: 'abc`monospacesdef'.
 	self assert: elements size equals: 1.
 	self assert: elements first substring equals: 'abc`monospacesdef'

]

{ #category : #tests }
MicroDownInlineParserTest >> testRawWitoutClosure [

 	| elements |
 	elements := self parseAndReturnElementsOfParagraphFor: 'abc{{rawsdef'.
 	self assert: elements size equals: 1.
 	self assert: elements first substring equals: 'abc{{rawsdef'
]

{ #category : #tests }
MicroDownInlineParserTest >> testRaws [
	self rawTestingFor: 'anything'
]

{ #category : #'tests to make green' }
MicroDownInlineParserTest >> testRawsDoesNotHandleWellCurly [
	self skip.
	self rawTestingFor: 'anything}'.
	
]

{ #category : #'tests to make green' }
MicroDownInlineParserTest >> testRawsDoesNotHandleWellEscape [
	self skip.
	self rawTestingFor: 'anything\*foo'.
	
]

{ #category : #tests }
MicroDownInlineParserTest >> testRawsHandleWellCurlyIfNotLast [
	
	self rawTestingFor: 'anything}88'.

]

{ #category : #tests }
MicroDownInlineParserTest >> testRawsWithBold [

 	self rawTestingFor: '**bold**'
]

{ #category : #tests }
MicroDownInlineParserTest >> testRawsWithItalic [

 	self rawTestingFor: '_italic_'
]

{ #category : #tests }
MicroDownInlineParserTest >> testRawsWithMonospace [
 	self rawTestingFor: '`monononono`'
]

{ #category : #tests }
MicroDownInlineParserTest >> testRawsWithStrike [
 	self rawTestingFor: '~strikkkkk~'
]

{ #category : #'tests - format' }
MicroDownInlineParserTest >> testStrike [

 	| elements |
 	elements := self parseAndReturnElementsOfParagraphFor: 'abc~strikes~def'.
 	self assert: elements size equals: 3.
 	self assert: elements first substring equals: 'abc'.
 	self assert: elements second substring equals: 'strikes'.
 	self assert: elements second kind equals: 'strike'.
 	self assert: elements second openingDelimiter equals: '~'
]

{ #category : #'tests - format' }
MicroDownInlineParserTest >> testStrikesWithoutClosure [

 	| elements |
 	elements := self parseAndReturnElementsOfParagraphFor: 'abc~strikesdef'.
 	self assert: elements size equals: 1.
 	self assert: elements first substring equals: 'abc~strikesdef'

]
