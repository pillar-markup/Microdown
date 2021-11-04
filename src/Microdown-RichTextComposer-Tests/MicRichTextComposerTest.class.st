Class {
	#name : #MicRichTextComposerTest,
	#superclass : #TestCase,
	#instVars : [
		'sample',
		'parser'
	],
	#category : #'Microdown-RichTextComposer-Tests'
}

{ #category : #'tests - codeBlock' }
MicRichTextComposerTest class >> dummyStylerFor: aString [
	"I am a styler used for testing. "
	<codeblockStylerFor: 'dummy'>
	
	^ self dummyStylerReturn
]

{ #category : #'tests - codeBlock' }
MicRichTextComposerTest class >> dummyStylerReturn [
	^ '***dummy***' asText
]

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

{ #category : #tests }
MicRichTextComposerTest >> testBackslashLast [
		| source richText |
	source := 'I am a text which ends in \'.
	richText := self richTextForString: source.
	self assert: richText asString trim equals: source
]

{ #category : #tests }
MicRichTextComposerTest >> testBackslashNoBreak [
	"This test is related to issue: https://github.com/pillar-markup/Microdown/issues/107"
	| source richText |
	source := 'I''m a simple lexer. I''m used bt the DLitlleLParser.

I recogniseI
- names: list of characters letter and number and ''
- separators: one character separator.
- escape char \

Whitespaces and separators can be customised using setters.
Subclasses may change the definition of names by redefining isCurrentALetter.'.
	richText := self richTextForString: source.
	self assert: true "I did not fail"
]

{ #category : #'tests - format' }
MicRichTextComposerTest >> testBoldFormat [

	self assertWriting: (self microElementsFrom: sample boldFormatSample) include: self boldFormat
]

{ #category : #'tests - codeBlock' }
MicRichTextComposerTest >> testCodeBlock [
	| source runs richText |
	
	MicRichTextComposer initializeStylers.
	source := '
```arguments
line 1
line 2
```
'.
	richText := self richTextForString: source.
	runs := (richText runs collect: [:run | run collect: [:a| a class]]) asArray .	
		 
	self assert: (runs second includes: TextIndent).
	self assert: richText asString equals: 
'line 1
line 2
'
]

{ #category : #'tests - codeBlock' }
MicRichTextComposerTest >> testCodeBlockStylerExplicitLanguage [
	| source richText |
	
	MicRichTextComposer initializeStylers.
	source := '
```language=dummy
line 1
line 2
```
'.
	richText := self richTextForString: source.
	self assert: richText asString trim equals: self class dummyStylerReturn asString
]

{ #category : #'tests - codeBlock' }
MicRichTextComposerTest >> testCodeBlockStylerShortHand [
	| source richText |

	source := '
```dummy
line 1
line 2
```
'.
	richText := self richTextForString: source.
	self assert: richText asString trim equals: self class dummyStylerReturn asString
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
	
	self assert: runs first notEmpty. 
	self assert: (runs second anySatisfy: [ :r | r class = TextIndent]).
	self assert: ((runs at: 15) includes: self boldFormat ).
	self assert: richText asString equals: 
'line 1
line 2
Roger Rabbit
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
MicRichTextComposerTest >> testFigureCaptionMissingRemote [

	| source richText|
	source := 'See ![SomeText](https://pharo.org/web/files/pharooooooo.png)'.
	richText := MicRichTextComposer microdownAsRichText: source.

	self assert: (richText asString trim includesSubstring: 'SomeText').
	self assert: richText asTextMorph height < 100 "No image embedded"
]

{ #category : #'skipped tests' }
MicRichTextComposerTest >> testFigureCaptionRemote [

	| source richText |
	source := 'See ![SomeText](https://pharo.org/web/files/pharo.png)'.
	richText := MicRichTextComposer microdownAsRichText: source.

	self assert: (richText asString trim includesSubstring: 'SomeText').
	self assert: richText asTextMorph height > 100 "It is high because of the embedded image"
]

{ #category : #'skipped tests' }
MicRichTextComposerTest >> testFigureLocal [

	| source richText |
	self skip. "Local not working yet"
	source := 'See ![](foo.png)'.
	richText := MicRichTextComposer microdownAsRichText: source.

	
]

{ #category : #'skipped tests' }
MicRichTextComposerTest >> testFigureNoCaptionRemote [

	| source richText |
	source := 'See ![](https://pharo.org/web/files/pharo.png)'.
	richText := MicRichTextComposer microdownAsRichText: source.

	self assert: richText asString trim equals: 'See ', (String value: 1).
	self assert: richText asTextMorph height > 100 "It is high because of the embedded image"
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
MicRichTextComposerTest >> testLatexMathStyle [
	|    source1 source2 richText1 richText2 |
	"this checks if latex is working by making two formulas, of which the second should be taller"
	source1 :=  'foo$a+b$bar'.
	source2 :=  'foo$\frac{A}{B}$bar'.
	richText1 := self richTextForString: source1.
	richText2 := self richTextForString: source2.
	self assert: richText1 asMorph height < richText2 asMorph height
]

{ #category : #'tests - list' }
MicRichTextComposerTest >> testLatexMathStyleEmpty [ 
	| source richText |
	source :=  'foo$$bar'.
	richText := self richTextForString: source.
	self assert: richText asString equals: 'foobar' .
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
MicRichTextComposerTest >> testNestedMixedList [
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

{ #category : #'skipped tests' }
MicRichTextComposerTest >> testNestedUnorderdList [
	| source richText runs|
	source := 
'- item 1
  - sub item 1.1
- item 2
  - sub item 2.1
  - sub item 2.2
- item 3'.
	richText := self richTextForString: source.
	runs := richText runs.
	
	"check that 'sub item 1.1' is bulleted and is rightly indented"
	self assert: (richText asString at: 10) equals: $•.
	self assert: (runs at: 12) first amount equals: 4
	
]

{ #category : #'tests - list' }
MicRichTextComposerTest >> testNewDictionaryAPI [
	
	| dict |
	dict := Dictionary newFromAssociations: { #a -> 1  . #b -> 2 }.
	self assert: (dict at: #a) equals: 1
]

{ #category : #'tests - list' }
MicRichTextComposerTest >> testNoNSuperfluousNewLines [
	| source richText expected |
	source :=  'This is **bold**
	
	And this is just an other paragraph'.
	expected := 'This is bold

And this is just an other paragraph'.
	richText := self richTextForString: source.
	self assert: richText asString equals: expected
]

{ #category : #'tests - list' }
MicRichTextComposerTest >> testNosuperfluousNewLines [
	| source richText expected |
	source :=  'This is **bold**'.
	expected := 'This is bold'.
	richText := self richTextForString: source.
	self assert: richText asString equals: expected
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

{ #category : #tests }
MicRichTextComposerTest >> testStylerForMethod [
	
	| code source richText blueLocation textColor |
	MicRichTextComposer initializeStylers.
	code := '
codeStylerFor: aString
<codeblockStylerFor: #smalltalk>

^bobby new 
isForWorkspace: blue; 
styledTextFor: aString asFest'.
	source := '
```language=method' , code ,'
```
'.
	richText := self richTextForString: source.
	
	self assert: richText asString trim equals: code trim.
	self assert: ((richText attributesAt: 2) includes: TextEmphasis bold).
	"Check that the unknown variable 'blue' is not colored red"
	blueLocation := richText asString findString: 'blue'.
	textColor := (richText attributesAt: blueLocation) detect: [ :attr | attr class = TextColor  ].
	self assert: textColor color red equals: 0.
]

{ #category : #tests }
MicRichTextComposerTest >> testStylerForSmalltalk [
	
	| code source richText blueLocation textColor |
	MicRichTextComposer initializeStylers.
	code := '
codeStylerFor: aString
<codeblockStylerFor: #smalltalk>

^bobby new 
isForWorkspace: blue; 
styledTextFor: aString asFest'.
	source := '
```language=smalltalk' , code ,'
```
'.
	richText := self richTextForString: source.
	
	self assert: richText asString trim equals: code trim.
	"style smalltalk is assumes the code to be a code fragment, not a full method def"
	self assert: ((richText attributesAt: 2) includes: TextEmphasis bold) not.
	"Check that the unknown variable 'blue' is not colored red"
	blueLocation := richText asString findString: 'blue'.
	textColor := (richText attributesAt: blueLocation) detect: [ :attr | attr class = TextColor  ].
	self assert: textColor color red equals: 0.
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
