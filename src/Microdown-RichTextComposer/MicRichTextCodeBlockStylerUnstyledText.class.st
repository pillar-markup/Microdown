"
I am a class for formating codeblocks containing plain text
"
Class {
	#name : #MicRichTextCodeBlockStylerUnstyledText,
	#superclass : #MicRichTextCodeBlockStyler,
	#category : #'Microdown-RichTextComposer-Composer'
}

{ #category : #accessing }
MicRichTextCodeBlockStylerUnstyledText class >> styleTags [
	^ #(text)
]

{ #category : #accessing }
MicRichTextCodeBlockStylerUnstyledText >> style: aString [
	
	^ aString asText
]
