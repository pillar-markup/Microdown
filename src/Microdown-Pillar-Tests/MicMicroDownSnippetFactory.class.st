Class {
	#name : #MicMicroDownSnippetFactory,
	#superclass : #Object,
	#category : #'Microdown-Pillar-Tests'
}

{ #category : #anchor }
MicMicroDownSnippetFactory >> anchorAreTrimedSample [
	^ self grammar anchorMarkup, '  test  '
]

{ #category : #anchor }
MicMicroDownSnippetFactory >> anchorSample [
	^ self grammar anchorMarkup, 'test'
]

{ #category : #anchor }
MicMicroDownSnippetFactory >> anchorWithNewLineSample [
	^ self grammar anchorMarkup, 'foo', String cr
]

{ #category : #anchor }
MicMicroDownSnippetFactory >> anchorWithSpaceInsideSample [
	^ self grammar anchorMarkup, 'foo bar'
]

{ #category : #format }
MicMicroDownSnippetFactory >> boldFormatEmptySample [
	^ self surround: '' withMarkup: self grammar boldMarkup
]

{ #category : #format }
MicMicroDownSnippetFactory >> boldFormatSample [
	^ self surroundWithMarkup: self grammar boldMarkup
]

{ #category : #'code block' }
MicMicroDownSnippetFactory >> codeblock: param [ 

	^ String streamContents: [ :st | 
		st nextPutAll: self grammar codeblockMarkup. 
		st nextPutAll: param.
		st cr.
		st nextPutAll: self grammar codeblockMarkup. 
	]
]

{ #category : #'code block' }
MicMicroDownSnippetFactory >> codeblock: param body: body [

	^ String streamContents: [ :st | 
		st nextPutAll: self grammar codeblockMarkup. 
		st nextPutAll: param.
		st cr.
		st nextPutAll: body.
		st cr.
		st nextPutAll: self grammar codeblockMarkup. 
	]
]

{ #category : #'code block' }
MicMicroDownSnippetFactory >> codeblockNoParamBody: body [

	^ String streamContents: [ :st | 
		st nextPutAll: self grammar codeblockMarkup. 
		st cr.
		st nextPutAll: body.
		st cr.
		st nextPutAll: self grammar codeblockMarkup. 
	]
]

{ #category : #utils }
MicMicroDownSnippetFactory >> grammar [

	^ MicroDownParser  
]

{ #category : #headers }
MicMicroDownSnippetFactory >> headerEmptySample [ 
	^ self grammar headerMarkup
]

{ #category : #headers }
MicMicroDownSnippetFactory >> headerLevel1Sample [
	^ self headerLevel: 1
]

{ #category : #headers }
MicMicroDownSnippetFactory >> headerLevel2Sample [

	^ self headerLevel: 2
]

{ #category : #headers }
MicMicroDownSnippetFactory >> headerLevel3Sample [

	^ self headerLevel: 3
]

{ #category : #headers }
MicMicroDownSnippetFactory >> headerLevel4Sample [

	^ self headerLevel: 4
]

{ #category : #headers }
MicMicroDownSnippetFactory >> headerLevel5Sample [

	^ self headerLevel: 5
]

{ #category : #headers }
MicMicroDownSnippetFactory >> headerLevel6Sample [

	^ self headerLevel: 6
]

{ #category : #headers }
MicMicroDownSnippetFactory >> headerLevel: n [

	^ String streamContents: [ :st |
		 n timesRepeat: [ st nextPutAll: self grammar headerMarkup ].
		 st nextPutAll: 'Foo']
]

{ #category : #headers }
MicMicroDownSnippetFactory >> headerWithFormatSample [
	^ self grammar headerMarkup, self boldFormatSample 
]

{ #category : #headers }
MicMicroDownSnippetFactory >> headerWithNewLineSample [
	^ self grammar headerMarkup, 'Foo', String cr
]

{ #category : #format }
MicMicroDownSnippetFactory >> italicFormatEmptySample [
	^ self surround: '' withMarkup: self grammar italicMarkup
]

{ #category : #format }
MicMicroDownSnippetFactory >> italicFormatSample [
	^ self surroundWithMarkup: self grammar italicMarkup
]

{ #category : #document }
MicMicroDownSnippetFactory >> lineEndSample [

	^  ''
]

{ #category : #document }
MicMicroDownSnippetFactory >> lineEndwithNewlineSample [

	^ String lf
]

{ #category : #list }
MicMicroDownSnippetFactory >> listMultiSample [
	| unordered |
	unordered := self grammar unorderedListMarkup.
	
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
MicMicroDownSnippetFactory >> listWithCommentSample [
	^ '1. Foo
%Comment
2. Bar'
]

{ #category : #format }
MicMicroDownSnippetFactory >> monospaceFormatEmptySample [
	^ self surround: '' withMarkup: self grammar monospaceMarkup
]

{ #category : #format }
MicMicroDownSnippetFactory >> monospaceFormatSample [
	^ self surroundWithMarkup: self grammar monospaceMarkup
]

{ #category : #document }
MicMicroDownSnippetFactory >> newlineCRLFSample [

	^ String crlf
]

{ #category : #document }
MicMicroDownSnippetFactory >> newlineCRSample [

	^ String cr
]

{ #category : #document }
MicMicroDownSnippetFactory >> newlineLFSample [

	^ String lf
]

{ #category : #document }
MicMicroDownSnippetFactory >> newlineSample [

	^ Smalltalk os lineEnding
]

{ #category : #list }
MicMicroDownSnippetFactory >> orderedListEmptySample [
	^ '1. '
]

{ #category : #list }
MicMicroDownSnippetFactory >> orderedListSample [
	^ '1. Foo'
]

{ #category : #list }
MicMicroDownSnippetFactory >> orderedListWithTwoItemsSample [
	
	^ 
'1. first
2. second
'
]

{ #category : #'code block' }
MicMicroDownSnippetFactory >> scriptParameterEscapeSample [
	^ 'value\==foo'
]

{ #category : #'code block' }
MicMicroDownSnippetFactory >> scriptParameterSample [
	^ 'value=foo'
]

{ #category : #'code block' }
MicMicroDownSnippetFactory >> scriptParameterTrueByDefaultSample [
	^ self codeblock: 'foo' body: 'bar'
	
]

{ #category : #'code block' }
MicMicroDownSnippetFactory >> scriptParameterValueSample [
	^ '=foo'
]

{ #category : #'code block' }
MicMicroDownSnippetFactory >> scriptParameterWithFloatSample [
	^ self codeblock: 'ratio=0.8' body: 'bar'
	
]

{ #category : #'code block' }
MicMicroDownSnippetFactory >> scriptParameterWithLiteralArraySample [
	^ self codeblock: 'foo=#(1 2 true)'
]

{ #category : #'code block' }
MicMicroDownSnippetFactory >> scriptParameterWithNoValuesSample [
	^ self codeblock: 'foo=' body: 'bar'

]

{ #category : #'code block' }
MicMicroDownSnippetFactory >> scriptParameterWithSpacesBeforeAndAfterSample [
	^ ' foo = true | bar = 2 
'
]

{ #category : #'code block' }
MicMicroDownSnippetFactory >> scriptParameterWithoutValueSample [
	^ 'foo'
]

{ #category : #'code block' }
MicMicroDownSnippetFactory >> scriptParametersEscapeSample [
	^ 'value=foo\||bar
'
]

{ #category : #'code block' }
MicMicroDownSnippetFactory >> scriptParametersMultipleSample [
	^ 'value=foo|bar
'
]

{ #category : #'code block' }
MicMicroDownSnippetFactory >> scriptParametersSample [
	^ 'value=foo
'
]

{ #category : #'code block' }
MicMicroDownSnippetFactory >> scriptSample [
	^ self codeblockNoParamBody: 'foo'
]

{ #category : #'code block' }
MicMicroDownSnippetFactory >> scriptTwoParametersNoValueSample [
	^ 'foo|bar
'
]

{ #category : #'code block' }
MicMicroDownSnippetFactory >> scriptWithLanguageSample [
	^ self codeblock: 'language=smalltalk' body: 'foo'
]

{ #category : #'code block' }
MicMicroDownSnippetFactory >> scriptWithNewLineSample [
	^ (self codeblockNoParamBody: 'foo'), String cr
]

{ #category : #'code block' }
MicMicroDownSnippetFactory >> scriptWithSpaceAtTheEndSample [
		
	 ^ (self codeblockNoParamBody: 'foo'), '  '.


]

{ #category : #'code block' }
MicMicroDownSnippetFactory >> scriptWithSpacedParametersSample [
	^ self codeblock:   ' foo = true | bar = 2 '
body: 'bla'
]

{ #category : #format }
MicMicroDownSnippetFactory >> strikethroughFormatEmptySample [
	^ self surround: '' withMarkup: self grammar strikethroughMarkup
]

{ #category : #format }
MicMicroDownSnippetFactory >> strikethroughFormatSample [
	^ self surroundWithMarkup: self grammar strikethroughMarkup
]

{ #category : #format }
MicMicroDownSnippetFactory >> subscriptFormatEmptySample [
	^ self surround: '' withMarkup: self grammar subscriptMarkup
]

{ #category : #format }
MicMicroDownSnippetFactory >> subscriptFormatSample [
	^ self surroundWithMarkup: self grammar subscriptMarkup
]

{ #category : #format }
MicMicroDownSnippetFactory >> superscriptFormatEmptySample [
	^ self surround: '' withMarkup: self grammar superscriptMarkup
]

{ #category : #format }
MicMicroDownSnippetFactory >> superscriptFormatSample [
	^ self surroundWithMarkup: self grammar superscriptMarkup
]

{ #category : #format }
MicMicroDownSnippetFactory >> surround: aWord withMarkup: aMarkup [
	^ (aMarkup, aWord, aMarkup) asString
]

{ #category : #format }
MicMicroDownSnippetFactory >> surroundWithMarkup: aMarkup [
	^ self surround: 'Foo' withMarkup: aMarkup
]

{ #category : #format }
MicMicroDownSnippetFactory >> underlineFormatEmptySample [
	^ self surround: '' withMarkup: self grammar underlineMarkup
]

{ #category : #format }
MicMicroDownSnippetFactory >> underlineFormatSample [
	^ self surroundWithMarkup: self grammar underlineMarkup
]

{ #category : #list }
MicMicroDownSnippetFactory >> unorderedListEmptySample [
	^ self grammar unorderedListMarkup
]

{ #category : #list }
MicMicroDownSnippetFactory >> unorderedListSample [
	^ self grammar unorderedListMarkup, 'Foo'
]

{ #category : #list }
MicMicroDownSnippetFactory >> unorderedListWithSubListSample [
	| listMarkup |
	listMarkup := self grammar unorderedListMarkup.
	^ listMarkup, 'Foo', String cr, listMarkup, listMarkup, 'Bar'
]

{ #category : #list }
MicMicroDownSnippetFactory >> unorderedListWithTwoItemsSample [
	| listMarkup |
	listMarkup := self grammar unorderedListMarkup.
	^ listMarkup, 'Foo', String cr, listMarkup, 'Bar'
]
