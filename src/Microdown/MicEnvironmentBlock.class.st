"
An environment is delimited by a start and end markup, and it can have an argument list. 
By default, I do not handle any form of formatting in the arguments.

## Syntax

% Examples do not work (as of 06/23), it would be nice to show one.

```text

<!aTypeOfEnvironment|argument=value&argument2=value2
...
!>
```
Here is an example of a slide (subclass of `MicEnvironmentBlock`)

```text
<!slide|title=This is a cool title&tag=nh5p
- a list of bullets
- bullet 2
- bullet 3
!>
```

This is important for better column support in the future:

```text
<!slide|title=Class Methods!>

<!columns!>

<!column|width=60!>

![](file://figures/Point-xy-class-method.png width=90)
!>

<!column|width=40!>

- press the ==class== button to define a class method
- in lectures, we add ==class==
!>
!>
```
"
Class {
	#name : 'MicEnvironmentBlock',
	#superclass : 'MicStartStopMarkupBlock',
	#instVars : [
		'arguments'
	],
	#category : 'Microdown-Model',
	#package : 'Microdown',
	#tag : 'Model'
}

{ #category : 'documentation' }
MicEnvironmentBlock class >> addDocumentDefinedEnvironments: aBuilder [
	| currentDefinedTags |
	currentDefinedTags := self allSubclasses collect: [ :subclass | subclass tag -> subclass name].
	aBuilder newLine.
	aBuilder header: [ aBuilder text: 'Defined environments' ] withLevel: 2.
	aBuilder unorderedListDuring: [ 
		currentDefinedTags do: [:tagAndClass | 
			aBuilder item: [ 
				aBuilder 
					bold: [aBuilder text: tagAndClass key];
					text: ' defined by ';
					monospace: tagAndClass value
					]]
		 ]
]

{ #category : 'public' }
MicEnvironmentBlock class >> alternateBlockClassFor: line [

	"If there is one subclass with the corresponding tag, returns it, else return the current class."
	"line is of the form <!slide|title=Schedule"
	"We know that the two first characters are <! else we would not be invoked"

	| tag |
	tag := ((line allButFirst: EnvironmentOpeningBlockMarkup size) 
		        copyUpTo: $|) trimBoth.
	^ self extensionClassFor: tag
]

{ #category : 'documentation' }
MicEnvironmentBlock class >> buildMicroDownUsing: aBuilder withComment: aString [
	
	super buildMicroDownUsing: aBuilder withComment: aString.
	self addDocumentDefinedEnvironments: aBuilder
]

{ #category : 'visiting' }
MicEnvironmentBlock >> accept: aVisitor [
 	^ aVisitor visitEnvironment: self
]

{ #category : 'handle' }
MicEnvironmentBlock >> addLineAndReturnNextNode: line [
	"add line to this node. 
	Notice, the action is allowed to create new nodes in the block tree.
	Returns the node to handle next line - typically self."
	
	
	| withoutPreTabs |
	isClosed
		ifTrue: [ ^ self ].
	withoutPreTabs := line withoutPreTabs.
	"Here the withoutPreTabs is probably not necessary because handlingPrefixTabOfLine: should do its job."
	(self doesLineStartWithStopMarkup: withoutPreTabs)
		ifTrue: [ ^ self ].
	firstLine
		ifNil:
			[ firstLine := self extractFirstLineFrom: withoutPreTabs ]
		ifNotNil: [ ^ self bodyFromLine: withoutPreTabs ].
	^ self
]

{ #category : 'accessing' }
MicEnvironmentBlock >> arguments [
	
	^ arguments
]

{ #category : 'accessing' }
MicEnvironmentBlock >> body [

	^ String streamContents: [:s |  self bodyElements do: [ :each | s nextPutAll: each substring ] ]
]

{ #category : 'accessing' }
MicEnvironmentBlock >> bodyElements [

	^ children
]

{ #category : 'accessing' }
MicEnvironmentBlock >> bodyFromLine: line [
	
	| newBlock |
	newBlock := (self newBlockFor: line parent: self).
	self parser setCurrent: newBlock.
	^ newBlock
]

{ #category : 'parse support' }
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

{ #category : 'accessing' }
MicEnvironmentBlock >> environmentName [
	^ arguments at: #environmentName
]

{ #category : 'accessing' }
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

{ #category : 'initialization' }
MicEnvironmentBlock >> initialize [

	super initialize.
	arguments := MicArgumentList new 
		
]

{ #category : 'markups' }
MicEnvironmentBlock >> lineStartMarkup [

	^ EnvironmentOpeningBlockMarkup 
]

{ #category : 'markups' }
MicEnvironmentBlock >> lineStopMarkup [
	
	^ EnvironmentClosingBlockMarkup 
]

{ #category : 'handle' }
MicEnvironmentBlock >> massageLine: aLine [

	^ aLine withoutPreTabs
]
