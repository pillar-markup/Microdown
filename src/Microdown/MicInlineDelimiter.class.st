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

{ #category : #accessing }
MicInlineDelimiter class >> at: markup [
	"return delimiter at markup, or nil"
	^ DelimiterMap at: markup ifAbsent: [ nil ]
]

{ #category : #'private utilities' }
MicInlineDelimiter class >> generateInitialization [
	|tpl|
	self flag: #removeLater.
	tpl := '	self new markup: {1}; blockClass: {2}; closer: {3}; addMe.'. 
	^ (MicAbstractDelimiter allActive 
		collect: [ :cl | |markupName closer| 
			markupName := ((cl class>> #markup) allLiterals detect: [ :lit |lit isClassVariable ]) name asString.
			closer := cl isCloser ifFalse: [
				((cl associatedInlineBlock class >> #closingDelimiter) 
					allLiterals detect: [ :lit |lit isClassVariable ]) name asString] ifTrue: ['nil'].
			tpl format: { markupName . cl associatedInlineBlock printString. closer} ]
	) joinUsing: String cr.
]

{ #category : #initialization }
MicInlineDelimiter class >> initialize [
	<script>
	DelimiterMap := Dictionary new.
	self initializeDelimiters.
]

{ #category : #initialization }
MicInlineDelimiter class >> initializeDelimiters [
	self new markup: AnchorReferenceCloserMarkup; blockClass: MicAnchorReferenceBlock; closer: nil; addMe.
	self new markup: AnchorReferenceOpenerMarkup; blockClass: MicAnchorReferenceBlock; closer: AnchorReferenceCloserMarkup; addMe.
	self new markup: AnnotationCloserMarkup; blockClass: MicAnnotationBlock; closer: nil; addMe.
	self new markup: AnnotationOpenerMarkup; blockClass: MicAnnotationBlock; closer: AnnotationCloserMarkup; addMe.
	self new markup: BoldMarkup; blockClass: MicBoldFormatBlock; closer: nil; addMe.
	self new markup: FigureNameOpenerMarkup; blockClass: MicFigureBlock; closer: NameCloserUrlOpener; addMe.
	self new markup: ItalicMarkup; blockClass: MicItalicFormatBlock; closer: nil; addMe.
	self new markup: MathMarkup; blockClass: MicMathInlineBlock; closer: nil; addMe.
	self new markup: MonospaceMarkup; blockClass: MicMonospaceFormatBlock; closer: nil; addMe.
	self new markup: RawCloserMarkup; blockClass: MicRawBlock; closer: nil; addMe.
	self new markup: RawOpenerMarkup; blockClass: MicRawBlock; closer: RawCloserMarkup; addMe.
	self new markup: StrikeMarkup; blockClass: MicStrikeFormatBlock; closer: nil; addMe.
	self new markup: LinkNameOpenerMarkup; blockClass: MicLinkBlock; closer: NameCloserUrlOpener; addMe.
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
	^ blockClass isEvaluated 
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
MicInlineDelimiter >> markupAsRegex [
	"return a regex (as string) matching this delimiter"
	| str |
	str := WriteStream on: ''. 
	blockClass isEvaluated
		ifFalse: [ 
				markup do: [:char| str nextPut: $\;nextPut: char].
				blockClass closingDelimiter in: [ :other |
					str nextPutAll: (self class regexNot: other).
					other do: [:char| str nextPut: $\;nextPut: char].
					 ]
				 ]
		ifTrue: [ markup do: [:char| str nextPut: $\;nextPut: char] ].
	^ str contents
]

{ #category : #printing }
MicInlineDelimiter >> printOn: stream [
	stream << $« << markup << $»
]
