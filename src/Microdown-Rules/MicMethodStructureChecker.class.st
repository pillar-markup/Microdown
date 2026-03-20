Class {
	#name : 'MicMethodStructureChecker',
	#superclass : 'MicChecker',
	#category : 'Microdown-Rules-MethodStructure',
	#package : 'Microdown-Rules',
	#tag : 'MethodStructure'
}

{ #category : 'visiting' }
MicMethodStructureChecker >> visitCode: aMicCode [
	| lines firstLine secondLine |
	lines := aMicCode body lines.
	lines size < 2 ifTrue: [ ^ self ].
	firstLine := lines first.
	secondLine := lines second.
	"If the second line begins with a comment, that's correct."
	(secondLine trimLeft beginsWith: '"') ifTrue: [ ^ self ].
	"If the second line is empty, it's correct."
	secondLine trimLeft isEmpty ifTrue: [ ^ self ].
	"ifelse, theres's a blank line missing after the selector"
	results  add: (MicMethodStructureResult new 
		micElement: aMicCode;
		inFile: aMicCode;
		detail: firstLine;
		yourself 
	)
]
