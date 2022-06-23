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
		'spaceAfterHeader',
		'monospaceBackgroundColor',
		'newLineIfNotAlready',
		'bodyFont'
	],
	#category : #'Microdown-RichTextComposer-Composer'
}

{ #category : #accessing }
MicDynamicTextStyler >> bodyFont [
	^ bodyFont 
]

{ #category : #accessing }
MicDynamicTextStyler >> bodyFont: fontSpec [
	|list|
	list := (fontSpec splitOn: $;).
	list size = 2 
		ifFalse: [ MicParsingError signal: 'Font specs should be name;size - was: ',fontSpec  ].
	bodyFont := LogicalFont 
			familyName: list first
			pointSize: list second asNumber
]

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
	bodyFont := TextStyle defaultFont.
	spaceAfterHeader := #(1 1 1 1 1 1).
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
	| commands spacing|
	commands := { 'cr'->String cr. 'tab'->String tab. 'space'->String space } asDictionary.
	spacing := ((spacingSpec splitOn: ';') 
		collect: [ :spec | 
			commands 
				at: spec 
				ifAbsent: [ MicParsingError signal: 'allowed spacings are cr|tab|space, but got: ', spec ]])
		joinUsing: ''.
	newLineIfNotAlready := spacing asText
]

{ #category : #initialization }
MicDynamicTextStyler >> spaceAfterHeader [
	^ spaceAfterHeader 
]

{ #category : #'composer styles' }
MicDynamicTextStyler >> spaceAfterHeader: spacingSpec [
	"spacingSpec is a series of numbers 2;2;1;1 - which is the number of new lines to be added 
	after headers of level1, level2 etc. 1's at the end can be omitted (2;2;1;1 is the same as 2;2)"
	|spacings|
	spaceAfterHeader := #(1 1 1 1 1 1) copy. "copy to get non-literal"
	spacings := ((spacingSpec splitOn: ';') truncateTo: 6) collect: [ :spec |spec asNumber ].
	spacings doWithIndex: [ :elem :index |spaceAfterHeader at: index put: elem ]
]
