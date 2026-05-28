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

	^ leadingCharacters ifNil: [ ' ' ]
]

{ #category : 'visiting' }
MicCodeIndentationChecker >> leadingCharacters: aString [

	leadingCharacters := aString
]

{ #category : 'visiting' }
MicCodeIndentationChecker >> visitCode: aMicCode [

	| lines expectedChar expectedSize |
	self leadingCharacters isEmpty ifTrue: [ ^ self ].
	expectedChar := self leadingCharacters first.
	expectedSize := self leadingCharacters size.

	lines := aMicCode body lines.
	lines do: [ :line |
		line isEmpty ifFalse: [ 
			| count |
			count := line findFirst: [ :c | c ~= expectedChar ].
			count := count = 0 
				ifTrue: [ line size ] 
				ifFalse: [ count - 1 ].
			
			(count \\ expectedSize = 0) ifFalse: [ 
					results add: (MicCodeIndentationResult new 
						micElement: aMicCode;
						inFile: aMicCode fromFile;
						detail: line;
						yourself
					)
				 ]
			 ]
		 ]
]
