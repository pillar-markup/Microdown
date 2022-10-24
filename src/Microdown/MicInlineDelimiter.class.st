"
I am a class representing a inline delimiter (for example `**` for bold).

My class side manages the set of delimiters. The delimiters are defined and set up in class side `initializeDelimiters`
"
Class {
	#name : #MicInlineDelimiter,
	#superclass : #Object,
	#instVars : [
		'markup',
		'blockClass',
		'closer'
	],
	#classVars : [
		'DelimiterMap'
	],
	#pools : [
		'MicMicrodownSharedPool'
	],
	#category : #'Microdown-InlineParser'
}

{ #category : #accessing }
MicInlineDelimiter class >> all [
	^ DelimiterMap values
]

{ #category : #'private utilities' }
MicInlineDelimiter class >> allRegex [
	^ ((MicInlineDelimiter all collect: #markupAsRegex) joinUsing: '|') asRegex
	
]

{ #category : #accessing }
MicInlineDelimiter class >> at: markup [
	"return delimiter at markup, or nil"
	^ DelimiterMap at: markup ifAbsent: [ nil ]
]

{ #category : #initialization }
MicInlineDelimiter class >> initialize [
	<script>
	DelimiterMap := Dictionary new.
	self initializeDelimiters.
]

{ #category : #initialization }
MicInlineDelimiter class >> initializeDelimiters [
	"The fixious text delimiter"
	self new markup: FixiousTextDelimiter; blockClass: MicTextBlock2; closer: nil; addMe.
	"formating"
	self new markup: BoldMarkup; blockClass: MicBoldFormatBlock2; closer: BoldMarkup; addMe.
	self new markup: ItalicMarkup; blockClass: MicItalicFormatBlock2; closer: ItalicMarkup; addMe.
	self new markup: StrikeMarkup; blockClass: MicStrikeFormatBlock2; closer: StrikeMarkup; addMe.
	"anchors & annotations"
	self new markup: AnchorReferenceOpenerMarkup; blockClass: MicAnchorReferenceBlock2; closer: AnchorReferenceCloserMarkup; addMe.
	self new markup: AnchorReferenceCloserMarkup; blockClass: nil; closer: nil; addMe.
	self new markup: AnnotationCloserMarkup; blockClass: nil; closer: nil; addMe.
	self new markup: AnnotationOpenerMarkup; blockClass: MicAnnotationBlock2; closer: AnnotationCloserMarkup; addMe.
	"unevaluated"
	self new markup: MathMarkup; blockClass: MicMathInlineBlock2; closer: MathMarkup; addMe.
	self new markup: MonospaceMarkup; blockClass: MicMonospaceFormatBlock2; closer: MonospaceMarkup; addMe.
	self new markup: RawOpenerMarkup; blockClass: MicRawBlock2; closer: RawCloserMarkup; addMe.
	self new markup: RawCloserMarkup; blockClass: nil; closer: nil; addMe.
	"Containing URLs"
	self new markup: LinkNameOpenerMarkup; blockClass: MicLinkBlock2; closer: NameCloserUrlOpener; addMe.
	self new markup: FigureNameOpenerMarkup; blockClass: MicFigureBlock2; closer: NameCloserUrlOpener; addMe.
	self new markup: NameCloserUrlOpener; blockClass: MicRawBlock2 ; closer: URLCloserMarkup; addMe.
	self new markup: URLCloserMarkup; blockClass: nil ; closer: nil; addMe
		
]

{ #category : #'private utilities' }
MicInlineDelimiter class >> regexNot: markup [
	"return a regular expression (string), which is recognizing anything but markup"
	| str prefix|
	str := WriteStream on: ''.
	str nextPut: $(.
	prefix := ''.
	1 to: markup size do: [ :idx |
		str nextPutAll: prefix; nextPut: $[;nextPut: $^; nextPut: (markup at: idx); nextPut: $].
		prefix := '|', (markup copyFrom: 1 to: idx) escapeAll.
		 ].
	str nextPut: $);nextPut: $*.
	^ str contents
]

{ #category : #adding }
MicInlineDelimiter >> addMe [
	"add me to the dictionary in my class"
	DelimiterMap at: markup put: self
]

{ #category : #accessing }
MicInlineDelimiter >> blockClass [

	^ blockClass
]

{ #category : #accessing }
MicInlineDelimiter >> blockClass: anObject [

	blockClass := anObject
]

{ #category : #accessing }
MicInlineDelimiter >> closer [

	^ closer
]

{ #category : #accessing }
MicInlineDelimiter >> closer: anObject [

	closer := anObject
]

{ #category : #testing }
MicInlineDelimiter >> isEvaluated [
	"I am an opener whose resultering block will need further inline parsing"
	^ self isOpener and: [blockClass isEvaluated ]
]

{ #category : #testing }
MicInlineDelimiter >> isOpener [
	^ closer notNil or: [ markup = closer ]
]

{ #category : #testing }
MicInlineDelimiter >> isRawkind [
	"I am an opener whose resulting nodes body is not further parsed"
	^ self isOpener and: [ blockClass isEvaluated not ]
]

{ #category : #accessing }
MicInlineDelimiter >> markup [

	^ markup
]

{ #category : #accessing }
MicInlineDelimiter >> markup: anObject [

	markup := anObject
]

{ #category : #accessing }
MicInlineDelimiter >> markupAsRegex [
	"return a regex (as string) matching this delimiter"
	| str |
	str := WriteStream on: ''. 
	self isRawkind
		ifTrue: [ 
				markup do: [:char| str nextPut: $\;nextPut: char].
				str nextPutAll: (self class regexNot: closer).
				closer do: [:char| str nextPut: $\;nextPut: char]]
		ifFalse: [ markup do: [:char| str nextPut: $\;nextPut: char] ].
	^ str contents
]

{ #category : #printing }
MicInlineDelimiter >> printOn: stream [
	stream << $« << markup << $»
]
