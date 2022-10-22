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
		'closer',
		'opener'
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
	self new markup: AnchorReferenceCloserMarkup; blockClass: MicAnchorReferenceBlock; opener: false; closer: true; addMe.
	self new markup: AnchorReferenceOpenerMarkup; blockClass: MicAnchorReferenceBlock; opener: true; closer: false; addMe.
	self new markup: AnnotationCloserMarkup; blockClass: MicAnnotationBlock; opener: false; closer: true; addMe.
	self new markup: AnnotationOpenerMarkup; blockClass: MicAnnotationBlock; opener: true; closer: false; addMe.
	self new markup: BoldMarkup; blockClass: MicBoldFormatBlock; opener: true; closer: true; addMe.
	self new markup: FigureNameOpenerMarkup; blockClass: MicFigureBlock; opener: true; closer: false; addMe.
	self new markup: ItalicMarkup; blockClass: MicItalicFormatBlock; opener: true; closer: true; addMe.
	self new markup: MathMarkup; blockClass: MicMathInlineBlock; opener: true; closer: true; addMe.
	self new markup: MonospaceMarkup; blockClass: MicMonospaceFormatBlock; opener: true; closer: true; addMe.
	self new markup: RawCloserMarkup; blockClass: MicRawBlock; opener: false; closer: true; addMe.
	self new markup: RawOpenerMarkup; blockClass: MicRawBlock; opener: true; closer: false; addMe.
	self new markup: StrikeMarkup; blockClass: MicStrikeFormatBlock; opener: true; closer: true; addMe.
	self new markup: LinkNameCloserMarkup; blockClass: nil; opener: false; closer: true; addMe.
	self new markup: LinkNameOpenerMarkup; blockClass: MicLinkBlock; opener: true; closer: false; addMe.
]

{ #category : #'private utilities' }
MicInlineDelimiter class >> regExNot: markup [
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

{ #category : #accessing }
MicInlineDelimiter >> markup [

	^ markup
]

{ #category : #accessing }
MicInlineDelimiter >> markup: anObject [

	markup := anObject
]

{ #category : #'as yet unclassified' }
MicInlineDelimiter >> markupAsRegEx [
	| str |
	str := WriteStream on: ''. 
	blockClass isEvaluated
		ifFalse: [ 
				markup do: [:char| str nextPut: $\;nextPut: char].
				blockClass closingDelimiter in: [ :other |
					str nextPutAll: (self class regExNot: other).
					other do: [:char| str nextPut: $\;nextPut: char].
					 ]
				 ]
		ifTrue: [ markup do: [:char| str nextPut: $\;nextPut: char] ].
	^ str contents
]

{ #category : #accessing }
MicInlineDelimiter >> opener [

	^ opener
]

{ #category : #accessing }
MicInlineDelimiter >> opener: anObject [

	opener := anObject
]
