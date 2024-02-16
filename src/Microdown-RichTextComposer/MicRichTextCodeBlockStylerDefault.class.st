"
I am a class for formating codeblocks containing smalltalk code fragments
"
Class {
	#name : 'MicRichTextCodeBlockStylerDefault',
	#superclass : 'MicRichTextCodeBlockStyler',
	#category : 'Microdown-RichTextComposer-Composer',
	#package : 'Microdown-RichTextComposer',
	#tag : 'Composer'
}

{ #category : 'accessing' }
MicRichTextCodeBlockStylerDefault class >> styleTags [
	^ #(default pharo smalltalk)
]

{ #category : 'accessing' }
MicRichTextCodeBlockStylerDefault >> style: sourceString [
	"I style a set of smalltalk expressions"

	^ MicCodeTextStyler new
		  isScripting: true;
		  styledTextFor: sourceString asText
]
