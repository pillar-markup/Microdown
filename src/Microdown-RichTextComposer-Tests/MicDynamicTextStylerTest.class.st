"
A MicDynamicTextStylerTest is a test class for testing the behavior of MicDynamicTextStyler
"
Class {
	#name : #MicDynamicTextStylerTest,
	#superclass : #TestCase,
	#category : #'Microdown-RichTextComposer-Tests-Composer'
}

{ #category : #tests }
MicDynamicTextStylerTest >> testBulletForLevel [
	| styler |
	styler := MicDynamicTextStyler new.
	styler bullets: 'abc'.
	self assert: (styler bulletForLevel: 0) equals: 'a' asText.
	self assert: (styler bulletForLevel: 2) equals: 'c' asText.
	self assert: (styler bulletForLevel: 3) equals: 'a' asText.
]

{ #category : #tests }
MicDynamicTextStylerTest >> testCodeBackgroundColor [
	
]

{ #category : #tests }
MicDynamicTextStylerTest >> testCounterForAtLevel [
	| styler |
	styler := MicDynamicTextStyler new.
	styler counters: 'Aa1'.
	self assert: (styler counterFor: 1 atLevel: 1) equals: 'A)' asText.
	self assert: (styler counterFor: 2 atLevel: 2) equals: 'b)' asText.
	self assert: (styler counterFor: 3 atLevel: 3) equals: '3.' asText.
	self assert: (styler counterFor: 5 atLevel: 5) equals: 'e)' asText.
]

{ #category : #tests }
MicDynamicTextStylerTest >> testHeaderFontForLevel [
	| styler |
	styler := MicDynamicTextStyler new.
	styler headerFont: 'Source Sans Pro;72' forLevel: 1.
	self assert: (styler headerLevelFont: 1) familyName equals: 'Source Sans Pro'.
	self assert: (styler headerLevelFont: 1) pointSize equals: 72.
]

{ #category : #tests }
MicDynamicTextStylerTest >> testHeaderFontForLevel_wrongFormat [
	| styler |
	styler := MicDynamicTextStyler new.
	self 
		should: [ styler headerFont: 'Source Sans Pro' forLevel: 1 ]
	 	raise: MicParsingError .
	
]

{ #category : #tests }
MicDynamicTextStylerTest >> testHeaderFontForLevel_wrongLevel [
	| styler |
	styler := MicDynamicTextStyler new.
	self 
		should: [styler headerFont: 'Source Sans Pro;72' forLevel: 9]
		raise: MicParsingError
]

{ #category : #tests }
MicDynamicTextStylerTest >> testInterblockSpacing [
	| styler |
	styler := MicDynamicTextStyler new.
	self assert: styler interblockSpacing equals: String cr asText.
	styler interblockSpacing: '0'.
	self assert: styler interblockSpacing equals: '' asText.
	styler interblockSpacing: '2'.
	self assert: styler interblockSpacing equals: (String cr, String cr) asText
]

{ #category : #tests }
MicDynamicTextStylerTest >> testMonospaceBackgroundColor [
	| styler |
	styler := MicDynamicTextStyler new.
	self assert: styler monospaceBackgroundColor equals: Smalltalk ui theme settings windowColor.
	styler monospaceBackgroundColor: 'red'.
	self assert: styler monospaceBackgroundColor equals: Color red.
	styler monospaceBackgroundColor: '#FF0000'.
	self assert: styler monospaceBackgroundColor equals: Color red
	
]

{ #category : #tests }
MicDynamicTextStylerTest >> testNewLineIfNotAlready [
	| styler |
	styler := MicDynamicTextStyler new.
	self assert: styler newLineIfNotAlready equals: String cr asText.
	styler newLineIfNotAlready: 'tab'.
	self assert: styler newLineIfNotAlready equals: String tab asText.
	styler newLineIfNotAlready: 'cr;tab;space'.
	self assert: styler newLineIfNotAlready equals: (String cr, String tab, String space) asText
	
]
