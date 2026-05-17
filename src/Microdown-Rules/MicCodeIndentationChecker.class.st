"
I check that code blocks use tabs for indentation instead of spaces.
A line that starts with a space character is considered incorrectly indented.
"
Class {
	#name : 'MicCodeIndentationChecker',
	#superclass : 'MicChecker',
	#category : 'Microdown-Rules-CodeIndentation',
	#package : 'Microdown-Rules',
	#tag : 'CodeIndentation'
}

{ #category : 'public - name' }
MicCodeIndentationChecker class >> checkerName [

	^ 'CodeIndentation'
]

{ #category : 'visiting' }
MicCodeIndentationChecker >> visitCode: aMicCode [
	| lines |
	lines := aMicCode body lines.
	lines do: [ :line |
		line isEmpty ifFalse: [ 
			"verify if the line begin with space"
			(line first = Character space) ifTrue: [ 
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
