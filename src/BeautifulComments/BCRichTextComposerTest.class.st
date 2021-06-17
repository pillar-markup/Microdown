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

{ #category : #'tests - format' }
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

{ #category : #'tests - header' }
BCRichTextComposerTest >> headerLevel1 [

	^ self composerClass headerLevelFont: 1
]

{ #category : #'tests - header' }
BCRichTextComposerTest >> headerLevel2 [

	^ self composerClass headerLevelFont: 2
]

{ #category : #'tests - header' }
BCRichTextComposerTest >> headerLevel3 [

	^ self composerClass headerLevelFont: 3
]

{ #category : #'tests - header' }
BCRichTextComposerTest >> headerLevel4 [

	^ self composerClass headerLevelFont: 4
]

{ #category : #'tests - header' }
BCRichTextComposerTest >> headerLevel5 [

	^ self composerClass headerLevelFont: 5
]

{ #category : #'tests - header' }
BCRichTextComposerTest >> headerLevel6 [

	^ self composerClass headerLevelFont: 6
]

{ #category : #'tests - format' }
BCRichTextComposerTest >> italicFormat [
	^ TextEmphasis italic
]

{ #category : #'tests - header' }
BCRichTextComposerTest >> microElementsFrom: aString [
	^ sample documentFrom: aString.
	
]

{ #category : #'tests - format' }
BCRichTextComposerTest >> monospaceFormat [
	^ TextBackgroundColor color: Smalltalk ui theme settings windowColor
]

{ #category : #'tests - format' }
BCRichTextComposerTest >> normalFormat [
	^ TextEmphasis normal
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

{ #category : #'tests - format' }
BCRichTextComposerTest >> superscriptFormat [
	^ TextColor blue
]

{ #category : #'tests - format' }
BCRichTextComposerTest >> testBoldFormat [

	self assertWriting: (self microElementsFrom: sample boldFormatSample) include: self boldFormat
]

{ #category : #'tests - codeBlock' }
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

{ #category : #'tests - header' }
BCRichTextComposerTest >> testHeaderLevel1 [

	self 
		assertWriting: (self microElementsFrom: sample headerLevel1Sample) 
		include: self headerLevel1
]

{ #category : #'tests - header' }
BCRichTextComposerTest >> testHeaderLevel2 [

	self 
		assertWriting: (self microElementsFrom: sample headerLevel2Sample) 
		include: self headerLevel2
]

{ #category : #'tests - header' }
BCRichTextComposerTest >> testHeaderLevel3 [

	self 
		assertWriting: (self microElementsFrom: sample headerLevel3Sample) 
		include: self headerLevel3
]

{ #category : #'tests - header' }
BCRichTextComposerTest >> testHeaderLevel4 [

	self 
		assertWriting: (self microElementsFrom: sample headerLevel4Sample) 
		include: self headerLevel4
]

{ #category : #'tests - header' }
BCRichTextComposerTest >> testHeaderLevel5 [

	self 
		assertWriting: (self microElementsFrom: sample headerLevel5Sample) 
		include: self headerLevel5
]

{ #category : #'tests - header' }
BCRichTextComposerTest >> testHeaderLevel6 [

	self 
		assertWriting: (self microElementsFrom: sample headerLevel6Sample) 
		include: self headerLevel6
]

{ #category : #'tests - format' }
BCRichTextComposerTest >> testItalicFormat [
	self assertWriting: (self microElementsFrom: sample italicFormatSample) include: self italicFormat

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

{ #category : #'tests - list' }
BCRichTextComposerTest >> testNestedUnorderedListAreCorrectlyNumbered [
	| elts list |
	elts := (self microElementsFrom: '1. unordered1
1. subunordered1
2. subunordered2
3. subunordered3
4. unordered2').
	BCRichTextComposer new visit: elts. 
	self assert: elts children size equals: 1.
	self assert: elts children first class equals: MicOrderedListBlock.
	list := elts children first.
	self assert: list children size equals: 5.
	self assert: (list children second propertyAt: #counter) equals: '2.'
	
]

{ #category : #'tests - list' }
BCRichTextComposerTest >> testOrderedList [ 
	| runs string elts |
	elts := (self microElementsFrom: '1. First item
2. Second item
   on two lines
3. Third item').
	runs := self runsOf: elts.
	string := self stringOf: elts.
	self assert: runs first first class equals: TextIndent.
	self assert: runs first first amount equals: 1.
	self assert: runs runs equals: #(3 10 1 3 24 1 3 10 1).
	self assert: string first equals: $1.
	self assert: (string at: 12) equals: $e.
]

{ #category : #'tests - paragraph' }
BCRichTextComposerTest >> testParagraphNotFormat [
	| runs richText |
	richText := self richTextFor: (self microElementsFrom: '
foo
barwith a space').
	"
a Text for '
foo
barwith a space

'
"
	runs := richText runs.
	self assertEmpty: runs first.

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

{ #category : #'tests - format' }
BCRichTextComposerTest >> testTextFormat [
	self flag: #tofix.
	self skip.
	self 
		assertWriting: (self microElementsFrom: 'Hello Pharo') 
		include: self normalFormat
]

{ #category : #'tests - list' }
BCRichTextComposerTest >> testUnorderedList [ 
	| runs string elts |
	elts := (self microElementsFrom: '- First item
- Second item
   on two lines
- Third item').
	runs := self runsOf: elts.
	string := self stringOf: elts.
	self assert: runs first first class equals: TextIndent.
	self assert: runs first first amount equals: 1.
	self assert: runs runs equals: #(2 10 1 2 25 1 2 10 1)
]

{ #category : #'tests - format' }
BCRichTextComposerTest >> underlineFormat [
	^ TextEmphasis underlined
]
