"
I am the common class for two extension blocks that currently share the same syntax.
"
Class {
	#name : 'MicAbstractCodeBlock',
	#superclass : 'MicSameStartStopMarkupBlock',
	#category : 'Microdown-Model',
	#package : 'Microdown',
	#tag : 'Model'
}

{ #category : 'public' }
MicAbstractCodeBlock class >> alternateBlockClassFor: line [
	"This method is an extension point to be able to declare environment subclasses just specifying a tag.
	
	For example 
	
		<?Foo|title=Stef?>

	and a subclass of MicEnvironment with the tag 'Foo' exists then the parser will automatically
	create instances of such subclass.
	
	"
	
	"If there is one subclass with the corresponding tag, returns it, else resturn the current class."
	
	"line is of the form ```tag|title=Schedule - we should use MicArgumentList for parsing, but alas, we do not at the moment"

	| tag |
	tag := ((line allButFirst: CodeblockMarkup size) 
		        copyUpTo: $|) trimBoth.
	tag = #script ifTrue: [ ^ MicScriptBlock  ].
	^ MicScriptBlock allSubclasses detect: [ :each | each tag = tag ] ifNone: [ MicCodeBlock ]
]

{ #category : 'accessing' }
MicAbstractCodeBlock class >> defaultLanguage [
	^ 'Pharo'
]

{ #category : 'accessing' }
MicAbstractCodeBlock >> language [
	^ arguments at: #language
]

{ #category : 'utilities' }
MicAbstractCodeBlock >> lineStartMarkup [
	"a code block is delimited by ``` "
	
	^ CodeblockMarkup 
]
