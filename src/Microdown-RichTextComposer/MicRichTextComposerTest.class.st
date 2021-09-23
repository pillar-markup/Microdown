Class {
	#name : #MicRichTextComposerTest,
	#superclass : #TestCase,
	#instVars : [
		'sample',
		'parser'
	],
	#category : #'Microdown-RichTextComposer'
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
MicRichTextComposerTest >> richTextForString: aString [

	^ self composerClass microdownAsRichText: aString
]

{ #category : #helpers }
MicRichTextComposerTest >> runsOf: aDocument [
	
	^ (self richTextFor: aDocument) runs
]

{ #category : #running }
MicRichTextComposerTest >> setUp [
	super setUp.
	sample := MicMicrodownSnippetFactory new.
	parser := MicroDownParser new.
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
	| source runs richText |
	source := '
```arguments
line 1
line 2
```
'.
	richText := self richTextForString: source.
	runs := (richText runs collect: [:run | run collect: [:a| a class]]) asArray .	
	
	self assert: runs first isEmpty. 
	self assert: (runs second includes: TextIndent).
	self assert: richText asString equals: '
line 1
line 2
'
]

{ #category : #'tests - codeBlock' }
MicRichTextComposerTest >> testCodeBlockWithCaption [ 
	| source runs richText |
	source := '
```caption=Roger Rabbit
line 1
line 2
```
'.
	richText := self richTextForString: source.
	runs := (richText runs ) asArray .	
	
	self assert: runs first isEmpty. 
	self assert: (runs second anySatisfy: [ :r | r class = TextIndent]).
	self assert: ((runs at: 10) includes: self boldFormat ).
	self assert: richText asString equals: '
Roger Rabbit
line 1
line 2
'
]

{ #category : #'skipped tests' }
MicRichTextComposerTest >> testExternaLink [

	| source richText obj1  |
	source := 'See [my anchor](https://pharo.org)'.
	richText := MicRichTextComposer microdownAsRichText: source.

	obj1 := (richText runs at: 10) first. "element 10 is the 'n' in anchor"
	self assert: obj1 class name equals: #TextAction
]

{ #category : #'skipped tests' }
MicRichTextComposerTest >> testFigure [

	| source richText obj1  |
	self skip. "Currently getting an error in MicHTTPRessource"
	
	source := 'See ![no image found](https://pharo.org/web/files/pharo.png)'.
	richText := MicRichTextComposer microdownAsRichText: source.

	obj1 := (richText runs at: 10) first. "element 10 is the 'n' in anchor"
	self assert: obj1 class name equals: #TextAction
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

{ #category : #'skipped tests' }
MicRichTextComposerTest >> testItalicFormat [ 
	| source runs richText |
	source := 'This have been _emphasized_'.
	richText := self richTextForString: source.
	runs := (richText runs ) asArray .
	
	self assert: runs first isEmpty. 
	self assert: ((runs at: 19 "the p in emphasized") includes: self italicFormat ).
	self deny: ((runs at: 6 "the h in have") includes: self italicFormat  ).
]

{ #category : #'tests - list' }
MicRichTextComposerTest >> testListAreCorrectlyNumbered [
	| source richText |
	source :=
'1. item 1
1. other item 1
2. item 2
3. item 3
4. item 4'.
	richText := self richTextForString: source. 
	self assert: (richText asString copyFrom: 11 to: 25) equals: '2.	other item 1'.
	self assert: (richText asString copyFrom: 47 to: 55) equals: '5.	item 4'.
	
]

{ #category : #'skipped tests' }
MicRichTextComposerTest >> testNestedList [
	| source richText runs|
	source := 
'- item 1
  1. sub item 1.1
- item 2
  2. sub item 2.1
  2. sub item 2.2
- item 3'.
	richText := self richTextForString: source.
	runs := richText runs.
	
	"check that 'sub item 2.1' is numbered 'A)' and is rightly indented"
	self assert: (richText asString copyFrom: 35 to: 36) equals: 'A)'.
	self assert: (runs at: 35) first amount equals: 3
	
]

{ #category : #'tests - list' }
MicRichTextComposerTest >> testNewDictionaryAPI [
	
	| dict |
	dict := Dictionary newFromAssociations: { #a -> 1  . #b -> 2 }.
	self assert: (dict at: #a) equals: 1
]

{ #category : #'tests - list' }
MicRichTextComposerTest >> testOrderedList [ 
	| source richText runs  |
	source := '1. First item
2. Second item
   on two lines
3. Third item'.
	richText := self richTextForString: source.
	runs := richText runs .
	
	self assert: runs first first class equals: TextIndent.
	self assert: runs first first amount equals: 1.
	self assert: (runs at: 30) "the first o in 'on two lines'" first class equals: TextIndent.
	self assert: (runs at: 30) first amount equals: 2.
	
]

{ #category : #'tests - paragraph' }
MicRichTextComposerTest >> testParagraphNotFormat [
	| runs richText |
	richText := self richTextFor: (self microElementsFrom: '
foo
barwith a space').
	runs := richText runs.
	self assert: (runs allSatisfy: [ :format | format = #() ] )

]

{ #category : #'skipped tests' }
MicRichTextComposerTest >> testStrikethroughFormat [ 
	| source runs richText |
	source := 'This have been ~deleted~'.
	richText := self richTextForString: source.
	runs := (richText runs ) asArray .
	
	self assert: runs first isEmpty. 
	self assert: ((runs at: 19 "the l in deleted") includes: self strikethroughtFormat ).
	self deny: ((runs at: 6 "the h in have") includes: self strikethroughtFormat ).
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
	self assert: defaultStyler selector equals: #textStyler:.
	 "Stylers are used for codeblock, and a test should be included for this"
]

{ #category : #'skipped tests' }
MicRichTextComposerTest >> testSubscriptFormat [
	"Test fails: subscript isn't recognized"
	
	self assert: true.
	
]

{ #category : #'tests - list' }
MicRichTextComposerTest >> testUnorderedList [ 
	| source richText runs  |
	source :=  '- First item
- Second item
   on two lines
- Third item'.
	richText := self richTextForString: source.
	runs := richText runs.
	self assert: runs first first class equals: TextIndent.
	self assert: runs first first amount equals: 1.
	self assert: (runs at: 29) "the first o in 'on two lines'" first class equals: TextIndent.
	self assert: (runs at: 29) first amount equals: 2.
]

{ #category : #'tests - format' }
MicRichTextComposerTest >> underlineFormat [
	^ TextEmphasis underlined
]
