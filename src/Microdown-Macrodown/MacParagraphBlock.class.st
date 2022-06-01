"
Paragraph extension to process the extended inlines.
"
Class {
	#name : #MacParagraphBlock,
	#superclass : #MicParagraphBlock,
	#instVars : [
		'textWithoutBreak'
	],
	#pools : [
		'MacConstants'
	],
	#category : #'Microdown-Macrodown'
}

{ #category : #parising }
MacParagraphBlock >> addLineAndReturnNextNode: line [

	super addLineAndReturnNextNode: line.
	textWithoutBreak := self appendLine: line to: textWithoutBreak.
	
	(line endsWith: InlineParagraphDelimiter) ifFalse: [ ^ self ].
	"add nodes up to now, then insert break and continue"
	children addAll: (self inlineParse: textWithoutBreak).
	children add: (MacLineBreakBlock new).
	textWithoutBreak := nil
]

{ #category : #visiting }
MacParagraphBlock >> closeMe [

	textWithoutBreak ifNil: [ 
		"means is already closed"
		^ self ]. 
	self children: self children, (self inlineParse: textWithoutBreak).
	textWithoutBreak := nil
]
