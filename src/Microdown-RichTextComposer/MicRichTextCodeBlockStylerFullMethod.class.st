"
I am a class for formating codeblocks containing smalltalk methods
"
Class {
	#name : #MicRichTextCodeBlockStylerFullMethod,
	#superclass : #MicRichTextCodeBlockStyler,
	#category : #'Microdown-RichTextComposer-Composer'
}

{ #category : #accessing }
MicRichTextCodeBlockStylerFullMethod class >> styleTags [
	^ #(method)
]

{ #category : #accessing }
MicRichTextCodeBlockStylerFullMethod >> style: sourceString [

	| source styler ast |
	source := sourceString asText.
	styler := MicSmalltalkTextStyler new.
	ast := self class compiler
		       source: source asString;
		       parse.
	styler style: source ast: ast.
	^ source 
]
