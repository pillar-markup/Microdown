Class {
	#name : #MicRichTextCodeBlockStylerDummyForTest,
	#superclass : #MicRichTextCodeBlockStyler,
	#category : #'Microdown-RichTextComposer-Tests-Composer'
}

{ #category : #accessing }
MicRichTextCodeBlockStylerDummyForTest class >> styleTags [ 
	^ #(dummyForTest)
]

{ #category : #accessing }
MicRichTextCodeBlockStylerDummyForTest >> style: sString [
	^ '§dummy§' asText
]
