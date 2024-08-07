"
A MicInlineTokenStreamTest is a test class for testing the behavior of MicInlineTokenStream
"
Class {
	#name : 'MicInlineTokenStreamTest',
	#superclass : 'TestCase',
	#pools : [
		'MicMicrodownSharedPool'
	],
	#category : 'Microdown-Tests-InlineParser',
	#package : 'Microdown-Tests',
	#tag : 'InlineParser'
}

{ #category : 'tests' }
MicInlineTokenStreamTest >> testBackslash [
	| src tokens |
	src := 'aa\xbb'.
	tokens := (MicInlineTokenStream on: src) contents.
	self assert: tokens first string equals: 'aaxbb'
]

{ #category : 'tests' }
MicInlineTokenStreamTest >> testBackslash_AnchorReference [
	| src tokens |
	src := 'aa*@oo\xoo\@oo`@*bb'.
	tokens := (MicInlineTokenStream on: src) contents.
	self assert: tokens second string equals: '*@oo\xoo@oo`@*'
]

{ #category : 'tests' }
MicInlineTokenStreamTest >> testBackslash_InFormattedElements [
	| src tokens |
	src := 'aa**oo\xoo**bb'.
	tokens := (MicInlineTokenStream on: src) contents.
	self assert: tokens third string equals: 'ooxoo'
]

{ #category : 'tests' }
MicInlineTokenStreamTest >> testBackslash_InMath [
	| src tokens |
	src := 'aa$oo\xoo\$oo$bb'.
	tokens := (MicInlineTokenStream on: src) contents.
	self assert: tokens second string equals: '$oo\xoo$oo$'
]

{ #category : 'tests' }
MicInlineTokenStreamTest >> testBackslash_InMonospace [
	| src tokens |
	src := 'aa`oo\xoo\`oo`$bb'.
	tokens := (MicInlineTokenStream on: src) contents.
	self assert: tokens second string equals: '`oo\xoo`oo`'
]

{ #category : 'tests' }
MicInlineTokenStreamTest >> testBackslash_InRaw [
	| src tokens |
	src := 'aa{{oo\xoo\}oo`}}bb'.
	tokens := (MicInlineTokenStream on: src) contents.
	self assert: tokens second string equals: '{{oo\xoo}oo`}}'
]

{ #category : 'tests - linebreak' }
MicInlineTokenStreamTest >> testLineBreak [ 

	| src tokens |
	src := 'aa  bb'.
	tokens := (MicInlineTokenStream on: src) contents.
	self assert: tokens size equals: 3.
	self assert: tokens second string equals: '  '
]

{ #category : 'tests' }
MicInlineTokenStreamTest >> testTokenize [
	| tokens | 
	tokens := MicInlineTokenStream on: ''.
	self assert: tokens isEmpty
]

{ #category : 'tests' }
MicInlineTokenStreamTest >> testTokenize_Annotation [
	| tokens | 
	tokens := (MicInlineTokenStream on: 'aa',AnnotationOpenerMarkup ,'bbb', AnnotationCloserMarkup) contents.
	self assert: tokens second string equals: (AnnotationOpenerMarkup ,'bbb', AnnotationCloserMarkup).
	self assert: tokens second delimiter equals: (MicInlineDelimiter at: AnnotationOpenerMarkup)
]

{ #category : 'tests' }
MicInlineTokenStreamTest >> testTokenize_FigureWithURL [
	| tokens | 
	"anchors are not evaluated, but bodied directly"
	tokens := (MicInlineTokenStream on: 'aa',FigureNameOpenerMarkup  ,'bbb', NameCloserUrlOpener ,'ccc', URLCloserMarkup) contents.
	self assert: tokens second string equals: FigureNameOpenerMarkup.
	self assert: tokens second delimiter equals: (MicInlineDelimiter at: FigureNameOpenerMarkup).
	self assert: tokens fourth string equals: (NameCloserUrlOpener ,'ccc', URLCloserMarkup).
	self assert: tokens fourth delimiter equals: (MicInlineDelimiter at: NameCloserUrlOpener).
	
]

{ #category : 'tests' }
MicInlineTokenStreamTest >> testTokenize_Text [
	| tokens | 
	tokens := (MicInlineTokenStream on: 'aaaa') contents.
	self assert: tokens first string equals: 'aaaa'.
	self assert: tokens first delimiter markup equals: FixiousTextDelimiter.
]

{ #category : 'tests' }
MicInlineTokenStreamTest >> testTokenize_UrlPart [
	| tokens | 
	"anchors are not evaluated, but bodied directly"
	tokens := (MicInlineTokenStream on: 'aa',NameCloserUrlOpener ,'bbb', URLCloserMarkup) contents.
	self assert: tokens second string equals: (NameCloserUrlOpener ,'bbb', URLCloserMarkup).
	self assert: tokens second delimiter equals: (MicInlineDelimiter at: NameCloserUrlOpener)
]

{ #category : 'tests' }
MicInlineTokenStreamTest >> testTokenize_anchorRefs [
	| tokens | 
	"anchors are not evaluated, but bodied directly"
	tokens := (MicInlineTokenStream on: 'aa',AnchorReferenceOpenerMarkup ,'bbb', AnchorReferenceCloserMarkup) contents.
	self assert: tokens second string equals: (AnchorReferenceOpenerMarkup,'bbb', AnchorReferenceCloserMarkup).
	self assert: tokens second delimiter equals: (MicInlineDelimiter at: AnchorReferenceOpenerMarkup).
]

{ #category : 'tests' }
MicInlineTokenStreamTest >> testTokenize_bold [
	| tokens | 
	tokens := (MicInlineTokenStream on: 'aa',BoldMarkup ,'bbb') contents.
	self assert: tokens second string equals: BoldMarkup.
	self assert: tokens second delimiter equals: (MicInlineDelimiter at: BoldMarkup).
]

{ #category : 'tests' }
MicInlineTokenStreamTest >> testTokenize_figureName [
	| tokens | 
	"anchors are not evaluated, but bodied directly"
	tokens := (MicInlineTokenStream on: 'aa',FigureNameOpenerMarkup ,'bbb', NameCloserUrlOpener) contents.
	self assert: tokens second string equals: FigureNameOpenerMarkup.
	self assert: tokens second delimiter equals: (MicInlineDelimiter at: FigureNameOpenerMarkup)
]

{ #category : 'tests' }
MicInlineTokenStreamTest >> testTokenize_italic [
	| tokens | 
	tokens := (MicInlineTokenStream on: 'aa',ItalicMarkup ,'bbb') contents.
	self assert: tokens second string equals: ItalicMarkup.
	self assert: tokens second delimiter equals: (MicInlineDelimiter at: ItalicMarkup).
]

{ #category : 'tests' }
MicInlineTokenStreamTest >> testTokenize_linkName [
	| tokens | 
	"anchors are not evaluated, but bodied directly"
	tokens := (MicInlineTokenStream on: 'aa',LinkNameOpenerMarkup ,'bbb', NameCloserUrlOpener) contents.
	self assert: tokens second string equals: LinkNameOpenerMarkup.
	self assert: tokens second delimiter equals: (MicInlineDelimiter at: LinkNameOpenerMarkup)
]

{ #category : 'tests' }
MicInlineTokenStreamTest >> testTokenize_math [
	| tokens | 
	"anchors are not evaluated, but bodied directly"
	tokens := (MicInlineTokenStream on: 'aa', MathMarkup,'bbb', MathMarkup) contents.
	self assert: tokens second string equals: (MathMarkup,'bbb', MathMarkup).
	self assert: tokens second delimiter equals: (MicInlineDelimiter at: MathMarkup).
]

{ #category : 'tests' }
MicInlineTokenStreamTest >> testTokenize_monospace [
	| tokens | 
	"anchors are not evaluated, but bodied directly"
	tokens := (MicInlineTokenStream on: 'aa',MonospaceMarkup ,'bbb', MonospaceMarkup) contents.
	self assert: tokens second string equals: (MonospaceMarkup,'bbb', MonospaceMarkup).
	self assert: tokens second delimiter equals: (MicInlineDelimiter at: MonospaceMarkup).
]

{ #category : 'tests' }
MicInlineTokenStreamTest >> testTokenize_raw [
	| tokens | 
	"anchors are not evaluated, but bodied directly"
	tokens := (MicInlineTokenStream on: 'aa', RawOpenerMarkup ,'bbb', RawCloserMarkup) contents.
	self assert: tokens second string equals: (RawOpenerMarkup,'bbb', RawCloserMarkup).
	self assert: tokens second delimiter equals: (MicInlineDelimiter at: RawOpenerMarkup).
]

{ #category : 'tests' }
MicInlineTokenStreamTest >> testTokenize_strike [
	| tokens | 
	tokens := (MicInlineTokenStream on: 'aa',StrikeMarkup ,'bbb') contents.
	self assert: tokens second string equals: StrikeMarkup.
	self assert: tokens second delimiter equals: (MicInlineDelimiter at: StrikeMarkup).
]
