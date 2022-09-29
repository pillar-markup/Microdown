"
I am a plain text paragraph.

If am divided from other paragraphs by either a blank line, or one of the other markups.
"
Class {
	#name : #MicParagraphBlock,
	#superclass : #MicAbstractBlock,
	#instVars : [
		'text'
	],
	#category : #'Microdown-Model'
}

{ #category : #'instance creation' }
MicParagraphBlock class >> opensBy: aLine [
	^ aLine notEmpty 
]

{ #category : #visiting }
MicParagraphBlock >> accept: aVisitor [
 	^ aVisitor visitParagraph: self
]

{ #category : #parsing }
MicParagraphBlock >> addLineAndReturnNextNode: line [
	"add line to this node. 
	Notice, the action is allowed to create new nodes in the block tree.
	Returns the node to handle next line - typically self."

	text := self appendLine: line to: text
]

{ #category : #private }
MicParagraphBlock >> appendLine: line to: aString [

	^ aString
		ifNil: [ line trim ]
		ifNotNil: [ aString, String cr, line trim ]
]

{ #category : #private }
MicParagraphBlock >> asUnindented: line [
	"return a line where the indentation to my indentation level has been removed"

	^ line copyFrom: self indent + 1 to: line size
]

{ #category : #public }
MicParagraphBlock >> canConsumeLine: line [
	"A paragraph is closed by an empty line, "
	| unIndented |
	
	"if we are closing block that can contain other elements then do not consume their ends."
	(line isEmpty or: [ line beginsWith: EnvironmentClosingBlockMarkup]) 
		ifTrue: [ ^ false ].
	(self isRightlyIndented: line)
		ifFalse: [ ^ false ].
	unIndented := self asUnindented: line.
	"if the line was the start of a new block then paragraph does not consume it"
	^ (self blockStarterClassFrom: unIndented) = self class
]

{ #category : #'parse support' }
MicParagraphBlock >> closeMe [

	super closeMe.
	self children: (self inlineParse: text)
]

{ #category : #private }
MicParagraphBlock >> isRightlyIndented: line [
	"test if line has the appropriate number of spaces at first"

	self indent = 0
		ifTrue: [ ^ true ].
	^ line beginsWith: (' ' repeat: self indent)
]

{ #category : #accessing }
MicParagraphBlock >> text [
	^ text
]

{ #category : #accessing }
MicParagraphBlock >> textElements [
 
	^ children
]
