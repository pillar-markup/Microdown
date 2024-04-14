"
I am a class for formating codeblocks containing smalltalk methods
"
Class {
	#name : 'MicRichTextCodeBlockStylerFullMethod',
	#superclass : 'MicRichTextCodeBlockStyler',
	#category : 'Microdown-RichTextComposer-Composer',
	#package : 'Microdown-RichTextComposer',
	#tag : 'Composer'
}

{ #category : 'accessing' }
MicRichTextCodeBlockStylerFullMethod class >> styleTags [
	^ #(method)
]

{ #category : 'accessing' }
MicRichTextCodeBlockStylerFullMethod >> style: sourceString [

	| source styler ast |
	source := sourceString asText.
	styler := MicSmalltalkTextStyler new.
	ast := self class compiler       
		source: source asString;
		"the optionParseErrors is to allow code with syntax errors, just as when you type in the editor
		optionSkipSemanticWarnings stops writing errors to Transcript"
		options: #( + optionParseErrors + optionSkipSemanticWarnings );
		parse.
	styler style: source ast: ast.
	^ source 
]
