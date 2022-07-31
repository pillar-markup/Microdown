"
I am a block that holds a MicDynamicTextStyler, gettings its values from a MicArgumentList.
I support the following arguments: {!richtext|bullets=◊»!}
- bodyFont
- bullets
- counters
- header fonts
  - headerFont1
  - headerFont2
  - headerFont3
  - headerFont4
  - headerFont5
  - headerFont6
- interblockSpacing
- monospaceBackgroundColor
- newLineIfNotAlready
- spaceAfterHeader
"
Class {
	#name : #MicRichTextFormatConfiguration,
	#superclass : #MicAnnotationBlock,
	#category : #'Microdown-RichTextComposer-Composer'
}

{ #category : #accessing }
MicRichTextFormatConfiguration class >> tag [
	^ #richtext
]

{ #category : #visiting }
MicRichTextFormatConfiguration >> accept: visitor [
	visitor visitRichTextFormatConfiguration: self
]

{ #category : #visiting }
MicRichTextFormatConfiguration >> adjustStyler: styler [
	| setters |
	setters := self setterDictionaryFor: styler.
	arguments justTheArguments  keysAndValuesDo: [ :key :value |
		setters at: key 
			ifPresent: [ :block | block value: value]
			ifAbsent: [ MicParsingError signal: 'richtext annotation - unknown argument: ', key ]
		 ].
]

{ #category : #private }
MicRichTextFormatConfiguration >> setterDictionaryFor: styler [
	^ {	
	'bullets' -> [ :a | styler bullets: a].
	'counters' -> [ :a | styler counters: a].
	'interBlockSpacing' -> [ :a | styler interBlockSpacing: a].
	'crAfterHeader' -> [ :a | styler crAfterHeader: a].
	'monospaceBackgroundColor' -> [ :a | styler monospaceBackgroundColor: a].
	'newLineIfNotAlready' -> [ :a | styler newLineIfNotAlready: a].
	'keepCRFromInput' -> [ :a | styler keepCRFromInput: a ].
	'bodyFont' -> [ :a | styler bodyFont: a].
	'headerFont1' -> [ :a | styler headerFont: a forLevel: 1].
	'headerFont2' -> [ :a | styler headerFont: a forLevel: 2].
	'headerFont3' -> [ :a | styler headerFont: a forLevel: 3].
	'headerFont4' -> [ :a | styler headerFont: a forLevel: 4].
	'headerFont5' -> [ :a | styler headerFont: a forLevel: 5].
	'headerFont6' -> [ :a | styler headerFont: a forLevel: 6].
	} asDictionary
]
