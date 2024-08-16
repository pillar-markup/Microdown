"
I am a smalltalk code styler which renders undefined variables and methods same color as defined.
I am used to render smalltalk codeblocks.
"
Class {
	#name : 'MicSmalltalkTextStyler',
	#superclass : 'SHRBTextStyler',
	#category : 'Microdown-RichTextComposer-Composer',
	#package : 'Microdown-RichTextComposer',
	#tag : 'Composer'
}

{ #category : 'class initialization' }
MicSmalltalkTextStyler class >> initialize [
	"I have my own set of class side variables. I should not, but alas, so it is"

	"do not super initialize, that whould interfer with settings"

	styleTable := SHRBTextStyler styleTable. "Not super, as that would just refer to my class-side variables"
	textAttributes := nil.
	formatIncompleteIdentifiers := false
]

{ #category : 'instance creation' }
MicSmalltalkTextStyler class >> new [
	"I need to stay in sync with my superclass, so I initilize on each instantiation. Performance says a few micro seconds, so OK"
	self styleTable = SHRBTextStyler styleTable "style table was changed"
		ifFalse: [ self initialize ]. 
	^ super new 
]

{ #category : 'private' }
MicSmalltalkTextStyler >> attributesFor: aSymbol [

	| symbol |
	symbol := aSymbol.
	
	"In microdown we do not want a special color for undefinied selectors and identifiers so we just ask the common color instead."
	symbol = #undefinedIdentifier ifTrue: [ symbol := #instVar ].
	symbol = #undefinedSelector ifTrue: [ symbol := #patternSelector ].
	^ super attributesFor: symbol
]

{ #category : 'private' }
MicSmalltalkTextStyler >> resolveStyleFor: aVariableNode [
	"This circumvent an error in my super"
	aVariableNode isUndeclaredVariable ifTrue: [ ^#undefinedIdentifier ].
	^ super resolveStyleFor: aVariableNode
]

{ #category : 'styling' }
MicSmalltalkTextStyler >> styledTextFor: aText [ 
	aText ifEmpty: [ ^ aText ].
	^self privateStyle: aText
]
