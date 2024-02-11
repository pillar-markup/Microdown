"
A MicDynamicTextStylerTest is a test class for testing the behavior of MicDynamicTextStyler
"
Class {
	#name : 'MicDynamicTextStylerTest',
	#superclass : 'TestCase',
	#category : 'Microdown-RichTextComposer-Tests-Composer',
	#package : 'Microdown-RichTextComposer-Tests',
	#tag : 'Composer'
}

{ #category : 'tests' }
MicDynamicTextStylerTest >> testBodyFont [
	| styler |
	styler := MicDynamicTextStyler new.
	self assert: styler bodyFont equals: TextStyle defaultFont.
	styler bodyFont: 'Source Sans Pro;72'.
	self assert: styler bodyFont familyName equals: 'Source Sans Pro'.
	self assert: styler bodyFont pointSize equals: 72.
]

{ #category : 'tests' }
MicDynamicTextStylerTest >> testBulletForLevel [
	| styler |
	styler := MicDynamicTextStyler new.
	styler bullets: 'abc'.
	self assert: (styler bulletForLevel: 1) equals: 'a' asText.
	self assert: (styler bulletForLevel: 2) equals: 'b' asText.
	self assert: (styler bulletForLevel: 4) equals: 'a' asText.
]

{ #category : 'tests' }
MicDynamicTextStylerTest >> testBullets [
	"I am not needed as I am tested by testCounterForAtLevel, but being here marks counters: as tested"
]

{ #category : 'tests' }
MicDynamicTextStylerTest >> testCodeBackgroundColor [
	
]

{ #category : 'tests' }
MicDynamicTextStylerTest >> testCounterForAtLevel [
	| styler |
	styler := MicDynamicTextStyler new.
	styler counters: 'Aa1'.
	self assert: (styler counterFor: 1 atLevel: 1) equals: 'A)' asText.
	self assert: (styler counterFor: 2 atLevel: 2) equals: 'b)' asText.
	self assert: (styler counterFor: 3 atLevel: 3) equals: '3.' asText.
	self assert: (styler counterFor: 5 atLevel: 5) equals: 'e)' asText.
]

{ #category : 'tests' }
MicDynamicTextStylerTest >> testCounters [
	"I am not needed as I am tested by testCounterForAtLevel, but being here marks counters: as tested"
]

{ #category : 'tests' }
MicDynamicTextStylerTest >> testCrAfterHeader [
	| styler |
	styler := MicDynamicTextStyler new.
	self assert: styler crAfterHeaders equals: #(1 1 1 1 1 1).
	styler crAfterHeader: '2;2'.
	self assert: styler crAfterHeaders equals: #(2 2 1 1 1 1).
	
	
]

{ #category : 'tests' }
MicDynamicTextStylerTest >> testHeaderFontForLevel [
	| styler |
	styler := MicDynamicTextStyler new.
	styler headerFont: 'Source Sans Pro;72' forLevel: 1.
	self assert: (styler headerLevelFont: 1) font familyName equals: 'Source Sans Pro'.
	self assert: (styler headerLevelFont: 1) font pointSize equals: 72.
]

{ #category : 'tests' }
MicDynamicTextStylerTest >> testHeaderFontForLevel_wrongFormat [
	| styler |
	styler := MicDynamicTextStyler new.
	styler headerFont: 'Source Sans Pro' forLevel: 1.
	self assert: styler errors isNotEmpty 
	
]

{ #category : 'tests' }
MicDynamicTextStylerTest >> testHeaderFontForLevel_wrongLevel [
	| styler |
	styler := MicDynamicTextStyler new.
	styler headerFont: 'Source Sans Pro;72' forLevel: 9.
	self assert: styler errors isNotEmpty 
]

{ #category : 'tests' }
MicDynamicTextStylerTest >> testInterblockSpacing [
	| styler |
	styler := MicDynamicTextStyler new.
	self assert: styler interBlockSpacing equals: String cr asText.
	styler interBlockSpacing: '0'.
	self assert: styler interBlockSpacing equals: '' asText.
	styler interBlockSpacing: '2'.
	self assert: styler interBlockSpacing equals: (String cr, String cr) asText
]

{ #category : 'tests' }
MicDynamicTextStylerTest >> testKeepCRFromInput [
	| styler textSample|
	styler := MicDynamicTextStyler new.
	textSample := 'aaa\bbb' withCRs asText.
	self assert: (styler postTextTreatment: textSample copy) equals: textSample.
	styler keepCRFromInput: 'false'.
	self assert: (styler postTextTreatment: textSample copy) equals: 'aaa bbb' asText.
	
]

{ #category : 'tests' }
MicDynamicTextStylerTest >> testMonospaceBackgroundColor [
	| styler |
	styler := MicDynamicTextStyler new.
	self assert: styler monospaceBackgroundColor equals: Smalltalk ui theme settings windowColor.
	styler monospaceBackgroundColor: 'red'.
	self assert: styler monospaceBackgroundColor equals: Color red.
	styler monospaceBackgroundColor: '#FF0000'.
	self assert: styler monospaceBackgroundColor equals: Color red
	
]

{ #category : 'tests' }
MicDynamicTextStylerTest >> testNewLineIfNotAlready [
	| styler |
	styler := MicDynamicTextStyler new.
	self assert: styler newLineIfNotAlready equals: String cr asText.
	styler newLineIfNotAlready: 'tab'.
	self assert: styler newLineIfNotAlready equals: String tab asText.
	styler newLineIfNotAlready: 'cr;tab;space'.
	self assert: styler newLineIfNotAlready equals: (String cr, String tab, String space) asText
	
]
