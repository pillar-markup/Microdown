"
I am a class that defines the text styles used by `MicRichTextComposer.
I control heading sizes and bullets.


I am defining all these in methods, so to override and do something different, make a subclass of me and set `MicRichTextComposer` to use your new subclass (using `MicRichTextComposer>>textStyler:`). 
"
Class {
	#name : #MicTextStyler,
	#superclass : #Object,
	#instVars : [
		'headerFonts'
	],
	#classInstVars : [
		'headerFonts'
	],
	#category : #'Microdown-RichTextComposer'
}

{ #category : #public }
MicTextStyler >> bulletForLevel: level [
	| kind |
	kind := level % 2.
	kind = 0
		ifTrue: [ ^ $• asText ].
	kind = 1
		ifTrue: [ ^ $- asText ]
]

{ #category : #private }
MicTextStyler >> computeHeaderFonts [
	
	headerFonts := Array new:  self headerFontSizes size.
	1 to: headerFonts size do: [ :index |
		headerFonts at: index put:
			(TextFontReference
				toFont:
					(StrikeFont
						familyName: 'Bitmap Source Sans Pro'
						pointSize: (self headerFontSizes at: index)))
			  ]
]

{ #category : #public }
MicTextStyler >> counterFor: counter atLevel: level [
	| kind |
	kind := level % 3.
	kind = 0
		ifTrue: [ ^ counter asString asText , '.' ].
	kind = 1
		ifTrue: [ ^ ($a asInteger + (counter - 1)) asCharacter asText , ')' ].
	kind = 2
		ifTrue: [ ^ ($A asInteger + (counter - 1)) asCharacter asText , ')' ]
]

{ #category : #public }
MicTextStyler >> headerFontSizes [
	^ #(18 14 12 11 10 10)
]

{ #category : #private }
MicTextStyler >> headerLevelFont: level [
	"I return a font annotation to be used with Attributes"
	headerFonts ifNil: [ self computeHeaderFonts  ].
	^ headerFonts at: level
]

{ #category : #public }
MicTextStyler >> monospaceBackgroundColor [
	^ Smalltalk ui theme settings windowColor
]
