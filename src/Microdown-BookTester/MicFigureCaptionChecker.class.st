Class {
	#name : 'MicFigureCaptionChecker',
	#superclass : 'MicChecker',
	#category : 'Microdown-BookTester',
	#package : 'Microdown-BookTester'
}

{ #category : 'visiting - inline elements' }
MicFigureCaptionChecker >> visitFigure: aFigure [
	| captionText |
	captionText := String streamContents: [ :stream | 
		aFigure children do: [ :child | stream nextPutAll: child plainText ] ].
	(captionText isEmpty or: [ (captionText anySatisfy: #isAlphaNumeric) not ]) ifTrue: [ 
		self results add: (MicMissingFigureCaptionResult new
			figure: aFigure;
			yourself) ].
			
	^ super visitFigure: aFigure
]
