Class {
	#name : 'MicrodownParserTest',
	#superclass : 'TestCase',
	#instVars : [
		'parser'
	],
	#pools : [
		'MicSharedPool'
	],
	#category : 'Microdown-Tests-Parser',
	#package : 'Microdown-Tests',
	#tag : 'Parser'
}

{ #category : 'running' }
MicrodownParserTest >> parser [ 
	"for now this reference is needed and cannot be changed into Microdown"
	^ MicrodownParser new
]

{ #category : 'running' }
MicrodownParserTest >> setUp [
	"Hooks that subclasses may override to define the fixture of test."
	
	super setUp.
	parser := self parser
]

{ #category : 'tests - math' }
MicrodownParserTest >> stestMathBlockWithArguments [

	| source root math |
	source := MathOpeningBlockMarkup, 'label=equation&caption=doNiceMath' , String cr, 
	 '\mathcal{F} = \{ I \subseteq B | support(I) \geq minsup \}', String cr,
	MathClosingBlockMarkup, String cr.

	root :=  parser parse: source.
	self assert: root children size equals: 1.
	math := root children first.
	self assert: (math arguments at: 'label') equals: 'equation'.
	self assert: (math arguments at: 'caption') first substring equals: 'doNiceMath'
]

{ #category : 'tests - anchor' }
MicrodownParserTest >> testAnchorBlock [
	| source root annotated |
	source := AnchorMarkup, 'label1' , String cr , AnchorMarkup , 'label2'.
	root := parser parse: source.
	self assert: root children size equals: 2.
	annotated := root children at: 2. 
	self assert: annotated label equals: 'label2'.
	

]

{ #category : 'tests - anchor' }
MicrodownParserTest >> testAnchorBlockFollowingEachOther [

	| source root annotated |
	source := AnchorMarkup, 'label1', String cr.
	source := source, AnchorMarkup, 'label2'.
	root := parser parse: source.
	self assert: root children size equals: 2.
	annotated := root children first. 
	self assert: annotated label equals: 'label1'.
	
	annotated := root children second. 
	self assert: annotated label equals: 'label2'.
	

]

{ #category : 'tests - anchor' }
MicrodownParserTest >> testAnchorMarkupInsideLine [

	| source root paragraph |
	source := 'this is not an anchor', AnchorMarkup, 'label1'.
	root := parser parse: source.
	self assert: root children size equals: 1.
	paragraph := root children first. 
	self assert: (paragraph isKindOf: MicParagraphBlock).
	self assert: paragraph text equals: 'this is not an anchor', AnchorMarkup, 'label1'.
	

]

{ #category : 'tests - annotated-paragraph' }
MicrodownParserTest >> testAnnotatedBlock [

	| source root annotated |
	source := AnnotatedParagraphOpeningMarkup , 'important]
> this is an important paragraph on one line.'.
	root :=  parser parse: source.
	self assert: root children size equals: 1.
	annotated := root children first. 
	self assert: annotated class equals: MicAnnotatedParagraphBlock.
	self assert: annotated label equals: 'important'.
	self assert: annotated text equals: 'this is an important paragraph on one line.'
	

]

{ #category : 'tests - annotated-paragraph' }
MicrodownParserTest >> testAnnotatedBlockBackwardCompatible [

	| source root annotated |
	source := '!!important This is an important paragraph on one line.'.
	root :=  parser parse: source.
	self assert: root children size equals: 1.
	annotated := root children first. 
	self assert: annotated class equals: MicAnnotatedParagraphBlock.
	self assert: annotated label equals: 'important'.
	self assert: annotated text equals: 'This is an important paragraph on one line.'
	

]

{ #category : 'tests - annotated-paragraph' }
MicrodownParserTest >> testAnnotatedBlockBackwardCompatibleOnLongLine [

	| source root annotated |
	source := '!!important This is an important paragraph on one line. This is an important paragraph on one line. This is an important paragraph on one line. This is an important paragraph on one line. This is an important paragraph on one line. This is an important paragraph on one line. This is an important paragraph on one line. This is an important paragraph on one line. This is an important paragraph on one line. This is an important paragraph on one line. '.
	root :=  parser parse: source.
	self assert: root children size equals: 1.
	annotated := root children first. 
	self assert: annotated class equals: MicAnnotatedParagraphBlock.
	self assert: annotated label equals: 'important'.
	self assert: annotated text equals: 'This is an important paragraph on one line. This is an important paragraph on one line. This is an important paragraph on one line. This is an important paragraph on one line. This is an important paragraph on one line. This is an important paragraph on one line. This is an important paragraph on one line. This is an important paragraph on one line. This is an important paragraph on one line. This is an important paragraph on one line.'
]

{ #category : 'tests - annotated-paragraph' }
MicrodownParserTest >> testAnnotatedBlockBackwardCompatibleWithDifferentLabel [

	| source root annotated |
	source := '!!important This is an important paragraph on one line.'.
	root :=  parser parse: source.
	self assert: root children size equals: 1.
	annotated := root children first. 
	self assert: annotated class equals: MicAnnotatedParagraphBlock.
	self assert: annotated label equals: 'important'.
	self assert: annotated text equals: 'This is an important paragraph on one line.'
	

]

{ #category : 'tests - annotated-paragraph' }
MicrodownParserTest >> testAnnotatedBlockOnMultipleLinesParserLogic [

	| source root annotated  line |
	source := (AnnotatedParagraphOpeningMarkup , 'important]
> this is an 
> important point because...!') readStream.
	
	"first the root block"
	root := parser parse: ''.
	self assert: parser current equals: root. 
	
	"second the annotated"
	annotated := parser handleLine: source nextLine.
	self assert: parser current equals: annotated.
	self assert: annotated parent equals: root.  
	
	self assert: annotated label equals: 'important'.
	
	"third the second line"
	line := source nextLine.
	self assert: (annotated canConsumeLine: line).
	annotated := parser handleLine: line.
	self assert: parser current equals: annotated.
	self assert: (annotated instVarNamed: 'body') equals: 'this is an'.
	
"fourth the third line"
	line := source nextLine.
	self assert: (annotated canConsumeLine: line).
	annotated := parser handleLine: line.
	self assert: parser current equals: annotated.
	self assert: (annotated instVarNamed: 'body') equals: 'this is an
important point because...!'.
	
]

{ #category : 'tests - annotated-paragraph' }
MicrodownParserTest >> testAnnotatedBlockOnTwoLines [
	| source root annotated |
	source := AnnotatedParagraphOpeningMarkup , 'important]
> this is an important 
> paragraph on two lines.'.
	root := parser parse: source.
	self assert: root children size equals: 1.
	annotated := root children first. 
	self assert: annotated label equals: 'important'.
	self assert: annotated text equals: 'this is an important
paragraph on two lines.'

]

{ #category : 'tests - annotated-paragraph' }
MicrodownParserTest >> testAnnotatedBlockOnTwoLinesWithFormatting [
	| source root annotated |
	source := AnnotatedParagraphOpeningMarkup , 'important]
> **this** is an _important_ 
> paragraph on two lines.'.
	root := parser parse: source.
	self assert: root children size equals: 1.
	annotated := root children first. 
	self assert: annotated label equals: 'important'.
	self 
		assert: annotated children asArray asString 
		equals: 'an Array(BoldFormat{ Text(this) } Text( is an ) ItalicFormat{ Text(important) } Text(
paragraph on two lines.))'
]

{ #category : 'tests - annotated-paragraph' }
MicrodownParserTest >> testAnnotatedBlockTextElements [

	| source root annotated |
	source := AnnotatedParagraphOpeningMarkup , 'important]
> this is an **important** paragraph on one line.'.
	root :=  parser parse: source.
	self assert: root children size equals: 1.
	annotated := root children first. 
	self assert: root children first textElements first class equals: MicTextBlock.
	self assert: root children first textElements second class equals: MicBoldFormatBlock.
	self assert: root children first textElements third class equals: MicTextBlock
	

]

{ #category : 'tests - annotated-paragraph' }
MicrodownParserTest >> testAnnotatedBlockWithListParserLogic [
	"The test does not test what we want. We want a listblock inside the annotatedBlock"
	|  source root annotated  line |
	self flag: #fixme.
	source := (AnnotatedParagraphOpeningMarkup , 'important]
> this is a point
> - one
* two ' ) readStream.

 	parser := self parser. 
	
	"first the root block"
	root := parser parse: ''.
	self assert: parser current equals: root. 
	
	"second the annotated"
	annotated := parser handleLine: source nextLine.
	self assert: parser current equals: annotated.
	self assert: annotated parent equals: root.  
	
	self assert: annotated label equals: 'important'.
	
	"third the second line"
	line := source nextLine.
	
	self assert: (annotated canConsumeLine: line).
	annotated := parser handleLine: line.
	self assert: parser current equals: annotated.
	self assert: (annotated instVarNamed: 'body') equals: 'this is a point'.
	
	"fourth the third line"
	line := source nextLine.
	
	self assert: (annotated canConsumeLine: line).
	annotated := parser handleLine: line.
	self assert: parser current equals: annotated.
	self assert: (annotated instVarNamed: 'body') equals: 'this is a point
- one'.


]

{ #category : 'tests - comments' }
MicrodownParserTest >> testCommentOnMultipleLines [

	| source root comment |
	source := CommentedLineMarkup , 'a comment', String cr.
	source := source, CommentedLineMarkup , 'a second comment'.
	root :=  parser parse: source.
	self assert: root children size equals: 1.
	comment := root children first. 
	self assert: comment text equals: 'a comment
a second comment'
	
]

{ #category : 'tests - comments' }
MicrodownParserTest >> testCommentOnMultipleLinesWithASingleMarkup [

	| source root comment |
	source := CommentedLineMarkup , 'a comment', String cr.
	source := source, 'a second comment'.
	root :=  parser parse: source.
	"we have two commented lines."
	
	self assert: root children size equals: 2.
	comment := root children first. 
	self assert: comment text equals: 'a comment'.
	self assert: root children second text equals: 'a second comment'
	
]

{ #category : 'tests - comments' }
MicrodownParserTest >> testCommentSimple [

	| source root comment |
	source := CommentedLineMarkup , 'a comment'.
	root :=  parser parse: source.
	self assert: root children size equals: 1.
	comment := root children first. 
	self assert: comment text equals: 'a comment'
	
]

{ #category : 'tests - comments' }
MicrodownParserTest >> testCommentedLineMarkupInsideLine [

	| source root paragraph |
	source := 'this is not the start', CommentedLineMarkup , 'a comment'.
	root :=  parser parse: source.
	self assert: root children size equals: 1.
	paragraph := root children first. 
	self assert: (paragraph isKindOf: MicParagraphBlock).
	self assert: paragraph text equals: 'this is not the start', CommentedLineMarkup , 'a comment'
	
]

{ #category : 'tests' }
MicrodownParserTest >> testEnvironmentCitationWithArguments [
	| source root environmentName contents child |
	environmentName := 'cite'.
	contents := 'Hello
Pharo'.
	source := EnvironmentOpeningBlockMarkup, environmentName, ArgumentListStartDelimiter, 'a=1&b=17&c'	, String cr , contents , String cr, String cr, 
		EnvironmentClosingBlockMarkup , String cr.
	root := parser parse: source.
	child := root children first.
	self assert: (child isKindOf: MicEnvironmentBlock).
	self assert: child environmentName equals: environmentName.
	self assert: child children first text equals: contents.
	
	self assert: (child arguments at: 'a') equals: '1'.
	self assert: (child arguments at: 'b') equals: '17'.
	self assert: (child arguments at: 'c') equals: nil
]

{ #category : 'tests - environment' }
MicrodownParserTest >> testEnvironmentEatsNonClosedCodeMarkup [
	| source root env environmentName contents |
	environmentName := 'card'.
	contents := '- smalltalk
^ self foo

this is the end.'.
	source := EnvironmentOpeningBlockMarkup , environmentName
		, String cr , contents , String cr.
	root := parser parse: source.
	self assert: root children size equals: 1.
	env := root children first.
	self assert: (env isKindOf: MicEnvironmentBlock).
	self assert: env environmentName equals: environmentName.
	self assert: env children size equals: 3.
	self assert: env children third text equals: 'this is the end.'.
	
]

{ #category : 'tests' }
MicrodownParserTest >> testHandlePrefixTabs [
	| source tree columns column codeBlock |
	source := '
<!columns
	<!column
		```
		foo := 2 + 3
			ifHuge: [ "Well, it is not" ]
		```
		- List 
		- Line 2
	!>
!>'.
	tree := self parser parse: source.
	columns := tree children first.
	column := columns children first.
	codeBlock := column children first.
	self assert: columns class equals: MicColumnsBlock.
	self assert: column class equals: MicColumnBlock.
	self assert: codeBlock class equals: MicCodeBlock.
	self assert: column children second class equals: MicUnorderedListBlock.
	self assert: codeBlock body lines first equals: 'foo := 2 + 3'.
	self assert: codeBlock body lines second equals: (String tab, 'ifHuge: [ "Well, it is not" ]').
]

{ #category : 'tests - header' }
MicrodownParserTest >> testHeaderLevel4 [

	| source root |
	source := (HeaderMarkup repeat: 4) , '    Level four'.
	root := self parser parse: source.
	self assert: root children size equals: 1.
	self
		assert: root children first children first bodyString
		equals: 'Level four'.
	self assert: root children first level equals: 4
]

{ #category : 'tests - header' }
MicrodownParserTest >> testHeaderLevel4WithBold [

	| source root |
	source := (HeaderMarkup repeat: 4) , 'Level **four** `mono` end'.
	root := self parser parse: source.
	self assert: root children size equals: 1.
	self
		assert: root children first children first bodyString
		equals: 'Level '.
	self
		assert: root children first children asArray asString
		equals:
		'an Array(Text(Level ) BoldFormat{ Text(four) } Text( ) Monospace(mono) Text( end))'
]

{ #category : 'tests - horizontal' }
MicrodownParserTest >> testHorizontalBlock [

	| source root horizontal |
	source := HorizontalLineMarkup, 'ignored ignored ignore', String cr.
	root :=  parser parse: source.
	self assert: root children size equals: 1.
	horizontal := root children first. 
	self assert: (horizontal isKindOf: MicHorizontalLineBlock). 
	
]

{ #category : 'tests - horizontal' }
MicrodownParserTest >> testHorizontalBlockFollowedByList [

	| source root horizontal |
	source := HorizontalLineMarkup, 'ignored ignored ignore', String cr, '- item1'.
	root :=  parser parse: source.
	self assert: root children size equals: 2.
	horizontal := root children first. 
	self assert: (horizontal isKindOf: MicHorizontalLineBlock). 
	self assert: (root children second isKindOf: MicUnorderedListBlock). 
	
]

{ #category : 'tests - horizontal line' }
MicrodownParserTest >> testHorizontalLineBlock [
	| source root horizontal |
	source := HorizontalLineMarkup, 'label1'.
	root := parser parse: source.
	self assert: root children size equals: 1.
	horizontal := root children first. 
	self assert: (horizontal isKindOf: MicHorizontalLineBlock)
	
	




]

{ #category : 'tests - math' }
MicrodownParserTest >> testMathBlock [

	| source root math |
	source := MathOpeningBlockMarkup , String cr, 
	 '\mathcal{F} = \{ I \subseteq B | support(I) \geq minsup \}', String cr,
	MathClosingBlockMarkup, String cr.

	root :=  parser parse: source.
	self assert: root children size equals: 1.
	math := root children first. 
	self assert: (math isKindOf: MicMathBlock). 
	self assert: math body equals: '\mathcal{F} = \{ I \subseteq B | support(I) \geq minsup \}'
	
]

{ #category : 'tests - math' }
MicrodownParserTest >> testMathBlockOnMulitpleLines [

	| source root math |
	source := MathOpeningBlockMarkup , String cr, 
	 '\mathcal{F} = \{ I \subseteq B |', String cr, 'support(I) \geq minsup \}', String cr,
	MathClosingBlockMarkup, String cr.

	root :=  parser parse: source.
	self assert: root children size equals: 1.
	math := root children first. 
	self assert: (math isKindOf: MicMathBlock). 
	self assert: math body equals: '\mathcal{F} = \{ I \subseteq B |
support(I) \geq minsup \}'
	
]

{ #category : 'tests - math' }
MicrodownParserTest >> testMathBlockWithArguments [

	| source root math |
	source := MathOpeningBlockMarkup
	          , 'anchor=equation&caption=doNiceMath' , String cr
	          ,
	          '\mathcal{F} = \{ I \subseteq B | support(I) \geq minsup \}'
	          , String cr , MathClosingBlockMarkup , String cr.

	root := parser parse: source.
	self assert: root children size equals: 1.
	math := root children first.
	self assert: math anchor equals: 'equation'.
	self
		assert: (math arguments at: 'caption') first bodyString
		equals: 'doNiceMath'
]

{ #category : 'tests - path' }
MicrodownParserTest >> testParseEmpty [

	| file system mic |
	system := FileSystem memory workingDirectory.
	file := system / 'test.md'.
	(system / 'folder') createDirectory.
	file := system / 'folder/file.md'.
	file writeStreamDo: [ :stream | stream nextPutAll: '' ].
	mic := parser parse: file asFileReference contents.
	self assert: mic children isEmpty. 
	self assert: (mic isKindOf: MicRootBlock)
]

{ #category : 'tests - horizontal line' }
MicrodownParserTest >> testParseLineWithOneCharacter [ 
	
	| document |
	document := parser parse: '
a'.
	self assert: document children size equals: 1. 
	self assert: document children first class equals: MicParagraphBlock. 
	
]

{ #category : 'tests - horizontal line' }
MicrodownParserTest >> testParseLineWithThreeCharacters [ 
	
	| document |
	document := parser parse: '
a`a'.
	self assert: document children size equals: 1. 
	self assert: document children first class equals: MicParagraphBlock. 
	
]

{ #category : 'tests - horizontal line' }
MicrodownParserTest >> testParseLineWithTwoCharacters [ 
	
	| document |
	document := parser parse: '
aa'.
	self assert: document children size equals: 1. 
	self assert: document children first class equals: MicParagraphBlock. 
	
]

{ #category : 'tests' }
MicrodownParserTest >> testParseText [
	
	| mic |
	mic := parser parse: 'this is a paragraph
```
this is a code block
```'  asText.
	self assert: mic children size equals: 2.
	self assert: mic children first class equals: MicParagraphBlock.
	self assert: mic children first text equals: 'this is a paragraph'.
	self assert: mic children second class equals: MicCodeBlock.
	self assert: mic children second body equals: 'this is a code block'
]

{ #category : 'tests - table' }
MicrodownParserTest >> testPipeEscape [

	| tableBlock firstElementOfSecondRowAsString |
	tableBlock := (parser parse: '
|foo|bar|
|12\|3|456|') children first.
	"Extract the text node"
	firstElementOfSecondRowAsString := tableBlock rows second first.
	"now get to the actual string stored there"
	firstElementOfSecondRowAsString := firstElementOfSecondRowAsString
		                                   first bodyString.
	self assert: firstElementOfSecondRowAsString equals: '12|3'
]

{ #category : 'tests - breaking class comments' }
MicrodownParserTest >> testRBPatternVariableNode [
	| paragraph1 paragraph2 paragraph3 |
	
	paragraph1 := parser parse: 'The @ character can be combined with the name to match lists of items. If combined with the . character, then it will match a list of statement nodes (0 or more). If used without the . or # character, then it matches anything except for a list of statements. Combining the @ with the # is not supported.'.
	
	paragraph2 :=  parser parse: 'Adding another ` in the name will cause the search/replace to look for more matches inside the node that this node matched. This option should not be used for top-level expressions since that would cause infinite recursion (e.g., searching only for "``@anything").
'.
	paragraph3 := parser parse: 'Instance Variables:
	isAnything	<Boolean>	can we match any type of node
	isList	<Boolean>	can we match a list of items (@)
	isLiteral	<Boolean>	only match a literal node (#)
	isStatement	<Boolean>	only match statements (.)
	recurseInto	<Boolean>	search for more matches in the node we match (`)

'
]

{ #category : 'tests - table' }
MicrodownParserTest >> testSimpleTable [

	| mic |
	mic := (parser parse: '

| aaab | jkhjh |
| --- | --- |
| bar | rab |

') children first.
	self assert: mic class equals: MicTableBlock.
	self assert: mic rows size equals: 2.
	self assert: mic rows first size equals: 2.
	self assert: mic rows first first first class equals: MicTextBlock
]

{ #category : 'tests - error' }
MicrodownParserTest >> testSimpleTableNoError [
	"Microdown allows jagged tables - as implemented in MicTableBlock>>closeMe"
	self shouldnt: [ parser parse: '

| aaab | jkhjh |
| --- |
| bar |

'
	] raise: Error
	
]

{ #category : 'tests - table' }
MicrodownParserTest >> testSimpleTableWithFormatting [

	| mic |
	mic := (parser parse: '

| **aaab** | jkhjh |
| --- | --- |
| bar | rab |

') children first.
	self assert: mic class equals: MicTableBlock.
	self assert: mic rows size equals: 2.
	self assert: mic rows first size equals: 2.
	self assert: mic rows first first first class equals: MicBoldFormatBlock
]

{ #category : 'tests - table' }
MicrodownParserTest >> testSimpleTableWithFormattingWithSomeElements [

	| mic |
	mic := (parser parse: '

| **aaab** bbbc _cccd_| jkhjh |
| --- | --- |
| bar | rab |

') children first.
	self assert: mic class equals: MicTableBlock.
	self assert: mic rows size equals: 2.
	self assert: mic rows first size equals: 2.
	self
		assert: mic rows first first first class
		equals: MicBoldFormatBlock.
	self assert: mic rows first first second class equals: MicTextBlock.
	self
		assert: mic rows first first third class
		equals: MicItalicFormatBlock
]

{ #category : 'tests - table' }
MicrodownParserTest >> testSimpleTableWithMoreLongRow [

	| mic |
	mic := (parser parse: '

| aaab | jkhjh |
| --- | --- |
| bar | rab | long |

') children first.
	self assert: mic class equals: MicTableBlock.
	self assert: mic rows size equals: 2.
	self assert: mic rows first size equals: 2.
	self assert: mic rows first first first class equals: MicTextBlock
]

{ #category : 'tests - table' }
MicrodownParserTest >> testSimpleTableWithShortRow [

	| mic |
	mic := (parser parse: '

| aaab | jkhjh |
| --- | --- |
| bar |

') children first.
	self assert: mic class equals: MicTableBlock.
	self assert: mic rows size equals: 2.
	self assert: mic rows first size equals: 2.
	self assert: mic rows first first first class equals: MicTextBlock
]

{ #category : 'tests - comments' }
MicrodownParserTest >> testTwoCommentBlock [
	| source root |
	source := '% test1
% test 2'.
	root := parser parse: source.

	self assert: root children first class equals: MicCommentBlock.
	self assert: root children first text equals: 'test1
test 2'
]
