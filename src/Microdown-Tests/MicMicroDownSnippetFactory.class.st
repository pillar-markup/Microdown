Class {
	#name : #MicMicrodownSnippetFactory,
	#superclass : #Object,
	#instVars : [
		'parserClass'
	],
	#category : #'Microdown-Tests-Snippets'
}

{ #category : #anchor }
MicMicrodownSnippetFactory >> anchorAreTrimedSample [
	^ self parserClass anchorMarkup, '  test  '
]

{ #category : #anchor }
MicMicrodownSnippetFactory >> anchorReferenceSample [
	^ '
*@Foo@*
'
]

{ #category : #anchor }
MicMicrodownSnippetFactory >> anchorSample [
	^ self parserClass anchorMarkup, 'test'
]

{ #category : #anchor }
MicMicrodownSnippetFactory >> anchorWithNewLineSample [
	^ self parserClass anchorMarkup, 'foo', String cr
]

{ #category : #anchor }
MicMicrodownSnippetFactory >> anchorWithSpaceInsideSample [
	^ self parserClass anchorMarkup, 'foo bar'
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
abc<? Foo | value=aFoo&label=42 ?>def
'
]

{ #category : #format }
MicMicrodownSnippetFactory >> boldFormatEmptySample [
	^ self surround: '' withMarkup: self parserClass boldMarkup
]

{ #category : #format }
MicMicrodownSnippetFactory >> boldFormatSample [
	^ self surroundWithMarkup: self parserClass boldMarkup
]

{ #category : #'code block' }
MicMicrodownSnippetFactory >> codeBlockParameterWithLiteralArraySample [
	^ String cr, self codeblock: 'foo=#(1 2 true)'
]

{ #category : #'code block' }
MicMicrodownSnippetFactory >> codeblock: param [ 

	^ String streamContents: [ :st | 
		st cr.
		st nextPutAll: self parserClass codeblockMarkup. 
		st nextPutAll: param.
		st cr.
		st nextPutAll: self parserClass codeblockMarkup. 
	]
]

{ #category : #'code block' }
MicMicrodownSnippetFactory >> codeblock: param body: body [
	
	^ String streamContents: [ :st | 
		st cr.
		st nextPutAll: self parserClass codeblockMarkup. 
		st nextPutAll: param.
		st cr.
		st nextPutAll: body.
		st cr.
		st nextPutAll: self parserClass codeblockMarkup. 
	]
]

{ #category : #'code block' }
MicMicrodownSnippetFactory >> codeblockNoParamBody: body [

	^ String streamContents: [ :st | 
		st cr.
		st nextPutAll: self parserClass codeblockMarkup. 
		st cr.
		st nextPutAll: body.
		st cr.
		st nextPutAll: self parserClass codeblockMarkup. 
	]
]

{ #category : #block }
MicMicrodownSnippetFactory >> commentSample [
	^ '% Foo'
]

{ #category : #utils }
MicMicrodownSnippetFactory >> documentFrom: aString [
	^ parserClass new parse: aString
]

{ #category : #anchor }
MicMicrodownSnippetFactory >> environmentSample [
	^ '<?Foo|value=aFoo&label=42
Foo
?>'
]

{ #category : #anchor }
MicMicrodownSnippetFactory >> environmentWithInnerBlockSample [
	^ '<?Foo|value=aFoo&label=42
This is a **paragraph**

```language=Smalltalk&caption=`Color` is cool
This is a codeBlock
```
[ this is an _url_ ](/anExternalLink)

?>'
]

{ #category : #format }
MicMicrodownSnippetFactory >> figureBoldSample [
	^ '

![**Foo**](/anUrl?label=figureTest&size=80)
'
]

{ #category : #format }
MicMicrodownSnippetFactory >> figureItalicSample [
	^ '

![_Foo_](/anUrl?label=figureTest&size=80)
'
]

{ #category : #format }
MicMicrodownSnippetFactory >> figureMonospaceSample [
	^ '

![`Foo`](/anUrl?label=figureTest&size=80)
'
]

{ #category : #format }
MicMicrodownSnippetFactory >> figureNestedSample [
	^ '

![**Foo_**](/anUrl?label=figureTest&size=80)
'
]

{ #category : #format }
MicMicrodownSnippetFactory >> figureSample [
	^ '

![Foo](/anUrl?label=figureTest&size=80)
'
]

{ #category : #format }
MicMicrodownSnippetFactory >> figureStrikeSample [
	^ '

![~Foo~](/anUrl?label=figureTest&size=80)
'
]

{ #category : #headers }
MicMicrodownSnippetFactory >> headerEmptySample [ 
	^ self parserClass headerMarkup
]

{ #category : #headers }
MicMicrodownSnippetFactory >> headerLevel1Sample [
	^ self headerLevel: 1
]

{ #category : #headers }
MicMicrodownSnippetFactory >> headerLevel2Sample [

	^ self headerLevel: 2
]

{ #category : #headers }
MicMicrodownSnippetFactory >> headerLevel3Sample [

	^ self headerLevel: 3
]

{ #category : #headers }
MicMicrodownSnippetFactory >> headerLevel3SampleWithNewLine [

	^ (self headerLevel: 3), self newLine
]

{ #category : #headers }
MicMicrodownSnippetFactory >> headerLevel4Sample [

	^ self headerLevel: 4
]

{ #category : #headers }
MicMicrodownSnippetFactory >> headerLevel5Sample [

	^ self headerLevel: 5
]

{ #category : #headers }
MicMicrodownSnippetFactory >> headerLevel6Sample [

	^ self headerLevel: 6
]

{ #category : #headers }
MicMicrodownSnippetFactory >> headerLevel: n [

	^ String streamContents: [ :st |
		 n timesRepeat: [ st nextPutAll: self parserClass headerMarkup ].
		 st nextPutAll: ' Foo']
]

{ #category : #headers }
MicMicrodownSnippetFactory >> headerWithFormatSample [
	^ self parserClass headerMarkup, self space, self boldFormatSample
]

{ #category : #headers }
MicMicrodownSnippetFactory >> headerWithFormatSampleWithNewLine [
	^ self headerWithFormatSample, self newLine
]

{ #category : #headers }
MicMicrodownSnippetFactory >> headerWithNestedFormatSampleWithNewLine [
	^ self parserClass headerMarkup, self space, self nestedBoldFormatSample , self newLine
]

{ #category : #headers }
MicMicrodownSnippetFactory >> headerWithNewLineSample [
	^ self parserClass headerMarkup, 'Foo', String cr
]

{ #category : #headers }
MicMicrodownSnippetFactory >> horizontalLineSample [
	^ parserClass horizontalLineMarkup, String cr
]

{ #category : #initialization }
MicMicrodownSnippetFactory >> initialize [
	
	super initialize.
	parserClass := MicroDownParser
]

{ #category : #format }
MicMicrodownSnippetFactory >> italicFormatEmptySample [
	^ self surround: '' withMarkup: self parserClass italicMarkup
]

{ #category : #format }
MicMicrodownSnippetFactory >> italicFormatSample [
	^ self surroundWithMarkup: self parserClass italicMarkup
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
	^ '[**Foo**](/anUrl)
'
]

{ #category : #format }
MicMicrodownSnippetFactory >> linkItalicSample [
	^ '[_Foo_](/anUrl)
'
]

{ #category : #format }
MicMicrodownSnippetFactory >> linkMonospaceSample [
	^ '[`Foo`](/anUrl)
'
]

{ #category : #format }
MicMicrodownSnippetFactory >> linkNestedSample [
	^ '[**_Foo_**](/anUrl)
'
]

{ #category : #format }
MicMicrodownSnippetFactory >> linkSample [
	^ '[Foo](/anUrl)
'
]

{ #category : #format }
MicMicrodownSnippetFactory >> linkStrikeSample [
	^ '[~Foo~](/anUrl)
'
]

{ #category : #list }
MicMicrodownSnippetFactory >> listMultiSample [
	| unordered |
	unordered := self parserClass unorderedListMarkup.
	
	^ 	unordered, '1', String cr, 
		unordered, unordered, '2', String cr, 
		unordered, unordered, unordered, '3', String cr,
		unordered, unordered, '4', String cr,
		unordered, unordered, '5', String cr,	
		unordered, unordered, '6', String cr,
		unordered, '7', String cr,	
		unordered, '2. 8'
]

{ #category : #list }
MicMicrodownSnippetFactory >> listWithCommentSample [
	^ '1. Foo
%Comment
2. Bar'
]

{ #category : #anchor }
MicMicrodownSnippetFactory >> mathInlineSample [
	^ '$V_i = C_0 - C_3$
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
"author": "Foo"
}
'
]

{ #category : #format }
MicMicrodownSnippetFactory >> monospaceFormatEmptySample [
	^ self surround: '' withMarkup: self parserClass monospaceMarkup
]

{ #category : #format }
MicMicrodownSnippetFactory >> monospaceFormatSample [
	^ self surroundWithMarkup: self parserClass monospaceMarkup
]

{ #category : #format }
MicMicrodownSnippetFactory >> nestedBoldFormatSample [
	"self new nestedBoldFormatSample"
	^ self surround: (self surround: 'Foo' withMarkup: self parserClass boldMarkup) withMarkup: self parserClass italicMarkup  
]

{ #category : #utils }
MicMicrodownSnippetFactory >> newLine [
	^  String cr
]

{ #category : #document }
MicMicrodownSnippetFactory >> newlineCRLFSample [

	^ String crlf
]

{ #category : #document }
MicMicrodownSnippetFactory >> newlineCRSample [

	^ String cr
]

{ #category : #document }
MicMicrodownSnippetFactory >> newlineLFSample [

	^ String lf
]

{ #category : #document }
MicMicrodownSnippetFactory >> newlineSample [

	^ Smalltalk os lineEnding
]

{ #category : #list }
MicMicrodownSnippetFactory >> orderedListEmptySample [
	^ '1. '
]

{ #category : #list }
MicMicrodownSnippetFactory >> orderedListSample [
	^ '1. Foo
'
]

{ #category : #list }
MicMicrodownSnippetFactory >> orderedListWithTwoItemsBoldSample [
	
	^ 
'1. **first**
1. second
'
]

{ #category : #list }
MicMicrodownSnippetFactory >> orderedListWithTwoItemsItalicSample [
	
	^ 
'1. _first_
1. second
'
]

{ #category : #list }
MicMicrodownSnippetFactory >> orderedListWithTwoItemsMonospaceSample [
	
	^ 
'1. `first`
1. second
'
]

{ #category : #list }
MicMicrodownSnippetFactory >> orderedListWithTwoItemsNestedSample [
	
	^ 
'1. **_first_**
1. second
'
]

{ #category : #list }
MicMicrodownSnippetFactory >> orderedListWithTwoItemsSample [
	
	^ 
'1. first
1. second
'
]

{ #category : #list }
MicMicrodownSnippetFactory >> orderedListWithTwoItemsStrikeSample [
	
	^ 
'1. ~first~
1. second
'
]

{ #category : #format }
MicMicrodownSnippetFactory >> paragraphBoldSample [
	^ 'this is a **paragraph**
'
]

{ #category : #format }
MicMicrodownSnippetFactory >> paragraphItalicSample [
	^ 'this is a _paragraph_
'
]

{ #category : #format }
MicMicrodownSnippetFactory >> paragraphMonospaceSample [
	^ 'this is a `paragraph`
'
]

{ #category : #format }
MicMicrodownSnippetFactory >> paragraphNestedSample [
	^ 'this is a **_paragraph_**
'
]

{ #category : #format }
MicMicrodownSnippetFactory >> paragraphSample [
	^ 'Foo
'
]

{ #category : #format }
MicMicrodownSnippetFactory >> paragraphStrikeSample [
	^ 'this is a ~paragraph~
'
]

{ #category : #utils }
MicMicrodownSnippetFactory >> parserClass [

	^ MicroDownParser
]

{ #category : #anchor }
MicMicrodownSnippetFactory >> quoteSample [
	^ '>  Foo'
]

{ #category : #format }
MicMicrodownSnippetFactory >> rawFormatSample [
	^ 'a{{Foo}}b
'
]

{ #category : #document }
MicMicrodownSnippetFactory >> rootSample [
	| stream |
	stream := (String new: 10000) writeStream.
	stream nextPutAll: self headerLevel2Sample;
	nextPutAll: self paragraphNestedSample;
	nextPutAll: self figureSample.
	^ stream contents
]

{ #category : #'code block' }
MicMicrodownSnippetFactory >> scriptParameterEscapeSample [
	^ 'value\==foo'
]

{ #category : #'code block' }
MicMicrodownSnippetFactory >> scriptParameterSample [
	^ 'value=foo'
]

{ #category : #'code block' }
MicMicrodownSnippetFactory >> scriptParameterTrueByDefaultSample [
	^ self codeblock: 'foo' body: 'bar'
	
]

{ #category : #'code block' }
MicMicrodownSnippetFactory >> scriptParameterValueSample [
	^ '=foo'
]

{ #category : #'code block' }
MicMicrodownSnippetFactory >> scriptParameterWithFloatSample [
	^ self codeblock: 'ratio=0.8' body: 'bar'
	
]

{ #category : #'code block' }
MicMicrodownSnippetFactory >> scriptParameterWithLiteralArraySample [
	^ self codeblock: 'foo=#(1 2 true)'
]

{ #category : #'code block' }
MicMicrodownSnippetFactory >> scriptParameterWithNoValuesSample [
	^ self codeblock: 'foo=' body: 'bar'

]

{ #category : #'code block' }
MicMicrodownSnippetFactory >> scriptParameterWithSpacesBeforeAndAfterSample [
	^ ' foo = true & bar = 2 
'
]

{ #category : #'code block' }
MicMicrodownSnippetFactory >> scriptParameterWithoutValueSample [
	^ 'foo'
]

{ #category : #'code block' }
MicMicrodownSnippetFactory >> scriptParametersEscapeSample [
	^ 'value=foo\&&bar
'
]

{ #category : #'code block' }
MicMicrodownSnippetFactory >> scriptParametersMultipleSample [
	^ 'value=foo&bar
'
]

{ #category : #'code block' }
MicMicrodownSnippetFactory >> scriptParametersSample [
	^ self 
		codeblock:   'foo=true&bar=2'
		body: 'bla'
]

{ #category : #'code block' }
MicMicrodownSnippetFactory >> scriptParametersWithCaptionSample [
	^ self 
		codeblock:   'caption=`Color` is beautifull&bar=2'
		body: 'bla'
]

{ #category : #'code block' }
MicMicrodownSnippetFactory >> scriptSample [
	^ self codeblockNoParamBody: 'foo'
]

{ #category : #'code block' }
MicMicrodownSnippetFactory >> scriptTwoParametersNoValueSample [
	^ 'foo&bar
'
]

{ #category : #'code block' }
MicMicrodownSnippetFactory >> scriptWithLanguageSample [
	^ self codeblock: 'language=smalltalk' body: 'foo'
]

{ #category : #'code block' }
MicMicrodownSnippetFactory >> scriptWithNewLineSample [
	^ (self codeblockNoParamBody: 'foo'), String cr
]

{ #category : #'code block' }
MicMicrodownSnippetFactory >> scriptWithSpaceAtTheEndSample [
		
	 ^ (self codeblockNoParamBody: 'foo'), '  '.


]

{ #category : #'code block' }
MicMicrodownSnippetFactory >> scriptWithSpacedParametersSample [
	^ self 
		codeblock:   ' foo = true & bar = 2'
		body: 'bla'
]

{ #category : #utils }
MicMicrodownSnippetFactory >> space [ 

	^ String space
]

{ #category : #format }
MicMicrodownSnippetFactory >> strikethroughFormatEmptySample [
	^ self surround: '' withMarkup: self parserClass strikeMarkup
]

{ #category : #format }
MicMicrodownSnippetFactory >> strikethroughFormatSample [
	^ self surroundWithMarkup: self parserClass strikeMarkup
]

{ #category : #format }
MicMicrodownSnippetFactory >> subscriptFormatEmptySample [
	^ self surround: '' withMarkup: self parserClass subscriptMarkup
]

{ #category : #format }
MicMicrodownSnippetFactory >> subscriptFormatSample [
	^ self surroundWithMarkup: self parserClass subscriptMarkup
]

{ #category : #format }
MicMicrodownSnippetFactory >> superscriptFormatEmptySample [
	^ self surround: '' withMarkup: self parserClass superscriptMarkup
]

{ #category : #format }
MicMicrodownSnippetFactory >> superscriptFormatSample [
	^ self surroundWithMarkup: self parserClass superscriptMarkup
]

{ #category : #format }
MicMicrodownSnippetFactory >> surround: aWord withMarkup: aMarkup [
	^ (aMarkup, aWord, aMarkup) asString
]

{ #category : #format }
MicMicrodownSnippetFactory >> surroundWithMarkup: aMarkup [
	^ self surround: 'Foo' withMarkup: aMarkup
]

{ #category : #format }
MicMicrodownSnippetFactory >> underlineFormatEmptySample [
	^ self surround: '' withMarkup: self parserClass underlineMarkup
]

{ #category : #format }
MicMicrodownSnippetFactory >> underlineFormatSample [
	^ self surroundWithMarkup: self parserClass underlineMarkup
]

{ #category : #list }
MicMicrodownSnippetFactory >> unorderedListEmptySample [
	^ self parserClass unorderedListMarkup
]

{ #category : #list }
MicMicrodownSnippetFactory >> unorderedListSample [
	^ String cr, self parserClass unorderedListMarkup, 'Foo
'
]

{ #category : #list }
MicMicrodownSnippetFactory >> unorderedListWithSubListSample [
	| listMarkup |
	listMarkup := self parserClass unorderedListMarkup.
	^ String cr, listMarkup, 'Foo', String cr, listMarkup, listMarkup, 'Bar'
]

{ #category : #list }
MicMicrodownSnippetFactory >> unorderedListWithTwoItemsBoldSample [
	| listMarkup |
	listMarkup := self parserClass unorderedListMarkup.
	^ String cr, listMarkup, '**Foo**', String cr, listMarkup, 'Bar
'
]

{ #category : #list }
MicMicrodownSnippetFactory >> unorderedListWithTwoItemsItalicSample [
	| listMarkup |
	listMarkup := self parserClass unorderedListMarkup.
	^ String cr, listMarkup, '_Foo_', String cr, listMarkup, 'Bar
'
]

{ #category : #list }
MicMicrodownSnippetFactory >> unorderedListWithTwoItemsMonospaceSample [
	| listMarkup |
	listMarkup := self parserClass unorderedListMarkup.
	^ String cr, listMarkup, '`Foo`', String cr, listMarkup, 'Bar
'
]

{ #category : #list }
MicMicrodownSnippetFactory >> unorderedListWithTwoItemsNestedSample [
	| listMarkup |
	listMarkup := self parserClass unorderedListMarkup.
	^ String cr, listMarkup, '~Foo~', String cr, listMarkup, 'Bar
'
]

{ #category : #list }
MicMicrodownSnippetFactory >> unorderedListWithTwoItemsSample [
	| listMarkup |
	listMarkup := self parserClass unorderedListMarkup.
	^ String cr, listMarkup, 'Foo', String cr, listMarkup, 'Bar
'
]

{ #category : #list }
MicMicrodownSnippetFactory >> unorderedListWithTwoItemsStrikeSample [
	| listMarkup |
	listMarkup := self parserClass unorderedListMarkup.
	^ String cr, listMarkup, '~Foo~', String cr, listMarkup, 'Bar
'
]
