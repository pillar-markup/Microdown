"
A MicRichTextFormatConfigurationTest is a test class for testing the behavior of MicRichTextFormatConfiguration
"
Class {
	#name : #MicRichTextFormatConfigurationTest,
	#superclass : #TestCase,
	#category : #'Microdown-RichTextComposer-Tests-Composer'
}

{ #category : #tests }
MicRichTextFormatConfigurationTest >> testBodyFont [
	| richText |
	richText := Microdown asRichText: '

foo bar'.
	self assert: (richText asMorph height < 50).
	richText := Microdown asRichText: '{!richtext|bodyFont=Lucida Grande;72!}

foo bar'.
	self assert: (richText asMorph height < 50).

]

{ #category : #tests }
MicRichTextFormatConfigurationTest >> testBullets [
	| src richText |
	src := '{!richtext|bullets=◊»!}
- aaa
  - bbb'.
	richText := Microdown asRichText: src.
	self assert: (richText asString includesSubstring: '◊	aaa').
	self assert: (richText asString includesSubstring: '»	bbb')
]

{ #category : #tests }
MicRichTextFormatConfigurationTest >> testCounters [
	| src richText |
	src := '{!richtext|counters=A1!}
1. aaa
   9. bbb'.
	richText := Microdown asRichText: src.
	self assert: (richText asString includesSubstring: 'A)	aaa').
	self assert: (richText asString includesSubstring: '1.	bbb')
]

{ #category : #tests }
MicRichTextFormatConfigurationTest >> testHeader1 [
	| src richText |
	src := '{!richtext|headerFont1=Lucida Grande;72!}
# Huge header'.
	richText := Microdown asRichText: src.
	self assert: (richText asMorph height > 150).
]

{ #category : #tests }
MicRichTextFormatConfigurationTest >> testHeader2 [
	| src richText |
	src := '{!richtext|headerFont2=Lucida Grande;72!}
## Huge header'.
	richText := Microdown asRichText: src.
	self assert: (richText asMorph height > 150).
]

{ #category : #tests }
MicRichTextFormatConfigurationTest >> testHeader3 [
	| src richText |
	src := '{!richtext|headerFont3=Lucida Grande;72!}
### Huge header'.
	richText := Microdown asRichText: src.
	self assert: (richText asMorph height > 150).
]

{ #category : #tests }
MicRichTextFormatConfigurationTest >> testHeader4 [
	| src richText |
	src := '{!richtext|headerFont4=Lucida Grande;72!}
#### Huge header'.
	richText := Microdown asRichText: src.
	self assert: (richText asMorph height > 150).
]

{ #category : #tests }
MicRichTextFormatConfigurationTest >> testHeader5 [
	| src richText |
	src := '{!richtext|headerFont5=Lucida Grande;72!}
##### Huge header'.
	richText := Microdown asRichText: src.
	self assert: (richText asMorph height > 150).
]

{ #category : #tests }
MicRichTextFormatConfigurationTest >> testHeader6 [
	| src richText |
	src := '{!richtext|headerFont6=Lucida Grande;72!}
###### Huge header'.
	richText := Microdown asRichText: src.
	self assert: (richText asMorph height > 150).
]

{ #category : #tests }
MicRichTextFormatConfigurationTest >> testIllegalArgument [
	| src richText |
	src := '{!richtext|foo=bar!}'.
	self should: [ 	richText := Microdown asRichText: src]
		raise: MicParsingError 
]

{ #category : #tests }
MicRichTextFormatConfigurationTest >> testInterBlockSpacing [ 
	| src richText |
	src := '{!richtext|interBlockSpacing=0!}fooo

bar

boo'.
	richText := Microdown asRichText: src.
	self assert: (richText asString lines size) equals: 3
]

{ #category : #tests }
MicRichTextFormatConfigurationTest >> testInterBlockSpacing_three [
	| src richText |
	src := '{!richtext|interBlockSpacing=3!}fooo

bar

boo'.
	richText := Microdown asRichText: src.
	self assert: (richText asString lines size) equals: 9
]

{ #category : #tests }
MicRichTextFormatConfigurationTest >> testNewLineIfNotAlready [
	| src richText |
	"newLineIfNotAlready mostely makes sense if interBlockSpacing is 0"
	src := '{!richtext|newLineIfNotAlready=cr;tab&interBlockSpacing=0!}
foo

bar'.
	richText := Microdown asRichText: src.
	self assert: (richText asString) equals: '
foo
	bar'
]

{ #category : #tests }
MicRichTextFormatConfigurationTest >> testSpaceAfterHeader [
	| src richText |
	"newLineIfNotAlready mostely makes sense if interBlockSpacing is 0"
	src := '{!richtext|crAfterHeader=2;2;1;1!}
# Header 1
## Header 2
### Header 3
#### Header 4
##### Header 5
###### Header 6'.
	richText := Microdown asRichText: src.
	self assert: (richText asString) equals: '
Header 1

Header 2

Header 3
Header 4
Header 5
Header 6
'
]
