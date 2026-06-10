"
I check that code blocks use tabs for indentation instead of spaces.
A line that starts with a space character is considered incorrectly indented.
"
Class {
	#name : 'MicCodeIndentationChecker',
	#superclass : 'MicChecker',
	#instVars : [
		'leadingCharacters'
	],
	#category : 'Microdown-BookTester-Checker-CodeIndentation',
	#package : 'Microdown-BookTester',
	#tag : 'Checker-CodeIndentation'
}

{ #category : 'public - name' }
MicCodeIndentationChecker class >> checkerName [

	^ 'CodeIndentation'
]

{ #category : 'visiting' }
MicCodeIndentationChecker >> leadingCharacters [
	^ leadingCharacters
]

{ #category : 'visiting' }
MicCodeIndentationChecker >> leadingCharacters: aString [
	leadingCharacters := aString
]

{ #category : 'visiting' }
MicCodeIndentationChecker >> visitCode: aMicCode [
	| expectedStart hasError |
	expectedStart := self leadingCharacters.
	
	(aMicCode body lines reject: #isEmpty) do: [ :line |
		hasError := expectedStart 
			ifNil: [ line first = Character space ]
			ifNotNil: [ (line beginsWith: expectedStart) not ].
			
		hasError ifTrue: [ 
			results add: (MicCodeIndentationResult new 
				micElement: aMicCode;
				inFile: aMicCode fromFile;
				detail: line;
				yourself) ] ]
]
