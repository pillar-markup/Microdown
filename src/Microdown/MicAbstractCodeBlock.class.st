"
I am common class for two extension blocks which at the moment shares the same syntax.
"
Class {
	#name : #MicAbstractCodeBlock,
	#superclass : #MicSameStartStopMarkupBlock,
	#category : #'Microdown-Model'
}

{ #category : #public }
MicAbstractCodeBlock class >> alternateBlockClassFor: line [

	"If there is one subclass with the corresponding tag, returns it, else resturn the current class."
	"line is of the form ```tag|title=Schedule - we should use MicArgumentList for parsing, but alas, we do not at the moment"

	| tag |
	tag := ((line allButFirst: CodeblockMarkup size) 
		        copyUpTo: $|) trimBoth.
	tag = #script ifTrue: [ ^ MicScriptBlock  ].
	^ MicScriptBlock allSubclasses detect: [ :each | each tag = tag ] ifNone: [ MicCodeBlock ]
]

{ #category : #accessing }
MicAbstractCodeBlock class >> defaultLanguage [
	^ 'Pharo'
]

{ #category : #accessing }
MicAbstractCodeBlock >> language [
	^ arguments at: #language
]

{ #category : #utilities }
MicAbstractCodeBlock >> lineStartMarkup [
	"a code block is delimited by ``` "
	
	^ CodeblockMarkup 
]
