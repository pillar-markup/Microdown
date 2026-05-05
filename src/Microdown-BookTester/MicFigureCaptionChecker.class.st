Class {
	#name : 'MicFigureCaptionChecker',
	#superclass : 'MicChecker',
	#instVars : [
		'checkFigure',
		'checkCode',
		'checkMath'
	],
	#category : 'Microdown-BookTester',
	#package : 'Microdown-BookTester'
}

{ #category : 'accessing' }
MicFigureCaptionChecker >> checkCode [

	^ checkCode
]

{ #category : 'accessing' }
MicFigureCaptionChecker >> checkCode: anObject [

	checkCode := anObject
]

{ #category : 'accessing' }
MicFigureCaptionChecker >> checkFigure [

	^ checkFigure
]

{ #category : 'accessing' }
MicFigureCaptionChecker >> checkFigure: anObject [

	checkFigure := anObject
]

{ #category : 'accessing' }
MicFigureCaptionChecker >> checkMath [

	^ checkMath
]

{ #category : 'accessing' }
MicFigureCaptionChecker >> checkMath: anObject [

	checkMath := anObject
]

{ #category : 'visiting - inline elements' }
MicFigureCaptionChecker >> checkMissingCaptionIn: aBlock text: captionText [
	(captionText isEmpty or: [ (captionText anySatisfy: #isAlphaNumeric) not ]) ifTrue: [ 
		self results add: (MicMissingFigureCaptionResult new
			figure: aBlock; 
			yourself) ]
]

{ #category : 'visiting - inline elements' }
MicFigureCaptionChecker >> initialize [
	super initialize.
	checkFigure := true.
	checkCode := true.
	checkMath := true.
]

{ #category : 'visiting - inline elements' }
MicFigureCaptionChecker >> visitCode: aCode [
	| captionText |
	
	self checkCode ifTrue: [ 
		captionText := ' ' join: (aCode captionElements collect: [ :each | each text ]).
		self checkMissingCaptionIn: aCode text: captionText ].
		
	^ super visitCode: aCode
]

{ #category : 'visiting - inline elements' }
MicFigureCaptionChecker >> visitFigure: aFigure [
	| captionText |
	
	self checkFigure ifTrue: [ 
		captionText := String streamContents: [ :stream | 
			aFigure children do: [ :child | stream nextPutAll: child plainText ] ].
		self checkMissingCaptionIn: aFigure text: captionText ].
		
	^ super visitFigure: aFigure
]

{ #category : 'visiting - inline elements' }
MicFigureCaptionChecker >> visitMath: aMath [
	| captionText |
	
	self checkMath ifTrue: [ 
		captionText := ' ' join: (aMath captionElements collect: [ :each | each text ]).
		self checkMissingCaptionIn: aMath text: captionText ].
		
	^ super visitMath: aMath
]
