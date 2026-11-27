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
	| lines addError |
	lines := aMicCode body lines reject: #isEmpty.
	
	addError := [ :line | 
		results add: (MicCodeIndentationResult new 
			micElement: aMicCode;
			inFile: aMicCode fromFile;
			detail: line;
			yourself) ].

	self leadingCharacters
		ifNil: [ 
			lines do: [ :line | 
				line first = Character space ifTrue: [ addError value: line ] ] ]
		ifNotNil: [ :leading | 
			leading isEmpty ifFalse: [ 
				| expectedChar expectedSize |
				expectedChar := leading first.
				expectedSize := leading size.
				
				lines do: [ :line | 
					line first = Character space ifTrue: [ 
						| count |
						count := line findFirst: [ :c | c ~= expectedChar ].
						count := count = 0 
							ifTrue: [ line size ] 
							ifFalse: [ count - 1 ].
							
						(count \\ expectedSize = 0) ifFalse: [ addError value: line ] ] ] ] ]
]
