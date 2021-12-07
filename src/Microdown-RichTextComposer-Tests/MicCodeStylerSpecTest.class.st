"
A MicCodeStylerSpecTest is a test class for testing the behavior of MicCodeStylerSpec
"
Class {
	#name : #MicCodeStylerSpecTest,
	#superclass : #TestCase,
	#category : #'Microdown-RichTextComposer-Tests-Composer'
}

{ #category : #tests }
MicCodeStylerSpecTest >> testStylerForMethod [
	
	| code richText blueLocation textColor |
	code := '
codeStylerFor: aString
<codeblockStylerFor: #smalltalk>

^bobby new 
isForWorkspace: blue; 
styledTextFor: aString asFest'.
	
	richText := MicCodeStylerSpec style: code asLanguage: 'Method'.
	
	self assert: richText asString trim equals: code trim.
	self assert: ((richText attributesAt: 2) includes: TextEmphasis bold).
	"Check that the unknown variable 'blue' is not colored red"
	blueLocation := richText asString findString: 'blue'.
	textColor := (richText attributesAt: blueLocation) detect: [ :attr | attr class = TextColor  ].
	self assert: textColor color red equals: 0.
]

{ #category : #tests }
MicCodeStylerSpecTest >> testStylerForSmalltalk [
	
	| code richText blueLocation textColor |
	code := '
green isColored: yellow

^ blue & red'.
	richText := MicCodeStylerSpec style: code asLanguage: 'Smalltalk'.
	
	self assert: richText asString trim equals: code trim.
	"style smalltalk is assumes the code to be a code fragment, not a full method def"
	self assert: ((richText attributesAt: 2) includes: TextEmphasis bold) not.
	"Check that the unknown variable 'blue' is not colored red"
	blueLocation := richText asString findString: 'blue'.
	textColor := (richText attributesAt: blueLocation) detect: [ :attr | attr class = TextColor  ].
	self assert: textColor color red equals: 0.
]

{ #category : #'tests - stylers' }
MicCodeStylerSpecTest >> testStylersAreRegistered [

	| defaultStyler |
	defaultStyler := MicCodeStylerSpec styleFor: 'blblbl'.
	self assert: defaultStyler selector equals: #defaultStyler:
]

{ #category : #'tests - stylers' }
MicCodeStylerSpecTest >> testStylersForText [

	| defaultStyler |
	defaultStyler := MicCodeStylerSpec styleFor: 'text'.
	self assert: defaultStyler selector equals: #textStyler:.
	 "Stylers are used for codeblock, and a test should be included for this"
]
