"
I define the standard inline delimiters
"
Class {
	#name : 'MicInlineStandardDelimiter',
	#superclass : 'MicInlineDelimiter',
	#instVars : [
		'markup',
		'closer',
		'blockClass'
	],
	#pools : [
		'MicMicrodownSharedPool'
	],
	#category : 'Microdown-InlineParser',
	#package : 'Microdown',
	#tag : 'InlineParser'
}

{ #category : 'initialization' }
MicInlineStandardDelimiter class >> initializeDelimiters [

	"The fixious text delimiter"
	self new markup: FixiousTextDelimiter; blockClass: MicTextBlock; closer: nil; addMe.

	"The comment text delimiter"
	self new markup: CommentedLineMarkup ; blockClass: MicInlineCommentBlock; closer: nil; addMe.

	"formating"
	self new markup: BoldMarkup; blockClass: MicBoldFormatBlock; closer: BoldMarkup; addMe.
	self new markup: ItalicMarkup; blockClass: MicItalicFormatBlock; closer: ItalicMarkup; addMe.
	self new markup: StrikeMarkup; blockClass: MicStrikeFormatBlock; closer: StrikeMarkup; addMe.

	"anchors & annotations"
	self new markup: AnchorReferenceOpenerMarkup; blockClass: MicAnchorReferenceBlock; closer: AnchorReferenceCloserMarkup; addMe.
	self new markup: AnchorReferenceCloserMarkup; blockClass: nil; closer: nil; addMe.
	self new markup: AnnotationCloserMarkup; blockClass: nil; closer: nil; addMe.
	self new markup: AnnotationOpenerMarkup; blockClass: MicAnnotationBlock; closer: AnnotationCloserMarkup; addMe.

	"unevaluated"
	self new markup: MathMarkup; blockClass: MicMathInlineBlock; closer: MathMarkup; addMe.
	self new markup: MonospaceMarkup; blockClass: MicMonospaceFormatBlock; closer: MonospaceMarkup; addMe.
	self new markup: RawOpenerMarkup; blockClass: MicRawBlock; closer: RawCloserMarkup; addMe.
	self new markup: RawCloserMarkup; blockClass: nil; closer: nil; addMe.

	"Line breaks"
	"Double space are used in macrodown to split paragraphs in two paragraphs. Now 
	this is feature will break existing texts so disable it for now 
	self new markup: InlineParagraphDelimiter ; blockClass: MicLineBreakBlock ; closer: nil; addMe.
	"
	
	"Containing URLs"
	self new markup: LinkNameOpenerMarkup; blockClass: MicLinkBlock; closer: NameCloserUrlOpener; addMe.
	self new markup: FigureNameOpenerMarkup; blockClass: MicFigureBlock; closer: NameCloserUrlOpener; addMe.
	self new markup: NameCloserUrlOpener; blockClass: MicRawBlock ; closer: URLCloserMarkup; addMe.
	self new markup: URLCloserMarkup; blockClass: nil ; closer: nil; addMe
		
]

{ #category : 'accessing' }
MicInlineStandardDelimiter >> blockClass [

	^ blockClass
]

{ #category : 'accessing' }
MicInlineStandardDelimiter >> blockClass: anObject [

	blockClass := anObject
]

{ #category : 'accessing' }
MicInlineStandardDelimiter >> closer [

	^ closer
]

{ #category : 'accessing' }
MicInlineStandardDelimiter >> closer: anObject [

	closer := anObject
]

{ #category : 'accessing' }
MicInlineStandardDelimiter >> markup [

	^ markup
]

{ #category : 'accessing' }
MicInlineStandardDelimiter >> markup: anObject [

	markup := anObject
]

{ #category : 'accessing' }
MicInlineStandardDelimiter >> markupAsRegex [
	"return a regex (as string) matching this delimiter"
	| str |
	str := WriteStream on: ''. 
	self isRawkind
		ifTrue: [ 
				markup do: [ :char| str nextPut: $\; nextPut: char ].
				str nextPutAll: (self class regexNot: closer).
				closer do: [ :char| str nextPut: $\; nextPut: char ] ]
		ifFalse: [ markup do: [ :char| str nextPut: $\; nextPut: char ] ].
	^ str contents
]

{ #category : 'printing' }
MicInlineStandardDelimiter >> printOn: stream [
	stream << $« << markup << $»
]
