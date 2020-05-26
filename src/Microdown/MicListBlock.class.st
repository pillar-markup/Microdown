"
I am an abstract class for the two kind of lists, ordered and unordered.
When I created I automatically add a listitem as my child.

An empty or a wrong indent close me.

I look like this:

- bullet list item 1
- bullet list item 2
  - sublist item 2.1
  - sublist item 2.2
- bullet list item 3

Indentation matters and is crucial
"
Class {
	#name : #MicListBlock,
	#superclass : #MicAbstractBlock,
	#instVars : [
		'indent'
	],
	#category : #'Microdown-Model'
}

{ #category : #testing }
MicListBlock >> addLineAndReturnNextNode: inLine [
	"Create a new item, and insert it into me.
	line is on the format 'markup text'"

	| line |
	line := inLine trim.
	self indentFromLine: line.
	^ self listItemBlockClass new
		setParser: parser; 
		parent: self;
		addLineAndReturnNextNode: (line copyFrom: indent - parent indent to: line size)
]

{ #category : #testing }
MicListBlock >> canConsumeLine: line [
	"to consume this line there must be a ListItem starting at the right indentation"
	
	line ifEmpty: [ ^ false ].
	(parent indent = 0
		or: [ line beginsWith: (' ' repeat: parent indent) ])
		ifFalse: [ ^ false ].
	^true
]

{ #category : #accessing }
MicListBlock >> indent [
	^ indent
]

{ #category : #indent }
MicListBlock >> indentFromLine: aLine [
	"The line is expected to have the form: '<bullet> space+ [text]', where bullet is one of *,+,- or 1. or 1). More than one space is allowed. 
	indentFromLine returns the position of the last character before the text.
	The indentation returned is *the number of characters*, that is, tab counts for but one char."

	| regEx |
	indent ifNotNil: [ ^self ].
	regEx := '(\S+)(\s*)' asRegex.
	regEx matchesPrefix: aLine.
	indent := parent indent + (regEx subexpression: 1) size
]
