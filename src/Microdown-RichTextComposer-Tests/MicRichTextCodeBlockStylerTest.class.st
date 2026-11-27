"
A MicRichTextCodeBlockStylerTest is a test class for testing the behavior of MicRichTextCodeBlockStyler
"
Class {
	#name : 'MicRichTextCodeBlockStylerTest',
	#superclass : 'TestCase',
	#category : 'Microdown-RichTextComposer-Tests-Composer',
	#package : 'Microdown-RichTextComposer-Tests',
	#tag : 'Composer'
}

{ #category : 'helpers' }
MicRichTextCodeBlockStylerTest >> colorOf: aWord in: aText [
	"Answer the color of the first occurrence of aWord in aText."

	^ ((aText attributesAt: (aText asString findString: aWord)) detect: [ :attribute | attribute class = TextColor ]) color
]

{ #category : 'accessing' }
MicRichTextCodeBlockStylerTest >> stylerFor: aLanguage [
	^ MicRichTextCodeBlockStyler stylerFor: aLanguage
]

{ #category : 'tests' }
MicRichTextCodeBlockStylerTest >> testDefaultStylerIsFound [

	| defaultStyler |
	defaultStyler := self stylerFor: 'blblbl'.
	self assert: defaultStyler class equals: MicRichTextCodeBlockStylerDefault
]

{ #category : 'tests' }
MicRichTextCodeBlockStylerTest >> testStylerForMethod [

	| code richText |
	code := 'codeStylerFor: aString
<codeblockStylerFor: #smalltalk>

^bobby new 
isForWorkspace: blue; 
styledTextFor: aString asFest'.

	richText := (self stylerFor: 'method') style: code.

	self assert: richText asString trim equals: code trim.
	self assert: ((richText attributesAt: 2) includes: TextEmphasis bold).
	"The unknown variable blue is not colored as undefined, as the standard styler does."
	self deny: (self colorOf: 'blue' in: richText) equals: (self colorOf: 'blue' in: (SHRBTextStyler new styledTextFor: code asText))
]

{ #category : 'tests' }
MicRichTextCodeBlockStylerTest >> testStylerForSmalltalk [

	| code richText |
	code := '
green isColored: yellow

^ blue & red'.
	richText := (self stylerFor: 'Smalltalk') style: code.

	self assert: richText asString trim equals: code trim.
	"style smalltalk is assumes the code to be a code fragment, not a full method def"
	self deny: ((richText attributesAt: 2) includes: TextEmphasis bold).
	"The unknown variable blue is not colored as undefined, as the standard styler does."
	self deny: (self colorOf: 'blue' in: richText) equals: (self colorOf: 'blue' in: (SHRBTextStyler new styledTextFor: code asText))
]

{ #category : 'tests' }
MicRichTextCodeBlockStylerTest >> testStylersForText [

	| defaultStyler |
	defaultStyler := self stylerFor: 'text'.
	self assert: defaultStyler class equals: MicRichTextCodeBlockStylerUnstyledText
]
