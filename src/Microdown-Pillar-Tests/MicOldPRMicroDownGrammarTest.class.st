Class {
	#name : #MicOldPRMicroDownGrammarTest,
	#superclass : #TestCase,
	#instVars : [
		'factory'
	],
	#category : #'Microdown-Pillar-Tests'
}

{ #category : #accessing }
MicOldPRMicroDownGrammarTest >> factory [

	^ factory
]

{ #category : #accessing }
MicOldPRMicroDownGrammarTest >> factory: aFactory [

	factory := aFactory
]

{ #category : #'tests - header' }
MicOldPRMicroDownGrammarTest >> headerClass [
	^ PRHeader
]

{ #category : #accessing }
MicOldPRMicroDownGrammarTest >> parse: sample rule: aClass [

	| parser micDoc pillarDoc |
	parser := self parserClass new. 
	micDoc := parser parse: sample.
	pillarDoc := micDoc asPillar.
	self assert: pillarDoc children first class equals: aClass.
]

{ #category : #accessing }
MicOldPRMicroDownGrammarTest >> parserClass [
	^ MicroDownParser
]

{ #category : #running }
MicOldPRMicroDownGrammarTest >> setUp [ 
	super setUp.
	self factory: MicMicroDownSnippetFactory new.
]

{ #category : #'tests - anchor' }
MicOldPRMicroDownGrammarTest >> testAnchor [
	self parse: factory anchorSample rule: PRAnchor
]

{ #category : #'tests - anchor' }
MicOldPRMicroDownGrammarTest >> testAnchorAreTrimed [
	self parse: factory anchorAreTrimedSample rule: #anchor
]

{ #category : #'tests - anchor' }
MicOldPRMicroDownGrammarTest >> testAnchorWithNewLine [
	self parse: factory anchorWithNewLineSample rule: #elementWithNewline
]

{ #category : #'tests - anchor' }
MicOldPRMicroDownGrammarTest >> testAnchorWithSpaceInside [
	self parse: factory anchorWithSpaceInsideSample rule: #anchor
]

{ #category : #'tests - format' }
MicOldPRMicroDownGrammarTest >> testBoldFormat [
	self parse: factory boldFormatSample rule: #format
]

{ #category : #'tests - format' }
MicOldPRMicroDownGrammarTest >> testBoldFormatEmpty [
	self parse: factory boldFormatEmptySample rule: #format
]

{ #category : #'tests - header' }
MicOldPRMicroDownGrammarTest >> testHeaderEmpty [
	self parse: factory headerEmptySample rule: self headerClass
]

{ #category : #'tests - header' }
MicOldPRMicroDownGrammarTest >> testHeaderLevel1 [
	self parse: factory headerLevel1Sample rule: self headerClass
]

{ #category : #'tests - header' }
MicOldPRMicroDownGrammarTest >> testHeaderLevel2 [
	self parse: factory headerLevel2Sample rule: self headerClass
]

{ #category : #'tests - header' }
MicOldPRMicroDownGrammarTest >> testHeaderLevel3 [
	self parse: factory headerLevel3Sample rule: self headerClass
]

{ #category : #'tests - header' }
MicOldPRMicroDownGrammarTest >> testHeaderLevel4 [
	self parse: factory headerLevel4Sample rule: self headerClass
]

{ #category : #'tests - header' }
MicOldPRMicroDownGrammarTest >> testHeaderLevel5 [
	self parse: factory headerLevel5Sample rule: self headerClass
]

{ #category : #'tests - header' }
MicOldPRMicroDownGrammarTest >> testHeaderWithFormat [
	self parse: factory headerWithFormatSample rule: self headerClass
]

{ #category : #'tests - header' }
MicOldPRMicroDownGrammarTest >> testHeaderWithNewLine [
	self parse: factory headerWithNewLineSample rule: self headerClass
]

{ #category : #'tests - format' }
MicOldPRMicroDownGrammarTest >> testItalicFormat [
	self parse: factory italicFormatSample rule: #format
]

{ #category : #'tests - format' }
MicOldPRMicroDownGrammarTest >> testItalicFormatEmpty [
	self parse: factory italicFormatEmptySample rule: #format
]

{ #category : #'tests - document' }
MicOldPRMicroDownGrammarTest >> testLineEnd [
	self parse: factory lineEndSample rule: #lineEnd
]

{ #category : #'tests - document' }
MicOldPRMicroDownGrammarTest >> testLineEndwithNewline [
	self parse: factory lineEndwithNewlineSample rule: #lineEnd
]

{ #category : #'tests - list' }
MicOldPRMicroDownGrammarTest >> testListMulti [
	self parse: factory listMultiSample rule: #lists
]

{ #category : #'tests - list' }
MicOldPRMicroDownGrammarTest >> testListWithComment [
	self parse: factory listWithCommentSample rule: #list
]

{ #category : #'tests - format' }
MicOldPRMicroDownGrammarTest >> testMonospaceFormat [
	self parse: factory monospaceFormatSample rule: #format
]

{ #category : #'tests - format' }
MicOldPRMicroDownGrammarTest >> testMonospaceFormatEmpty [
	self parse: factory monospaceFormatEmptySample rule: #format
]

{ #category : #'tests - document' }
MicOldPRMicroDownGrammarTest >> testNewline [
	self parse: factory newlineSample rule: #newline
]

{ #category : #'tests - document' }
MicOldPRMicroDownGrammarTest >> testNewlineCR [
	self parse: factory newlineCRSample rule: #newline
]

{ #category : #'tests - document' }
MicOldPRMicroDownGrammarTest >> testNewlineCRLF [
	self parse: factory newlineCRLFSample rule: #newline
]

{ #category : #'tests - document' }
MicOldPRMicroDownGrammarTest >> testNewlineLF [
	self parse: factory newlineLFSample rule: #newline
]

{ #category : #'tests - list' }
MicOldPRMicroDownGrammarTest >> testOrderedList [
	self parse: factory orderedListSample rule: #orderedList
]

{ #category : #'tests - list' }
MicOldPRMicroDownGrammarTest >> testOrderedListEmpty [
	self parse: factory orderedListEmptySample rule: #orderedList
]

{ #category : #'tests - list' }
MicOldPRMicroDownGrammarTest >> testOrderedListWithTwoItems [
	self
		parse: factory orderedListWithTwoItemsSample
		rule: #orderedList
]

{ #category : #'tests - codeblock' }
MicOldPRMicroDownGrammarTest >> testScript [
	self parse: factory scriptSample rule: #script
]

{ #category : #'tests - codeblock' }
MicOldPRMicroDownGrammarTest >> testScriptParameter [
	self
		parse: factory scriptParameterSample
		rule: #parameterUntilNewline
]

{ #category : #'tests - codeblock' }
MicOldPRMicroDownGrammarTest >> testScriptParameterEscape [
	self
		parse: factory scriptParameterEscapeSample
		rule: #parameterUntilNewline
]

{ #category : #'tests - codeblock' }
MicOldPRMicroDownGrammarTest >> testScriptParameterTrueByDefault [
	self 
		parse: factory scriptParameterTrueByDefaultSample 
		rule: #script
]

{ #category : #'tests - codeblock' }
MicOldPRMicroDownGrammarTest >> testScriptParameterValue [
	self
		parse: factory scriptParameterValueSample
		rule: #parameterValueUntilNewline
]

{ #category : #'tests - codeblock' }
MicOldPRMicroDownGrammarTest >> testScriptParameterWithFloat [
	self parse: factory scriptParameterWithFloatSample rule: #script
]

{ #category : #'tests - codeblock' }
MicOldPRMicroDownGrammarTest >> testScriptParameterWithNoValues [
	self parse: factory scriptParameterWithNoValuesSample rule: #script
]

{ #category : #'tests - codeblock' }
MicOldPRMicroDownGrammarTest >> testScriptParameterWithSpacesBeforeAndAfter [
	self
		parse: factory scriptParameterWithSpacesBeforeAndAfterSample
		rule: #scriptParameters
]

{ #category : #'tests - codeblock' }
MicOldPRMicroDownGrammarTest >> testScriptParameterWithoutValue [
	self
		parse: factory scriptParameterWithoutValueSample
		rule: #parameterUntilNewline
]

{ #category : #'tests - codeblock' }
MicOldPRMicroDownGrammarTest >> testScriptParameters [
	self parse: factory scriptParametersSample rule: #scriptParameters
]

{ #category : #'tests - codeblock' }
MicOldPRMicroDownGrammarTest >> testScriptParametersEscape [
	self
		parse: factory scriptParametersEscapeSample
		rule: #scriptParameters
]

{ #category : #'tests - codeblock' }
MicOldPRMicroDownGrammarTest >> testScriptParametersMultiple [
	self
		parse: factory scriptParametersMultipleSample
		rule: #scriptParameters
]

{ #category : #'tests - codeblock' }
MicOldPRMicroDownGrammarTest >> testScriptTwoParametersNoValue [
	self
		parse: factory scriptTwoParametersNoValueSample
		rule: #scriptParameters
]

{ #category : #'tests - codeblock' }
MicOldPRMicroDownGrammarTest >> testScriptWithLanguage [
	self parse: factory scriptWithLanguageSample rule: #script
]

{ #category : #'tests - codeblock' }
MicOldPRMicroDownGrammarTest >> testScriptWithNewLine [
	self parse: factory scriptWithNewLineSample rule: #script
]

{ #category : #'tests - codeblock' }
MicOldPRMicroDownGrammarTest >> testScriptWithSpaceAtTheEnd [
	self parse: factory scriptWithSpaceAtTheEndSample rule: #script
]

{ #category : #'tests - codeblock' }
MicOldPRMicroDownGrammarTest >> testScriptWithSpacedParameters [
	self parse: factory scriptWithSpacedParametersSample rule: #script
]

{ #category : #'tests - format' }
MicOldPRMicroDownGrammarTest >> testStrikethroughFormat [
	self parse: factory strikethroughFormatSample rule: #format
]

{ #category : #'tests - format' }
MicOldPRMicroDownGrammarTest >> testStrikethroughFormatEmpty [
	self parse: factory strikethroughFormatEmptySample rule: #format
]

{ #category : #'tests - format' }
MicOldPRMicroDownGrammarTest >> testSubscriptFormat [
	self parse: factory subscriptFormatSample rule: #format
]

{ #category : #'tests - format' }
MicOldPRMicroDownGrammarTest >> testSubscriptFormatEmpty [
	self parse: factory subscriptFormatEmptySample rule: #format
]

{ #category : #'tests - format' }
MicOldPRMicroDownGrammarTest >> testSuperscriptFormat [
	self parse: factory superscriptFormatSample rule: #format
]

{ #category : #'tests - format' }
MicOldPRMicroDownGrammarTest >> testSuperscriptFormatEmpty [
	self parse: factory superscriptFormatEmptySample rule: #format
]

{ #category : #'tests - list' }
MicOldPRMicroDownGrammarTest >> testUnorderedList [
	self parse: factory unorderedListSample rule: #unorderedList
]

{ #category : #'tests - list' }
MicOldPRMicroDownGrammarTest >> testUnorderedListEmpty [
	self parse: factory unorderedListEmptySample rule: #unorderedList
]

{ #category : #'tests - list' }
MicOldPRMicroDownGrammarTest >> testUnorderedListWithSubList [
	self
		parse: factory unorderedListWithSubListSample
		rule: #unorderedList
]

{ #category : #'tests - list' }
MicOldPRMicroDownGrammarTest >> testUnorderedListWithTwoItems [
	self
		parse: factory unorderedListWithTwoItemsSample
		rule: #unorderedList
]
