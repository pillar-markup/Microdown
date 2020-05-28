"
This test case uses the microdownSnippetFactory and test that the conversion to Pillar object trees is correct. 
This is why it is in this package

Microdown text -> Microdown trees -> Pillar trees
"
Class {
	#name : #MicToPillarMicrodownParserTest,
	#superclass : #TestCase,
	#instVars : [
		'factory'
	],
	#category : #'Microdown-Pillar-Tests'
}

{ #category : #'tests - codeblock' }
MicToPillarMicrodownParserTest >> codeBlockClass [
	^ PRCodeblock
]

{ #category : #accessing }
MicToPillarMicrodownParserTest >> factory [

	^ factory
]

{ #category : #accessing }
MicToPillarMicrodownParserTest >> factory: aFactory [

	factory := aFactory
]

{ #category : #'tests - header' }
MicToPillarMicrodownParserTest >> headerClass [
	^ PRHeader
]

{ #category : #'tests - list' }
MicToPillarMicrodownParserTest >> orderedListClass [
	^ PROrderedList
]

{ #category : #accessing }
MicToPillarMicrodownParserTest >> parse: sample createElementOfClass: aClass [

	| parser micDoc pillarDoc |
	parser := self parserClass new. 
	micDoc := parser parse: sample.
	pillarDoc := micDoc asPillar.
	self assert: pillarDoc children first class equals: aClass.
]

{ #category : #accessing }
MicToPillarMicrodownParserTest >> parseCreateDocument: sample [ 

	| parser micDoc pillarDoc |
	parser := self parserClass new. 
	micDoc := parser parse: sample.
	pillarDoc := micDoc asPillar.
	self assert: pillarDoc class equals: PRDocument.
]

{ #category : #accessing }
MicToPillarMicrodownParserTest >> parserClass [
	^ MicroDownParser
]

{ #category : #'tests - document' }
MicToPillarMicrodownParserTest >> rootBlockClass [

	^ PRDocument
]

{ #category : #running }
MicToPillarMicrodownParserTest >> setUp [ 
	super setUp.
	self factory: MicMicroDownSnippetFactory new.
]

{ #category : #'tests - anchor' }
MicToPillarMicrodownParserTest >> testAnchor [
	self parse: factory anchorSample createElementOfClass: PRAnchor
]

{ #category : #'tests - anchor' }
MicToPillarMicrodownParserTest >> testAnchorAreTrimed [
	self parse: factory anchorAreTrimedSample createElementOfClass: #anchor
]

{ #category : #'tests - anchor' }
MicToPillarMicrodownParserTest >> testAnchorWithNewLine [
	self parse: factory anchorWithNewLineSample createElementOfClass: #elementWithNewline
]

{ #category : #'tests - anchor' }
MicToPillarMicrodownParserTest >> testAnchorWithSpaceInside [
	self parse: factory anchorWithSpaceInsideSample createElementOfClass: #anchor
]

{ #category : #'tests - format' }
MicToPillarMicrodownParserTest >> testBoldFormat [
	self parse: factory boldFormatSample createElementOfClass: #format
]

{ #category : #'tests - format' }
MicToPillarMicrodownParserTest >> testBoldFormatEmpty [
	self parse: factory boldFormatEmptySample createElementOfClass: #format
]

{ #category : #'tests - header' }
MicToPillarMicrodownParserTest >> testHeaderEmpty [
	self parse: factory headerEmptySample createElementOfClass: self headerClass
]

{ #category : #'tests - header' }
MicToPillarMicrodownParserTest >> testHeaderLevel1 [
	self parse: factory headerLevel1Sample createElementOfClass: self headerClass
]

{ #category : #'tests - header' }
MicToPillarMicrodownParserTest >> testHeaderLevel2 [
	self parse: factory headerLevel2Sample createElementOfClass: self headerClass
]

{ #category : #'tests - header' }
MicToPillarMicrodownParserTest >> testHeaderLevel3 [
	self parse: factory headerLevel3Sample createElementOfClass: self headerClass
]

{ #category : #'tests - header' }
MicToPillarMicrodownParserTest >> testHeaderLevel4 [
	self parse: factory headerLevel4Sample createElementOfClass: self headerClass
]

{ #category : #'tests - header' }
MicToPillarMicrodownParserTest >> testHeaderLevel5 [
	self parse: factory headerLevel5Sample createElementOfClass: self headerClass
]

{ #category : #'tests - header' }
MicToPillarMicrodownParserTest >> testHeaderWithFormat [
	self parse: factory headerWithFormatSample createElementOfClass: self headerClass
]

{ #category : #'tests - header' }
MicToPillarMicrodownParserTest >> testHeaderWithNewLine [
	self parse: factory headerWithNewLineSample createElementOfClass: self headerClass
]

{ #category : #'tests - format' }
MicToPillarMicrodownParserTest >> testItalicFormat [
	self parse: factory italicFormatSample createElementOfClass: #format
]

{ #category : #'tests - format' }
MicToPillarMicrodownParserTest >> testItalicFormatEmpty [
	self parse: factory italicFormatEmptySample createElementOfClass: #format
]

{ #category : #'tests - document' }
MicToPillarMicrodownParserTest >> testLineEnd [
	self parseCreateDocument: factory lineEndSample 
]

{ #category : #'tests - document' }
MicToPillarMicrodownParserTest >> testLineEndwithNewline [
	self parseCreateDocument: factory lineEndwithNewlineSample 
]

{ #category : #'tests - list' }
MicToPillarMicrodownParserTest >> testListMulti [
	self parse: factory listMultiSample createElementOfClass: self unorderedListClass
]

{ #category : #'tests - list' }
MicToPillarMicrodownParserTest >> testListWithComment [
	self skip.
	self parse: factory listWithCommentSample createElementOfClass: self orderedListClass 
]

{ #category : #'tests - format' }
MicToPillarMicrodownParserTest >> testMonospaceFormat [
	self parse: factory monospaceFormatSample createElementOfClass: #format
]

{ #category : #'tests - format' }
MicToPillarMicrodownParserTest >> testMonospaceFormatEmpty [
	self parse: factory monospaceFormatEmptySample createElementOfClass: #format
]

{ #category : #'tests - document' }
MicToPillarMicrodownParserTest >> testNewline [
	self parseCreateDocument: factory newlineSample 
]

{ #category : #'tests - document' }
MicToPillarMicrodownParserTest >> testNewlineCR [
	self parseCreateDocument: factory newlineCRSample 
]

{ #category : #'tests - document' }
MicToPillarMicrodownParserTest >> testNewlineCRLF [
	self parseCreateDocument: factory newlineCRLFSample 
]

{ #category : #'tests - document' }
MicToPillarMicrodownParserTest >> testNewlineLF [
	self parseCreateDocument: factory newlineLFSample 
]

{ #category : #'tests - list' }
MicToPillarMicrodownParserTest >> testOrderedList [
	self parse: factory orderedListSample createElementOfClass: self orderedListClass
]

{ #category : #'tests - list' }
MicToPillarMicrodownParserTest >> testOrderedListEmpty [
	self parse: factory orderedListEmptySample createElementOfClass: self orderedListClass
]

{ #category : #'tests - list' }
MicToPillarMicrodownParserTest >> testOrderedListWithTwoItems [
	self
		parse: factory orderedListWithTwoItemsSample
		createElementOfClass: self orderedListClass
]

{ #category : #'tests - codeblock' }
MicToPillarMicrodownParserTest >> testScript [
	self
		parse: factory scriptSample
		createElementOfClass: self codeBlockClass
]

{ #category : #'tests - codeblock internals' }
MicToPillarMicrodownParserTest >> testScriptParameter [
	self skip.
	self
		parse: factory scriptParameterSample
		createElementOfClass: #parameterUntilNewline
]

{ #category : #'tests - codeblock internals' }
MicToPillarMicrodownParserTest >> testScriptParameterEscape [
		self skip.
	self
		parse: factory scriptParameterEscapeSample
		createElementOfClass: #parameterUntilNewline
]

{ #category : #'tests - codeblock' }
MicToPillarMicrodownParserTest >> testScriptParameterTrueByDefault [
	self 
		parse: factory scriptParameterTrueByDefaultSample 
		createElementOfClass: self codeBlockClass 
]

{ #category : #'tests - codeblock internals' }
MicToPillarMicrodownParserTest >> testScriptParameterValue [
	self skip.
	self
		parse: factory scriptParameterValueSample
		createElementOfClass: #parameterValueUntilNewline
]

{ #category : #'tests - codeblock' }
MicToPillarMicrodownParserTest >> testScriptParameterWithFloat [
	self parse: factory scriptParameterWithFloatSample createElementOfClass: self codeBlockClass 
]

{ #category : #'tests - codeblock' }
MicToPillarMicrodownParserTest >> testScriptParameterWithNoValues [
	self parse: factory scriptParameterWithNoValuesSample createElementOfClass: self codeBlockClass 
]

{ #category : #'tests - codeblock internals' }
MicToPillarMicrodownParserTest >> testScriptParameterWithSpacesBeforeAndAfter [
		self skip.
	self
		parse: factory scriptParameterWithSpacesBeforeAndAfterSample
		createElementOfClass: #scriptParameters
]

{ #category : #'tests - codeblock internals' }
MicToPillarMicrodownParserTest >> testScriptParameterWithoutValue [
	self skip.
	self
		parse: factory scriptParameterWithoutValueSample
		createElementOfClass: #parameterUntilNewline
]

{ #category : #'tests - codeblock internals' }
MicToPillarMicrodownParserTest >> testScriptParameters [
	self skip.
	self parse: factory scriptParametersSample createElementOfClass: #scriptParameters
]

{ #category : #'tests - codeblock internals' }
MicToPillarMicrodownParserTest >> testScriptParametersEscape [
	self skip.
	self
		parse: factory scriptParametersEscapeSample
		createElementOfClass: #scriptParameters
]

{ #category : #'tests - codeblock internals' }
MicToPillarMicrodownParserTest >> testScriptParametersMultiple [
	self skip.
	self
		parse: factory scriptParametersMultipleSample
		createElementOfClass: #scriptParameters
]

{ #category : #'tests - codeblock internals' }
MicToPillarMicrodownParserTest >> testScriptTwoParametersNoValue [
	self skip.
	self
		parse: factory scriptTwoParametersNoValueSample
		createElementOfClass: #scriptParameters
]

{ #category : #'tests - codeblock' }
MicToPillarMicrodownParserTest >> testScriptWithLanguage [
	self parse: factory scriptWithLanguageSample createElementOfClass: self codeBlockClass 
]

{ #category : #'tests - codeblock' }
MicToPillarMicrodownParserTest >> testScriptWithNewLine [
	self parse: factory scriptWithNewLineSample createElementOfClass: self codeBlockClass 
]

{ #category : #'tests - codeblock' }
MicToPillarMicrodownParserTest >> testScriptWithSpaceAtTheEnd [
	self parse: factory scriptWithSpaceAtTheEndSample createElementOfClass: self codeBlockClass 
]

{ #category : #'tests - codeblock' }
MicToPillarMicrodownParserTest >> testScriptWithSpacedParameters [
	self parse: factory scriptWithSpacedParametersSample createElementOfClass: self codeBlockClass
]

{ #category : #'tests - format' }
MicToPillarMicrodownParserTest >> testStrikethroughFormat [
	self parse: factory strikethroughFormatSample createElementOfClass: #format
]

{ #category : #'tests - format' }
MicToPillarMicrodownParserTest >> testStrikethroughFormatEmpty [
	self parse: factory strikethroughFormatEmptySample createElementOfClass: #format
]

{ #category : #'tests - format' }
MicToPillarMicrodownParserTest >> testSubscriptFormat [
	self parse: factory subscriptFormatSample createElementOfClass: #format
]

{ #category : #'tests - format' }
MicToPillarMicrodownParserTest >> testSubscriptFormatEmpty [
	self parse: factory subscriptFormatEmptySample createElementOfClass: #format
]

{ #category : #'tests - format' }
MicToPillarMicrodownParserTest >> testSuperscriptFormat [
	self parse: factory superscriptFormatSample createElementOfClass: #format
]

{ #category : #'tests - format' }
MicToPillarMicrodownParserTest >> testSuperscriptFormatEmpty [
	self parse: factory superscriptFormatEmptySample createElementOfClass: #format
]

{ #category : #'tests - list' }
MicToPillarMicrodownParserTest >> testUnorderedList [
	self parse: factory unorderedListSample createElementOfClass: self unorderedListClass 
]

{ #category : #'tests - list' }
MicToPillarMicrodownParserTest >> testUnorderedListEmpty [
	self parse: factory unorderedListEmptySample createElementOfClass: self unorderedListClass 
]

{ #category : #'tests - list' }
MicToPillarMicrodownParserTest >> testUnorderedListWithSubList [
	self
		parse: factory unorderedListWithSubListSample
		createElementOfClass: self unorderedListClass 
]

{ #category : #'tests - list' }
MicToPillarMicrodownParserTest >> testUnorderedListWithTwoItems [
	self
		parse: factory unorderedListWithTwoItemsSample
		createElementOfClass: self unorderedListClass 
]

{ #category : #'tests - list' }
MicToPillarMicrodownParserTest >> unorderedListClass [

	^ PRUnorderedList 
]
