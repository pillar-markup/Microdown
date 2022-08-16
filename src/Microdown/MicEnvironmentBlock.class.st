"
An environment is delimited by a start and end markup and it can have an argument list. 
By default I do not handle any form of formatting in the potential arguments.

## Syntax

```
<!aTypeOfEnvironment|argument=value&argument2=value2

!>
```
Here is an example of a slide (subclass of `MicEnvironmentBlock`)

```
<!slide|title=This is a cool title&tag=nh5p

- a list of bullet
- bullet 2
- bullet 3
!>
```



"
Class {
	#name : #MicEnvironmentBlock,
	#superclass : #MicStartStopMarkupBlock,
	#instVars : [
		'arguments'
	],
	#category : #'Microdown-Model'
}

{ #category : #public }
MicEnvironmentBlock class >> alternateBlockClassFor: line [

	"If there is one subclass with the corresponding tag, returns it, else resturn the current class."
	"line is of the form <!slide|title=Schedule"
	"We know that the two first characters are <? else we would be invoked"

	| tag |
	tag := ((line allButFirst: EnvironmentOpeningBlockMarkup size) 
		        copyUpTo: $|) trimBoth.
	^ self extensionClassFor: tag
]

{ #category : #visiting }
MicEnvironmentBlock >> accept: aVisitor [
 	^ aVisitor visitEnvironment: self
]

{ #category : #handle }
MicEnvironmentBlock >> addLineAndReturnNextNode: line [
	"add line to this node. 
	Notice, the action is allowed to create new nodes in the block tree.
	Returns the node to handle next line - typically self."
	
	isClosed
		ifTrue: [ ^ self ].
	(self doesLineStartWithStopMarkup: line)
		ifTrue: [ ^ self ].
	firstLine
		ifNil:
			[ firstLine := self extractFirstLineFrom: line ]
		ifNotNil: [ ^ self bodyFromLine: line ].
	^ self
]

{ #category : #accessing }
MicEnvironmentBlock >> arguments [
	
	^ arguments
]

{ #category : #'parse support' }
MicEnvironmentBlock >> body [

	^ String streamContents: [:s |  self bodyElements do: [ :each | s nextPutAll: each substring ] ]
]

{ #category : #'parse support' }
MicEnvironmentBlock >> bodyElements [

	^ children
]

{ #category : #'parse support' }
MicEnvironmentBlock >> bodyFromLine: line [
	
	| newBlock |
	newBlock := (self newBlockFor: line parent: self).
	self parser setCurrent: newBlock.
	^ newBlock
]

{ #category : #'parse support' }
MicEnvironmentBlock >> closeMe [

	"this is a temporary solution because normally the parser should populate body with MicBlocks.
	Right now just make sure that we have structured text = inline elements. "
	"body ifNotNil: [ 
		body :=  self inlineParse: body ].
	children := body"
	
	arguments := MicArgumentList 
		split: firstLine
		defaultArg: #environmentName
		defaultValue: ''.
]

{ #category : #accessing }
MicEnvironmentBlock >> environmentName [
	^ arguments at: #environmentName
]

{ #category : #accessing }
MicEnvironmentBlock >> extractFirstLineFrom: aLine [
	"we got <! env ...x !> foo bar or <! env ...x and we return env ...x "
	
	| extract |
	firstLine := super extractFirstLineFrom: aLine.
	firstLine := firstLine trimBoth.
	extract := firstLine copyUpToSubstring: EnvironmentClosingBlockMarkup.
	"we got !> ..."
	^ extract size < firstLine size 
		ifTrue: [ 
			isClosed := true.
			extract trimRight ]
		ifFalse: [ firstLine ]
]

{ #category : #markups }
MicEnvironmentBlock >> lineStartMarkup [

	^ EnvironmentOpeningBlockMarkup 
]

{ #category : #markups }
MicEnvironmentBlock >> lineStopMarkup [
	
	^ EnvironmentClosingBlockMarkup 
]
