Class {
	#name : 'MicMethodReferenceChecker',
	#superclass : 'MicChecker',
	#category : 'Microdown-Rules-MethodeReference',
	#package : 'Microdown-Rules',
	#tag : 'MethodeReference'
}

{ #category : 'visiting - inline elements' }
MicMethodReferenceChecker >> visitText: aMicText [
	| text withHash withhoutHash |
	text := aMicText bodyString.
	text ifNil: [ ^ self ].
	withHash := text includesSubstring: '>>#'.
	withhoutHash := (RxMatcher forString: '>>[^#]') matchesIn: text.
	(withHash and: [ withhoutHash notEmpty ]) ifTrue: [ 
		results add: (MicMethodReferenceResult new 
			micElement: aMicText;
			inFile: aMicText;
			detail: text;
			yourself 
		)
		 ]
]
