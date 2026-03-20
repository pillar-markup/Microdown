Class {
	#name : 'MicCodeIndentationChecker',
	#superclass : 'MicChecker',
	#category : 'Microdown-Rules-CodeIndetation',
	#package : 'Microdown-Rules',
	#tag : 'CodeIndetation'
}

{ #category : 'visiting' }
MicCodeIndentationChecker >> visitCode: aMicCode [
	| lines |
	lines := aMicCode body lines.
	lines do: [ :line |
		line isEmpty ifFalse: [ 
			"verify if the line begin with space"
			(line first = Character space) ifTrue: [ 
				"except the space in the code like nextPut: ' '"
				(line trimLeft includesSubstring: 'nextPut: '' ''') ifFalse: [ 
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
]
