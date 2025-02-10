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
	
	| code richText blueLocation textColor |
	code := 'codeStylerFor: aString
<codeblockStylerFor: #smalltalk>

^bobby new 
isForWorkspace: blue; 
styledTextFor: aString asFest'.
	
	richText := (self stylerFor: 'method') style: code.
	
	self assert: richText asString trim equals: code trim.
	self assert: ((richText attributesAt: 2) includes: TextEmphasis bold).
	"Check that the unknown variable 'blue' is not colored red"
	blueLocation := richText asString findString: 'blue'.
	textColor := (richText attributesAt: blueLocation) detect: [ :attr | attr class = TextColor  ].
	self assert: textColor color red equals: 1.0.
]

{ #category : 'tests' }
MicRichTextCodeBlockStylerTest >> testStylerForSmalltalk [
	
	| code richText blueLocation textColor |
	code := '
green isColored: yellow

^ blue & red'.
	richText := (self stylerFor: 'Smalltalk') style: code.
	
	self assert: richText asString trim equals: code trim.
	"style smalltalk is assumes the code to be a code fragment, not a full method def"
	self assert: ((richText attributesAt: 2) includes: TextEmphasis bold) not.
	"Check that the unknown variable 'blue' is not colored red"
	blueLocation := richText asString findString: 'blue'.
	textColor := (richText attributesAt: blueLocation) detect: [ :attr | attr class = TextColor  ].
	self assert: textColor color red equals: 1.0.
]

{ #category : 'tests' }
MicRichTextCodeBlockStylerTest >> testStylersForText [

	| defaultStyler |
	defaultStyler := self stylerFor: 'text'.
	self assert: defaultStyler class equals: MicRichTextCodeBlockStylerUnstyledText
]
