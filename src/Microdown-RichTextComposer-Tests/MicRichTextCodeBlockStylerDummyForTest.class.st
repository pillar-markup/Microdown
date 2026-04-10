Class {
	#name : 'MicRichTextCodeBlockStylerDummyForTest',
	#superclass : 'MicRichTextCodeBlockStyler',
	#category : 'Microdown-RichTextComposer-Tests-Composer',
	#package : 'Microdown-RichTextComposer-Tests',
	#tag : 'Composer'
}

{ #category : 'accessing' }
MicRichTextCodeBlockStylerDummyForTest class >> styleTags [ 
	^ #(dummyForTest)
]

{ #category : 'accessing' }
MicRichTextCodeBlockStylerDummyForTest >> style: sString [
	^ '§dummy§' asText
]
