Class {
	#name : #MicRichTextComposerTest,
	#superclass : #TestCase,
	#instVars : [
		'sample',
		'parser'
	],
	#category : #'Microdown-MicrodownRichTextComposer'
}

{ #category : #helpers }
MicRichTextComposerTest >> assertWriting: aPRDocument include: expectedAttribute [
	self assert: ((self runsOf: aPRDocument) includes: {expectedAttribute})
]

{ #category : #'tests - format' }
MicRichTextComposerTest >> boldFormat [
	^ TextEmphasis bold
]

{ #category : #helpers }
MicRichTextComposerTest >> composer [
	^ self composerClass new
]

{ #category : #helpers }
MicRichTextComposerTest >> composerClass [
	^ MicRichTextComposer
]

{ #category : #'skipped tests' }
MicRichTextComposerTest >> externalLink: aLink [
	^ TextAction new actOnClickBlock: [WebBrowser openOn: aLink]
]

{ #category : #'skipped tests' }
MicRichTextComposerTest >> figure: aFigureLink [
	| url |
	url := aFigureLink.
	^ TextAnchor new anchoredMorph: (ZnEasy getPng: url)
]

{ #category : #'tests - header' }
MicRichTextComposerTest >> headerLevel1 [

	^ self composerClass headerLevelFont: 1
]

{ #category : #'tests - header' }
MicRichTextComposerTest >> headerLevel2 [

	^ self composerClass headerLevelFont: 2
]

{ #category : #'tests - header' }
MicRichTextComposerTest >> headerLevel3 [

	^ self composerClass headerLevelFont: 3
]

{ #category : #'tests - header' }
MicRichTextComposerTest >> headerLevel4 [

	^ self composerClass headerLevelFont: 4
]

{ #category : #'tests - header' }
MicRichTextComposerTest >> headerLevel5 [

	^ self composerClass headerLevelFont: 5
]

{ #category : #'tests - header' }
MicRichTextComposerTest >> headerLevel6 [

	^ self composerClass headerLevelFont: 6
]

{ #category : #'tests - format' }
MicRichTextComposerTest >> italicFormat [
	^ TextEmphasis italic
]

{ #category : #'tests - header' }
MicRichTextComposerTest >> microElementsFrom: aString [
	^ sample documentFrom: aString.
	
]

{ #category : #'tests - format' }
MicRichTextComposerTest >> monospaceFormat [
	^ TextBackgroundColor color: Smalltalk ui theme settings windowColor
]

{ #category : #'tests - format' }
MicRichTextComposerTest >> normalFormat [
	^ TextEmphasis normal
]

{ #category : #helpers }
MicRichTextComposerTest >> richTextFor: aDocument [

	^ self composer visit: aDocument
]

{ #category : #helpers }
MicRichTextComposerTest >> runsOf: aDocument [
	
	^ (self richTextFor: aDocument) runs
]

{ #category : #running }
MicRichTextComposerTest >> setUp [
	super setUp.
	sample := MicMicrodownSnippetFactory new.
	parser := MicrodownParser new.
]

{ #category : #'skipped tests' }
MicRichTextComposerTest >> strikethroughtFormat [
	^ TextEmphasis struckOut
]

{ #category : #helpers }
MicRichTextComposerTest >> stringOf: aPRDocument [
	
	^ (self richTextFor: aPRDocument) string
]

{ #category : #'skipped tests' }
MicRichTextComposerTest >> subscriptFormat [
	^ TextColor red
]

{ #category : #'tests - format' }
MicRichTextComposerTest >> superscriptFormat [
	^ TextColor blue
]

{ #category : #'tests - format' }
MicRichTextComposerTest >> testBoldFormat [

	self assertWriting: (self microElementsFrom: sample boldFormatSample) include: self boldFormat
]

{ #category : #'tests - codeBlock' }
MicRichTextComposerTest >> testCodeBlock [
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
MicRichTextComposerTest >> testExternaLink [

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
MicRichTextComposerTest >> testFigure [

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
MicRichTextComposerTest >> testHeaderLevel1 [

	self 
		assertWriting: (self microElementsFrom: sample headerLevel1Sample) 
		include: self headerLevel1
]

{ #category : #'tests - header' }
MicRichTextComposerTest >> testHeaderLevel2 [

	self 
		assertWriting: (self microElementsFrom: sample headerLevel2Sample) 
		include: self headerLevel2
]

{ #category : #'tests - header' }
MicRichTextComposerTest >> testHeaderLevel3 [

	self 
		assertWriting: (self microElementsFrom: sample headerLevel3Sample) 
		include: self headerLevel3
]

{ #category : #'tests - header' }
MicRichTextComposerTest >> testHeaderLevel4 [

	self 
		assertWriting: (self microElementsFrom: sample headerLevel4Sample) 
		include: self headerLevel4
]

{ #category : #'tests - header' }
MicRichTextComposerTest >> testHeaderLevel5 [

	self 
		assertWriting: (self microElementsFrom: sample headerLevel5Sample) 
		include: self headerLevel5
]

{ #category : #'tests - header' }
MicRichTextComposerTest >> testHeaderLevel6 [

	self 
		assertWriting: (self microElementsFrom: sample headerLevel6Sample) 
		include: self headerLevel6
]

{ #category : #'tests - format' }
MicRichTextComposerTest >> testItalicFormat [
	self assertWriting: (self microElementsFrom: sample italicFormatSample) include: self italicFormat

]

{ #category : #'skipped tests' }
MicRichTextComposerTest >> testNestedList [
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
MicRichTextComposerTest >> testNestedUnorderedListAreCorrectlyNumbered [
	| elts list |
	elts := (self microElementsFrom: '1. unordered1
1. subunordered1
2. subunordered2
3. subunordered3
4. unordered2').
	MicRichTextComposer new visit: elts. 
	self assert: elts children size equals: 1.
	self assert: elts children first class equals: MicOrderedListBlock.
	list := elts children first.
	self assert: list children size equals: 5.
	self assert: (list children second propertyAt: #counter) equals: '2.'
	
]

{ #category : #'tests - list' }
MicRichTextComposerTest >> testOrderedList [ 
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
MicRichTextComposerTest >> testParagraphNotFormat [
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
MicRichTextComposerTest >> testStrikethroughFormat [ 
	"Test fails: strikethrough is recognized only if spaces surround text
	So this test fails:
		self assertWriting: factory strikethroughFormatSample include: self strikethroughtFormat.
	"
	
	self skip.
]

{ #category : #'tests - stylers' }
MicRichTextComposerTest >> testStylersAreRegistered [

	| defaultStyler |
	defaultStyler := self composerClass languageStylerFor: 'blblbl'.
	self assert: defaultStyler selector equals: #defaultStyler:
]

{ #category : #'tests - stylers' }
MicRichTextComposerTest >> testStylersForText [

	| defaultStyler |
	defaultStyler := self composerClass languageStylerFor: 'text'.
	self assert: defaultStyler selector equals: #textStyler:
]

{ #category : #'skipped tests' }
MicRichTextComposerTest >> testSubscriptFormat [
	"Test fails: subscript isn't recognized
	
	self assertWriting: factory subscriptFormatSample include: self subscriptFormat"
	
	self skip.
	
]

{ #category : #'tests - format' }
MicRichTextComposerTest >> testTextFormat [
	self flag: #tofix.
	self skip.
	self 
		assertWriting: (self microElementsFrom: 'Hello Pharo') 
		include: self normalFormat
]

{ #category : #'tests - list' }
MicRichTextComposerTest >> testUnorderedList [ 
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
MicRichTextComposerTest >> underlineFormat [
	^ TextEmphasis underlined
]
