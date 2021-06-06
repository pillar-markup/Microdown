Class {
	#name : #BCRichTextComposerTest,
	#superclass : #TestCase,
	#instVars : [
		'sample',
		'parser'
	],
	#category : #BeautifulComments
}

{ #category : #helpers }
BCRichTextComposerTest >> assertWriting: aPRDocument include: expectedAttribute [
	self assert: ((self runsOf: aPRDocument) includes: {expectedAttribute})
]

{ #category : #'tests - Format' }
BCRichTextComposerTest >> boldFormat [
	^ TextEmphasis bold
]

{ #category : #helpers }
BCRichTextComposerTest >> composer [
	^ self composerClass new
]

{ #category : #helpers }
BCRichTextComposerTest >> composerClass [
	^ BCRichTextComposer
]

{ #category : #'skipped tests' }
BCRichTextComposerTest >> externalLink: aLink [
	^ TextAction new actOnClickBlock: [WebBrowser openOn: aLink]
]

{ #category : #'skipped tests' }
BCRichTextComposerTest >> figure: aFigureLink [
	| url |
	url := aFigureLink.
	^ TextAnchor new anchoredMorph: (ZnEasy getPng: url)
]

{ #category : #'tests - Header' }
BCRichTextComposerTest >> headerLevel1 [

	^ self composerClass headerLevelFont: 1
]

{ #category : #'tests - Header' }
BCRichTextComposerTest >> headerLevel2 [

	^ self composerClass headerLevelFont: 2
]

{ #category : #'tests - Header' }
BCRichTextComposerTest >> headerLevel3 [

	^ self composerClass headerLevelFont: 3
]

{ #category : #'tests - Header' }
BCRichTextComposerTest >> headerLevel4 [

	^ self composerClass headerLevelFont: 4
]

{ #category : #'tests - Header' }
BCRichTextComposerTest >> headerLevel5 [

	^ self composerClass headerLevelFont: 5
]

{ #category : #'tests - Header' }
BCRichTextComposerTest >> headerLevel6 [

	^ self composerClass headerLevelFont: 6
]

{ #category : #'tests - Format' }
BCRichTextComposerTest >> italicFormat [
	^ TextEmphasis italic
]

{ #category : #'tests - Header' }
BCRichTextComposerTest >> microElementsFrom: aString [
	^ sample documentFrom: aString.
	
]

{ #category : #'tests - Format' }
BCRichTextComposerTest >> monospaceFormat [
	^ TextBackgroundColor color: Smalltalk ui theme settings windowColor
]

{ #category : #helpers }
BCRichTextComposerTest >> richTextFor: aDocument [

	^ self composer visit: aDocument
]

{ #category : #helpers }
BCRichTextComposerTest >> runsOf: aDocument [
	
	^ (self richTextFor: aDocument) runs
]

{ #category : #running }
BCRichTextComposerTest >> setUp [
	super setUp.
	sample := MicMicrodownSnippetFactory new.
	parser := MicroDownParser new.
]

{ #category : #'skipped tests' }
BCRichTextComposerTest >> strikethroughtFormat [
	^ TextEmphasis struckOut
]

{ #category : #helpers }
BCRichTextComposerTest >> stringOf: aPRDocument [
	
	^ (self richTextFor: aPRDocument) string
]

{ #category : #'skipped tests' }
BCRichTextComposerTest >> subscriptFormat [
	^ TextColor red
]

{ #category : #'tests - Format' }
BCRichTextComposerTest >> superscriptFormat [
	^ TextColor blue
]

{ #category : #'tests - Format' }
BCRichTextComposerTest >> testBoldFormat [

	self assertWriting: sample bold include: self boldFormat
]

{ #category : #'tests - CodeBlock' }
BCRichTextComposerTest >> testCodeBlock [
	| runs richText |
	self skip.
	richText := self richTextFor: sample codeblock.

"
'1 + 2 
	* 3  '
"	
	runs := richText runs.	
	
	"self assert: runs first isEmpty. 
	self assert: runs second first class equals: TextIndent.
	self assert: runs second first amount equals: 1.
	self assert: runs runs equals:  #(1 3 1 15 1 1).
	"
	self assert: richText string equals: '1 + 2 
	* 3  

'
]

{ #category : #'skipped tests' }
BCRichTextComposerTest >> testExternaLink [

	| pillarLink target obj1 obj2 raised |
	self skip.
	raised := false.
	[ 
	pillarLink := '*SitePharo>https://get.pharo.org/64/*'.
	target := 'https://get.pharo.org/64/'.

	obj1 := ((self composerClass asText: pillarLink) runs at: 1) first.
	obj2 := self externalLink: target ]
		on: Error
		do: [ raised := true ].
	self deny: raised.
	self assert: obj1 class equals: obj2 class.
	self assert: obj1 class name equals: #TextAction
]

{ #category : #'skipped tests' }
BCRichTextComposerTest >> testFigure [

	| link pillarLink obj1 obj2 raised |
	self skip.
	raised := false.
	[ 
	pillarLink := '+Pharologo>https://files.pharo.org/media/logo/logo.png+'.
	link := 'https://files.pharo.org/media/logo/logo.png'.

	obj1 := ((self composerClass asText: pillarLink) runs at: 1) first.
	obj2 := self figure: link ]
		on: Error
		do: [ raised := true ].
	self deny: raised.
	self assert: obj1 class equals: obj2 class.
	self assert: obj1 class name equals: #TextAnchor
]

{ #category : #'tests - Header' }
BCRichTextComposerTest >> testHeaderLevel1 [

	self 
		assertWriting: (self microElementsFrom: sample headerLevel1Sample) 
		include: self headerLevel1
]

{ #category : #'tests - Header' }
BCRichTextComposerTest >> testHeaderLevel2 [

	self 
		assertWriting: (self microElementsFrom: sample headerLevel2Sample) 
		include: self headerLevel2
]

{ #category : #'tests - Header' }
BCRichTextComposerTest >> testHeaderLevel3 [

	self 
		assertWriting: (self microElementsFrom: sample headerLevel3Sample) 
		include: self headerLevel3
]

{ #category : #'tests - Header' }
BCRichTextComposerTest >> testHeaderLevel4 [

	self 
		assertWriting: (self microElementsFrom: sample headerLevel4Sample) 
		include: self headerLevel4
]

{ #category : #'tests - Header' }
BCRichTextComposerTest >> testHeaderLevel5 [

	self 
		assertWriting: (self microElementsFrom: sample headerLevel5Sample) 
		include: self headerLevel5
]

{ #category : #'tests - Header' }
BCRichTextComposerTest >> testHeaderLevel6 [

	self 
		assertWriting: (self microElementsFrom: sample headerLevel6Sample) 
		include: self headerLevel6
]

{ #category : #'tests - Format' }
BCRichTextComposerTest >> testItalicFormat [
	self assertWriting: sample italic include: self italicFormat
]

{ #category : #'tests - Format' }
BCRichTextComposerTest >> testMonospaceFormat [ 
	self skip. 
	self assertWriting: sample monospace include: self monospaceFormat
]

{ #category : #'skipped tests' }
BCRichTextComposerTest >> testNestedList [
	| runs string |
	self skip.
	runs := self runsOf: sample nestedList.
	string := self stringOf: sample nestedList.
	self assert: string first equals: $1.
	self assert: runs first first class equals: TextIndent.
	self assert: runs first first amount equals: 1.
	self assert: (string at: 12) equals: $-.
	self assert: (runs at: 12) first class equals: TextIndent.
	self assert: (runs at: 12) first amount equals: 2.
	self assert: (string at: 21) equals: $-.
	self assert: (runs at: 21) first class equals: TextIndent.
	self assert: (runs at: 21) first amount equals: 2.
	self assert: (string at: 30) equals: $2.
	self assert: (runs at: 30) first class equals: TextIndent.
	self assert: (runs at: 30) first amount equals: 1.
	self assert: runs runs equals: #(3 7 1 2 6 1 2 6 1 3 7 1) asArray.
	
]

{ #category : #'tests - List' }
BCRichTextComposerTest >> testOrderedList [ 
	| runs string |
	runs := self runsOf: sample orderedList.
	string := self stringOf: sample orderedList.
	self assert: runs first first class equals: TextIndent.
	self assert: runs first first amount equals: 1.
	self assert: runs runs equals: #(3 7 1 3 7 1) asArray.
	self assert: string first equals: $1.
	self assert: (string at: 12) equals: $2.
]

{ #category : #'tests - Preformatted' }
BCRichTextComposerTest >> testPreformatted [
	| runs richText |
	richText := self richTextFor: sample preformatted.
	"
a Text for '
foo
barwith a space

'
"
	runs := richText runs.
	self assertEmpty: runs first.
	self assert: runs second first class equals: TextIndent.
	self assert: runs second first amount equals: 1.
	self assert: runs runs equals: #(1 3 1 15 1 1).
	self assert: richText string first equals: Character cr.
	self assert: richText string second equals: $f
]

{ #category : #'skipped tests' }
BCRichTextComposerTest >> testStrikethroughFormat [ 
	"Test fails: strikethrough is recognized only if spaces surround text
	So this test fails:
		self assertWriting: factory strikethroughFormatSample include: self strikethroughtFormat.
	"
	
	self skip.
]

{ #category : #'tests - stylers' }
BCRichTextComposerTest >> testStylersAreRegistered [

	| defaultStyler |
	defaultStyler := self composerClass languageStylerFor: 'blblbl'.
	self assert: defaultStyler selector equals: #defaultStyler:
]

{ #category : #'tests - stylers' }
BCRichTextComposerTest >> testStylersForText [

	| defaultStyler |
	defaultStyler := self composerClass languageStylerFor: 'text'.
	self assert: defaultStyler selector equals: #textStyler:
]

{ #category : #'skipped tests' }
BCRichTextComposerTest >> testSubscriptFormat [
	"Test fails: subscript isn't recognized
	
	self assertWriting: factory subscriptFormatSample include: self subscriptFormat"
	
	self skip.
	
]

{ #category : #'tests - List' }
BCRichTextComposerTest >> testUnorderedList [ 
	| runs |
	runs := self runsOf: sample unorderedList.
	self assert: runs first first class equals: TextIndent.
	self assert: runs first first amount equals: 1.
	self assert: runs runs equals: #(2 6 1 2 6 1) asArray.
]

{ #category : #'tests - Format' }
BCRichTextComposerTest >> underlineFormat [
	^ TextEmphasis underlined
]
