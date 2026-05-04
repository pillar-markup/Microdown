Class {
	#name : 'MicFigureCaptionChecker',
	#superclass : 'MicChecker',
	#category : 'Microdown-BookTester',
	#package : 'Microdown-BookTester'
}

{ #category : 'visiting - inline elements' }
MicFigureCaptionChecker >> visitCode: aCode [
	| captionText |
	captionText := ' ' join: (aCode captionElements collect: [ :each | each text ]).
	(captionText isEmpty or: [ (captionText anySatisfy: #isAlphaNumeric) not ]) ifTrue: [ 
		self results add: (MicMissingFigureCaptionResult new
			figure: aCode;
			yourself) ].
			
	^ super visitCode: aCode
]

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

{ #category : 'visiting - inline elements' }
MicFigureCaptionChecker >> visitMath: aMath [
	| captionText |
	captionText := ' ' join: (aMath captionElements collect: [ :each | each text ]).
	(captionText isEmpty or: [ (captionText anySatisfy: #isAlphaNumeric) not ]) ifTrue: [ 
		self results add: (MicMissingFigureCaptionResult new
			figure: aMath;
			yourself) ].
			
	^ super visitMath: aMath
]
