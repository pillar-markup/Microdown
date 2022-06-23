"
I am working in tandem with `MicFormatAnnotation` to allow control of the formatting of RichTextComposer within microdown.
```text
{!format|
hearder1Size=48&
header1Font=Papyrus&
bullets=-÷·
!}
```
"
Class {
	#name : #MicDynamicTextStyler,
	#superclass : #MicTextStyler,
	#instVars : [
		'bullets',
		'counters',
		'interblockSpacing',
		'defaultFont',
		'spaceAfterHeader',
		'monospaceBackgroundColor',
		'newLineIfNotAlready'
	],
	#category : #'Microdown-RichTextComposer-Composer'
}

{ #category : #initialization }
MicDynamicTextStyler >> bulletForLevel: level [
	^ ( bullets at: (level % bullets size)+1 ) asText.
]

{ #category : #accessing }
MicDynamicTextStyler >> bullets: anObject [

	bullets := anObject
]

{ #category : #'composer styles' }
MicDynamicTextStyler >> counterFor: counter atLevel: level [
	| kind |
	kind := counters at: (level-1 % counters size)+1.
	kind = $1
		ifTrue: [ ^ counter asString asText , '.' ].
	kind = $a
		ifTrue: [ ^ ($a asInteger + (counter - 1)) asCharacter asText , ')' ].
	kind = $A
		ifTrue: [ ^ ($A asInteger + (counter - 1)) asCharacter asText , ')' ]
]

{ #category : #accessing }
MicDynamicTextStyler >> counters: counterTypes [
	"counter types are 1 (number), a (small letters), A (capital letters)"
	counters := counterTypes
]

{ #category : #accessing }
MicDynamicTextStyler >> defaultFont: anObject [

	defaultFont := anObject
]

{ #category : #'composer styles' }
MicDynamicTextStyler >> headerFont: fontString forLevel: level [
	|list|
	(level between: 1 and: 6) 
		ifFalse: [ MicParsingError signal: 'Header levels are 1 to 6 - got: ', level printString ].
	list := (fontString splitOn: $;).
	list size = 2 
		ifFalse: [ MicParsingError signal: 'Font specs should be name;size - was: ',fontString  ].
	headerFonts 
		at: level 
		put: (LogicalFont 
						familyName: list first
						pointSize: list second asNumber)
]

{ #category : #initialization }
MicDynamicTextStyler >> initialize [
	self computeHeaderFonts. "super rely on lazy initilization"
	bullets := '•-'.
	counters := '1aA'.
	interblockSpacing := (String cr) asText.
	monospaceBackgroundColor := Smalltalk ui theme settings windowColor.
	newLineIfNotAlready := String cr asText.
	defaultFont := 0.
	spaceAfterHeader := 0.
]

{ #category : #'composer styles' }
MicDynamicTextStyler >> interblockSpacing [
	^ interblockSpacing 
]

{ #category : #accessing }
MicDynamicTextStyler >> interblockSpacing: spacingSpec [
	"I can put a number of cr between blocks. "
	interblockSpacing := ((String cr) repeat: (spacingSpec asNumber)) asText
]

{ #category : #'composer styles' }
MicDynamicTextStyler >> monospaceBackgroundColor [
	^ monospaceBackgroundColor 
]

{ #category : #accessing }
MicDynamicTextStyler >> monospaceBackgroundColor: colorString [

	monospaceBackgroundColor := Color fromString: colorString
]

{ #category : #'composer styles' }
MicDynamicTextStyler >> newLineIfNotAlready [ 
	^ newLineIfNotAlready 
]

{ #category : #'composer styles' }
MicDynamicTextStyler >> newLineIfNotAlready: spacingSpec [
	"add extra newline or tab indentation of the following line"
	"spacingSpec is (cr|tab|space)* with ; as seperator - for example 'cr;tab'"
	| commands |
	commands := { 'cr'->String cr. 'tab'->String tab. 'space'->String space } asDictionary.
	interblockSpacing := ((spacingSpec splitOn: ';') 
		collect: [ :spec | 
			commands 
				at: spec 
				ifAbsent: [ MicParsingError signal: 'allowed spacings are cr|tab|space, but got: ', spec ]])
		joinUsing: ''.
	interblockSpacing := interblockSpacing asText
]

{ #category : #'composer styles' }
MicDynamicTextStyler >> spaceAfterHeader: anObject [

	spaceAfterHeader := anObject
]
