"
I am a class that defines the text styles used by `MicRichTextComposer.
I control things like heading size, fonts for italic etc.

I am defining all these in class side methods, so to override and do something different, make a subclass of me and set `MicRichTextComposer` to use your new subclass (using `MicRichTextComposer>>textStyler:`). 
"
Class {
	#name : #MicTextStyler,
	#superclass : #Object,
	#category : #'Microdown-RichTextComposer'
}

{ #category : #accessing }
MicTextStyler class >> monospaceBackgroundColor [
	^ Smalltalk ui theme settings windowColor
]
