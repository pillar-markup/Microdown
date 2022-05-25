"
Paragraph extension to process the extended inlines.
"
Class {
	#name : #MdsParagraphBlock,
	#superclass : #MicParagraphBlock,
	#instVars : [
		'textWithoutBreak'
	],
	#pools : [
		'MdsConstants'
	],
	#category : #'Microdown-MarkdownStrict'
}

{ #category : #parising }
MdsParagraphBlock >> addLineAndReturnNextNode: line [

	super addLineAndReturnNextNode: line.
	textWithoutBreak := self appendLine: line to: textWithoutBreak.
	
	(line endsWith: InlineParagraphDelimiter) ifFalse: [ ^ self ].
	"add nodes up to now, then insert break and continue"
	children addAll: (self inlineParse: textWithoutBreak).
	children add: (MdsLineBreakBlock new).
	textWithoutBreak := nil
]

{ #category : #visiting }
MdsParagraphBlock >> closeMe [

	self children: self children, (self inlineParse: textWithoutBreak).
	textWithoutBreak := nil
]
