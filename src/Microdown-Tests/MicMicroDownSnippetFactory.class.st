"
Includes methods to obtain Microdown snippets of multiple document artifacts.

To quickly view a document including all the Microdown snippets, evaluate:

```
MicMicrodownSnippetFactory buildDocument.
```


Internal Representation and Key Implementation Points.

## Instance Variables

- parserClass:		<Microdown>


## Implementation Points

This class uses Microdown as parser, but it could be specialized to change the parser class rewriting the initialize method.
"
Class {
	#name : #MicMicrodownSnippetFactory,
	#superclass : #Object,
	#instVars : [
		'parserClass'
	],
	#pools : [
		'MicroSharedPool'
	],
	#category : #'Microdown-Tests-Snippets'
}

{ #category : #utilities }
MicMicrodownSnippetFactory class >> buildDocument [
	"Answer a <String> with a whole document made up from the receiver's methods containing Microdown samples"

	^ String streamContents: [ : stream | 
		| factory |
		factory := self new.
		(self protocols difference: { #initialization . #utilities })
			collect: [ : protoName | self organization listAtCategoryNamed: protoName ]
			thenDo: [ : protoCollection |
				protoCollection 
					select: #isUnary
					thenDo: [ : elementTypeSelector |
						stream 
							cr;
							<< (factory perform: elementTypeSelector) ] ] ]
]

{ #category : #anchor }
MicMicrodownSnippetFactory >> anchorAreTrimedSample [
	^ AnchorMarkup, '  test  '
]

{ #category : #anchor }
MicMicrodownSnippetFactory >> anchorReferenceSample [
	^ '*@Foo@*'
]

{ #category : #anchor }
MicMicrodownSnippetFactory >> anchorSample [
	^ AnchorMarkup, 'test'
]

{ #category : #anchor }
MicMicrodownSnippetFactory >> anchorWithNewLineSample [

	^ AnchorMarkup , 'foo' , self newLine
]

{ #category : #anchor }
MicMicrodownSnippetFactory >> anchorWithSpaceInsideSample [
	
	^ AnchorMarkup, 'foo bar'
]

{ #category : #anchor }
MicMicrodownSnippetFactory >> annotatedSample [
	^ '!!label 
Foo _bar_
'
]

{ #category : #annotations }
MicMicrodownSnippetFactory >> annotationSample [

	^ '
abc',  AnnotationOpenerMarkup , 'Foo | value=aFoo&label=42 ', AnnotationCloserMarkup ,'def
'
]

{ #category : #'code block' }
MicMicrodownSnippetFactory >> blockParameterWithLiteralArraySample [

	^ self codeblock: 'foo=#(1 2 true)'
]

{ #category : #'code block' }
MicMicrodownSnippetFactory >> blockSampleOnMultipleLines [

	^ self codeblockNoParamBody: 'first line 
second line
third line **b**'
]

{ #category : #'code block' }
MicMicrodownSnippetFactory >> blockWithLanguageSample [
	^ self codeblock: 'language=smalltalk' body: 'foo'
]

{ #category : #'code block' }
MicMicrodownSnippetFactory >> blockWithNewLineSample [

	^ (self codeblockNoParamBody: 'foo') , self newLine
]

{ #category : #'code block' }
MicMicrodownSnippetFactory >> blockWithParameterTrueByDefaultSample [
	^ self codeblock: 'foo' body: 'bar'
	
]

{ #category : #'code block' }
MicMicrodownSnippetFactory >> blockWithParameterWithFloatSample [
	^ self codeblock: 'ratio=0.8' body: 'bar'
	
]

{ #category : #'code block' }
MicMicrodownSnippetFactory >> blockWithParameterWithLiteralArraySample [
	^ self codeblock: 'foo=#(1 2 true)'
]

{ #category : #'code block' }
MicMicrodownSnippetFactory >> blockWithParameterWithNoValuesSample [
	^ self codeblock: 'foo=' body: 'bar'

]

{ #category : #'code block' }
MicMicrodownSnippetFactory >> blockWithParametersSample [
	^ self 
		codeblock:   'foo=true&bar=2'
		body: 'bla'
]

{ #category : #'code block' }
MicMicrodownSnippetFactory >> blockWithParametersWithCaptionSample [
	^ self 
		codeblock:   'caption=`Color` is beautifull&bar=2'
		body: 'bla'
]

{ #category : #'code block' }
MicMicrodownSnippetFactory >> blockWithSpaceAtTheEndSample [
		
	 ^ (self codeblockNoParamBody: 'foo'), '  '.


]

{ #category : #'code block' }
MicMicrodownSnippetFactory >> blockWithSpacedParametersSample [
	^ self 
		codeblock:   ' foo = true & bar = 2'
		body: 'bla'
]

{ #category : #format }
MicMicrodownSnippetFactory >> boldFormatEmptySample [
	^ self surround: '' withMarkup: BoldMarkup
]

{ #category : #format }
MicMicrodownSnippetFactory >> boldFormatSample [
	^ self surroundWithMarkup: BoldMarkup
]

{ #category : #'code block' }
MicMicrodownSnippetFactory >> codeBlockSample [
	^ '
```ab```
'
]

{ #category : #'code block' }
MicMicrodownSnippetFactory >> codeblock: param [ 

	^ String streamContents: [ :st | 
		st cr.
		st nextPutAll: CodeblockMarkup. 
		st nextPutAll: param.
		st cr.
		st nextPutAll: CodeblockMarkup. 
	]
]

{ #category : #'code block' }
MicMicrodownSnippetFactory >> codeblock: param body: body [
	
	^ String streamContents: [ :st | 
		st cr.
		st nextPutAll: CodeblockMarkup. 
		st nextPutAll: param.
		st cr.
		st nextPutAll: body.
		st cr.
		st nextPutAll: CodeblockMarkup. 
	]
]

{ #category : #'code block' }
MicMicrodownSnippetFactory >> codeblockNoParamBody: body [

	^ String streamContents: [ :st | 
		st cr.
		st nextPutAll: CodeblockMarkup. 
		st cr.
		st nextPutAll: body.
		st cr.
		st nextPutAll: CodeblockMarkup. 
	]
]

{ #category : #sample }
MicMicrodownSnippetFactory >> columnSample [
	^ EnvironmentOpeningBlockMarkup, 'column|width=42
	this is a **text**
',EnvironmentClosingBlockMarkup
]

{ #category : #sample }
MicMicrodownSnippetFactory >> columnsSample [
	^ EnvironmentOpeningBlockMarkup, 'columns|width=42
',EnvironmentClosingBlockMarkup
]

{ #category : #sample }
MicMicrodownSnippetFactory >> columnsWithChildrenSample [
	^ EnvironmentOpeningBlockMarkup,'columns|width=42
', self columnSample ,'
', self columnSample,'
',EnvironmentClosingBlockMarkup
]

{ #category : #block }
MicMicrodownSnippetFactory >> commentSample [
	^ '% Foo'
]

{ #category : #utilities }
MicMicrodownSnippetFactory >> documentFrom: aString [
	^ parserClass new parse: aString
]

{ #category : #anchor }
MicMicrodownSnippetFactory >> environmentSample [

	^ '
',EnvironmentOpeningBlockMarkup,'Foo|value=aFoo&label=42

Foo

',EnvironmentClosingBlockMarkup
]

{ #category : #anchor }
MicMicrodownSnippetFactory >> environmentWithInnerBlockSample [
	^ '
',EnvironmentOpeningBlockMarkup,'Foo|value=aFoo&label=42

This is a **paragraph**

```language=Smalltalk&caption=`Color` is cool
This is a codeBlock
```

[ this is an _url_ ](/anExternalLink)

',EnvironmentClosingBlockMarkup
]

{ #category : #format }
MicMicrodownSnippetFactory >> figureBoldSample [
	^ '

![**Foo**](/anUrl label=figureTest&size=80)
'
]

{ #category : #figures }
MicMicrodownSnippetFactory >> figureGoutDeFraise [
	^ '

![Proposition pour le thème : _Un goût de fraise_](un-gout-de-fraise.jpg)
'
]

{ #category : #format }
MicMicrodownSnippetFactory >> figureItalicSample [

	^ '

![_Foo_](/anUrl label=figureTest&size=80)
'
]

{ #category : #format }
MicMicrodownSnippetFactory >> figureMonospaceSample [

	^ '

![`Foo`](/anUrl label=figureTest&size=80)
'
]

{ #category : #format }
MicMicrodownSnippetFactory >> figureNestedSample [

	^ '

![**Foo\_**](/anUrl label=figureTest&size=80)
'
]

{ #category : #figures }
MicMicrodownSnippetFactory >> figureRealSample [

	^ '
![A logo png under figures folder](figures/logo.png label=figureTest&size=80)
'
]

{ #category : #format }
MicMicrodownSnippetFactory >> figureSample [

	^ '

![Foo](/anUrl label=figureTest&size=80)
'
]

{ #category : #format }
MicMicrodownSnippetFactory >> figureSampleWithoutSizeAndLabel [

	^ '

![Foo](/anUrl)
'
]

{ #category : #format }
MicMicrodownSnippetFactory >> figureStrikeSample [

	^ '

![~Foo~](/anUrl label=figureTest&size=80)
'
]

{ #category : #figures }
MicMicrodownSnippetFactory >> figureWithLabelWithoutSizeSample [

	^ '

![Foo](/anUrl label=figureTest)
'
]

{ #category : #figures }
MicMicrodownSnippetFactory >> figureWithoutCaptionSample [

	^ '

![](/anUrl label=figureTest&size=80)
'
]

{ #category : #format }
MicMicrodownSnippetFactory >> fileFigureSample [

	^ '

![Foo](file://image.png/ label=figureTest&size=80)
'
]

{ #category : #anchor }
MicMicrodownSnippetFactory >> footnoteSample [
	^ AnnotationOpenerMarkup ,'footnote|note=Pharo is cool', AnnotationCloserMarkup
]

{ #category : #headers }
MicMicrodownSnippetFactory >> headerEmptySample [

	^ self newLine , HeaderMarkup
]

{ #category : #headers }
MicMicrodownSnippetFactory >> headerLevel1Sample [

	^ self newLine , (self headerLevel: 1)
]

{ #category : #headers }
MicMicrodownSnippetFactory >> headerLevel2Sample [

	^ self newLine , (self headerLevel: 2)
]

{ #category : #headers }
MicMicrodownSnippetFactory >> headerLevel3Sample [

	^ self newLine , (self headerLevel: 3)
]

{ #category : #headers }
MicMicrodownSnippetFactory >> headerLevel3SampleWithNewLine [

	^ self newLine , (self headerLevel: 3) , self newLine
]

{ #category : #headers }
MicMicrodownSnippetFactory >> headerLevel4Sample [

	^ self newLine , (self headerLevel: 4)
]

{ #category : #headers }
MicMicrodownSnippetFactory >> headerLevel5Sample [

	^ self newLine , (self headerLevel: 5)
]

{ #category : #headers }
MicMicrodownSnippetFactory >> headerLevel6Sample [

	^ self newLine , (self headerLevel: 6)
]

{ #category : #headers }
MicMicrodownSnippetFactory >> headerLevel: n [

	^ String streamContents: [ :st |
		 n timesRepeat: [ st nextPutAll: HeaderMarkup ].
		 st nextPutAll: ' Foo']
]

{ #category : #headers }
MicMicrodownSnippetFactory >> headerWithFormatSample [

	^ self newLine , HeaderMarkup , self space
	  , self boldFormatSample
]

{ #category : #headers }
MicMicrodownSnippetFactory >> headerWithFormatSampleWithNewLine [
	^ self headerWithFormatSample, self newLine
]

{ #category : #headers }
MicMicrodownSnippetFactory >> headerWithNestedFormatSampleWithNewLine [

	^ self newLine , HeaderMarkup , self space
	  , self nestedBoldFormatSample , self newLine
]

{ #category : #headers }
MicMicrodownSnippetFactory >> headerWithNewLineSample [

	^ self newLine , HeaderMarkup , 'Foo' , self newLine
]

{ #category : #headers }
MicMicrodownSnippetFactory >> horizontalLineSample [

	^ HorizontalLineMarkup , self newLine
]

{ #category : #initialization }
MicMicrodownSnippetFactory >> initialize [
	
	super initialize.
	parserClass := Microdown
]

{ #category : #sample }
MicMicrodownSnippetFactory >> inputfileSample [
	^ '
?{inputfile | path=Chapters/text.mic}?
'
]

{ #category : #format }
MicMicrodownSnippetFactory >> italicFormatEmptySample [
	^ self surround: '' withMarkup: ItalicMarkup
]

{ #category : #format }
MicMicrodownSnippetFactory >> italicFormatSample [
	^ self surroundWithMarkup: ItalicMarkup
]

{ #category : #document }
MicMicrodownSnippetFactory >> lineEndSample [

	^  ''
]

{ #category : #document }
MicMicrodownSnippetFactory >> lineEndwithNewlineSample [

	^ String lf
]

{ #category : #format }
MicMicrodownSnippetFactory >> linkBoldSample [
	^ '
[**Foo**](/anUrl)
'
]

{ #category : #format }
MicMicrodownSnippetFactory >> linkItalicSample [
	^ '
[_Foo_](/anUrl)
'
]

{ #category : #format }
MicMicrodownSnippetFactory >> linkMonospaceSample [
	^ '
[`Foo`](/anUrl)
'
]

{ #category : #format }
MicMicrodownSnippetFactory >> linkNestedSample [
	^ '
[**_Foo_**](/anUrl)
'
]

{ #category : #format }
MicMicrodownSnippetFactory >> linkSample [
	^ '
[Foo](/anUrl)
'
]

{ #category : #format }
MicMicrodownSnippetFactory >> linkStrikeSample [
	^ '
[~Foo~](/anUrl)
'
]

{ #category : #list }
MicMicrodownSnippetFactory >> listMultiSample [

	| unordered |
	unordered := UnorderedListMarkup.

	^ unordered , '1' , self newLine , unordered , unordered , '2'
	  , self newLine , unordered , unordered , unordered , '3'
	  , self newLine , unordered , unordered , '4' , self newLine
	  , unordered , unordered , '5' , self newLine , unordered
	  , unordered , '6' , self newLine , unordered , '7' , self newLine
	  , unordered , '2. 8'
]

{ #category : #list }
MicMicrodownSnippetFactory >> listWithCommentSample [
	^ '1. Foo
%Comment
2. Bar'
]

{ #category : #anchor }
MicMicrodownSnippetFactory >> mathInlineSample [
	^ '
$V_i = C_0 - C_3$
'
]

{ #category : #anchor }
MicMicrodownSnippetFactory >> mathParametersSample [
	^ '&label=42
Foo
&'
]

{ #category : #anchor }
MicMicrodownSnippetFactory >> mathParametersWithCaptionSample [
	^ '&caption=`Math` is good&label=42
Foo
&'
]

{ #category : #anchor }
MicMicrodownSnippetFactory >> metaDataSample [
	^ '{
"author": "G. Foo",
"title":"The title"
}
'
]

{ #category : #format }
MicMicrodownSnippetFactory >> monospaceFormatEmptySample [
	^ self surround: '' withMarkup: MonospaceMarkup
]

{ #category : #format }
MicMicrodownSnippetFactory >> monospaceFormatSample [
	^ self surroundWithMarkup: MonospaceMarkup
]

{ #category : #format }
MicMicrodownSnippetFactory >> nestedBoldFormatSample [
	"self new nestedBoldFormatSample"
	^ self surround: (self surround: 'Foo' withMarkup: BoldMarkup) withMarkup: ItalicMarkup  
]

{ #category : #list }
MicMicrodownSnippetFactory >> nestedOrderedList2Sample [
	^ '
- Foo
- Bar
		1. B
		1. a
		1. r
					- 3rdlvel
					- 3rdlevl2
- Zork
'
]

{ #category : #list }
MicMicrodownSnippetFactory >> nestedOrderedListSample [
	^ '
- Foo
- Bar
		1. B
		1. a
		1. r
'
]

{ #category : #list }
MicMicrodownSnippetFactory >> nestedUnorderedListSample [
	^ '
- Foo
- Bar
		- B
		- a
		- r
'
]

{ #category : #utilities }
MicMicrodownSnippetFactory >> newLine [
	^  String cr
]

{ #category : #document }
MicMicrodownSnippetFactory >> newlineCRLFSample [

	^ String crlf
]

{ #category : #document }
MicMicrodownSnippetFactory >> newlineCRSample [

	^ self newLine
]

{ #category : #document }
MicMicrodownSnippetFactory >> newlineLFSample [

	^ String lf
]

{ #category : #document }
MicMicrodownSnippetFactory >> newlineSample [

	^ Smalltalk os lineEnding
]

{ #category : #sample }
MicMicrodownSnippetFactory >> oneSlide [

	^ '<!slide|title=This is a cool title&tag=nh5p

- a list of bullet
- bullet 2
- bullet 3
!>'
]

{ #category : #list }
MicMicrodownSnippetFactory >> orderedListEmptySample [
	^ '
1. '
]

{ #category : #list }
MicMicrodownSnippetFactory >> orderedListSample [
	^ '
1. Foo
'
]

{ #category : #list }
MicMicrodownSnippetFactory >> orderedListWithTwoItemsBoldFirstSample [
	
	^ 
'
1. **_first_**
1. second
'
]

{ #category : #list }
MicMicrodownSnippetFactory >> orderedListWithTwoItemsBoldSample [
	
	^ 
'
1. **first**
1. second
'
]

{ #category : #list }
MicMicrodownSnippetFactory >> orderedListWithTwoItemsItalicSample [
	
	^ 
'
1. _first_
1. second
'
]

{ #category : #list }
MicMicrodownSnippetFactory >> orderedListWithTwoItemsMonospaceSample [
	
	^ 
'
1. `first`
1. second
'
]

{ #category : #list }
MicMicrodownSnippetFactory >> orderedListWithTwoItemsSample [
	
	^ 
'
1. first
1. second
'
]

{ #category : #list }
MicMicrodownSnippetFactory >> orderedListWithTwoItemsStrikeSample [
	
	^ 
'
1. ~first~
1. second
'
]

{ #category : #format }
MicMicrodownSnippetFactory >> paragraphBoldSample [
	^ '
this is a **paragraph**
'
]

{ #category : #format }
MicMicrodownSnippetFactory >> paragraphItalicSample [
	^ '
this is a _paragraph_
'
]

{ #category : #format }
MicMicrodownSnippetFactory >> paragraphMonospaceSample [
	^ '
this is a `paragraph`
'
]

{ #category : #format }
MicMicrodownSnippetFactory >> paragraphNestedSample [
	^ '
this is a **_paragraph_**
'
]

{ #category : #format }
MicMicrodownSnippetFactory >> paragraphOnMultipleLinesSample [
	^ 'Je ne connais pas la peur, car la peur tue l''esprit. La peur est la petite mort qui conduit à l''oblitération totale. J''affonterai ma peur. Je lui permettrais de passer sur moi, au travers de moi. Et lorsqu''elle sera passée, je tournerai mon oeil interieur sur son chemin. Et là où elle sera passée, il n''y aura plus rien, rien que moi.'
]

{ #category : #format }
MicMicrodownSnippetFactory >> paragraphSample [
	^ '
Foo
'
]

{ #category : #format }
MicMicrodownSnippetFactory >> paragraphStrikeSample [
	^ '
this is a ~paragraph~
'
]

{ #category : #utilities }
MicMicrodownSnippetFactory >> parserClass [

	^ parserClass
]

{ #category : #anchor }
MicMicrodownSnippetFactory >> quoteSample [
	^ '>  Foo'
]

{ #category : #figures }
MicMicrodownSnippetFactory >> rawFormatInline [

	^ '
a{{_$Foo_}}b
'
]

{ #category : #format }
MicMicrodownSnippetFactory >> rawFormatSample [
	^ '
a{{Foo}}b
'
]

{ #category : #figures }
MicMicrodownSnippetFactory >> realLinkSample [
	^ '
[The Pharo Project](http://www.pharo.org)
'
]

{ #category : #document }
MicMicrodownSnippetFactory >> rootSample [

	| stream |
	stream := (String new: 10000) writeStream.
	stream
		nextPutAll: self headerLevel2Sample;
		nextPutAll: self newLine;
		nextPutAll: self paragraphNestedSample;
		nextPutAll: self figureSample.
	^ stream contents
]

{ #category : #'code block parameter' }
MicMicrodownSnippetFactory >> scriptParameterEscapeSample [
	^ 'value\==foo'
]

{ #category : #'code block parameter' }
MicMicrodownSnippetFactory >> scriptParameterSample [
	^ 'value=foo'
]

{ #category : #'code block parameter' }
MicMicrodownSnippetFactory >> scriptParameterValueSample [
	^ '=foo'
]

{ #category : #'code block parameter' }
MicMicrodownSnippetFactory >> scriptParameterWithSpacesBeforeAndAfterSample [
	^ ' foo = true & bar = 2 
'
]

{ #category : #'code block parameter' }
MicMicrodownSnippetFactory >> scriptParameterWithoutValueSample [
	^ 'foo'
]

{ #category : #'code block parameter' }
MicMicrodownSnippetFactory >> scriptParametersEscapeSample [
	^ 'value=foo\&&bar
'
]

{ #category : #'code block parameter' }
MicMicrodownSnippetFactory >> scriptParametersMultipleSample [
	^ 'value=foo&bar
'
]

{ #category : #'code block parameter' }
MicMicrodownSnippetFactory >> scriptTwoParametersNoValueSample [
	^ 'foo&bar
'
]

{ #category : #sample }
MicMicrodownSnippetFactory >> simpleTable [
	^ '
| aaab | jkhjh |
| --- | --- |
| bar | rab |'
]

{ #category : #sample }
MicMicrodownSnippetFactory >> simpleTableFormat [
	^ '
| **aaab** | jkhjh |
| --- | --- |
| bar | rab |'
]

{ #category : #sample }
MicMicrodownSnippetFactory >> simpleTableMoreFormat [
	^ '
| **aaab** bbbc _cccd_ | jkhjh |
| --- | --- |
| bar | rab |'
]

{ #category : #sample }
MicMicrodownSnippetFactory >> simpleTableShortRow [
	^ '
| aaab | jkhjh |
| --- | --- |
| bar |'
]

{ #category : #sample }
MicMicrodownSnippetFactory >> simpleTableWithoutHeaderTable [
	^ '
| aaab | jkhjh |
| bar | rab |'
]

{ #category : #utilities }
MicMicrodownSnippetFactory >> space [ 

	^ String space
]

{ #category : #format }
MicMicrodownSnippetFactory >> strikethroughFormatEmptySample [
	^ self surround: '' withMarkup: StrikeMarkup
]

{ #category : #format }
MicMicrodownSnippetFactory >> strikethroughFormatSample [
	^ self surroundWithMarkup: StrikeMarkup
]

{ #category : #format }
MicMicrodownSnippetFactory >> surround: aWord withMarkup: aMarkup [
	^ (aMarkup, aWord, aMarkup) asString
]

{ #category : #format }
MicMicrodownSnippetFactory >> surroundWithMarkup: aMarkup [
	^ self surround: 'Foo' withMarkup: aMarkup
]

{ #category : #sample }
MicMicrodownSnippetFactory >> tableSample [
	^ '| aaab | jkhjh |
| --- | --- |
| bar | rab |
'
]

{ #category : #format }
MicMicrodownSnippetFactory >> textSentenceSample [

	^ 'Je ne connaitrais pas la peur'
]

{ #category : #format }
MicMicrodownSnippetFactory >> textWithChevron [

	^ 'Pilou >> bla'
]

{ #category : #list }
MicMicrodownSnippetFactory >> unorderedListEmptySample [

	^ UnorderedListMarkup
]

{ #category : #list }
MicMicrodownSnippetFactory >> unorderedListSample [

	^ '
* Foo
'
]

{ #category : #list }
MicMicrodownSnippetFactory >> unorderedListWithSubListSample [

	| listMarkup |
	listMarkup := UnorderedListMarkup.
	^ self newLine , listMarkup , 'Foo' , self newLine , listMarkup
	  , listMarkup , 'Bar'
]

{ #category : #list }
MicMicrodownSnippetFactory >> unorderedListWithTwoItemsBoldSample [

	| listMarkup |
	listMarkup := UnorderedListMarkup.
	^ self newLine , listMarkup , '**Foo**' , self newLine , listMarkup
	  , 'Bar
'
]

{ #category : #list }
MicMicrodownSnippetFactory >> unorderedListWithTwoItemsItalicSample [

	| listMarkup |
	listMarkup := UnorderedListMarkup.
	^ self newLine , listMarkup , '_Foo_' , self newLine , listMarkup
	  , 'Bar
'
]

{ #category : #list }
MicMicrodownSnippetFactory >> unorderedListWithTwoItemsMonospaceSample [

	| listMarkup |
	listMarkup := UnorderedListMarkup.
	^ self newLine , listMarkup , '`Foo`' , self newLine , listMarkup
	  , 'Bar
'
]

{ #category : #list }
MicMicrodownSnippetFactory >> unorderedListWithTwoItemsNestedSample [

	| listMarkup |
	listMarkup := UnorderedListMarkup.
	^ self newLine , listMarkup , '~_Foo_~' , self newLine , listMarkup
	  , 'Bar
'
]

{ #category : #list }
MicMicrodownSnippetFactory >> unorderedListWithTwoItemsSample [

	| listMarkup |
	listMarkup := UnorderedListMarkup.
	^ self newLine , listMarkup , 'Foo' , self newLine , listMarkup
	  , 'Bar
'
]

{ #category : #list }
MicMicrodownSnippetFactory >> unorderedListWithTwoItemsStrikeSample [

	| listMarkup |
	listMarkup := UnorderedListMarkup.
	^ self newLine , listMarkup , '~Foo~' , self newLine , listMarkup
	  , 'Bar
'
]
