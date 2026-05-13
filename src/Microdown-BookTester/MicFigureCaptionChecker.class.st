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
MicFigureCaptionChecker >> checkCaptionOf: aBlock [
	(self hasCorrectCaption: aBlock caption) ifFalse: [ 
		self results add: MicMissingFigureCaptionResult new ]
]

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
MicFigureCaptionChecker >> configureFrom: aDictionary [
	super configureFrom: aDictionary.
	aDictionary at: 'checkOnly' ifPresent: [ :list | 
		self checkCode: false.
		self checkFigure: false.
		self checkMath: false.
		(list includes: 'code') ifTrue: [ self checkCode: true ].
		(list includes: 'figure') ifTrue: [ self checkFigure: true ].
		(list includes: 'math') ifTrue: [ self checkMath: true ] ]
]

{ #category : 'visiting - inline elements' }
MicFigureCaptionChecker >> explanationForConfiguration [
	^ 'I check that figures, math environments and code blocks have a valid and non-empty caption.'
]

{ #category : 'visiting - inline elements' }
MicFigureCaptionChecker >> hasCorrectCaption: aCaptionText [
    ^ aCaptionText isNotEmpty and: [ aCaptionText anySatisfy: #isAlphaNumeric ]
]

{ #category : 'visiting - inline elements' }
MicFigureCaptionChecker >> initialize [
	super initialize.
	self checkCode: true.
	self checkFigure: true.
	self checkMath: true.
]

{ #category : 'visiting - inline elements' }
MicFigureCaptionChecker >> visitCode: aCode [
	self checkCode ifTrue: [ self checkCaptionOf: aCode ].
	^ super visitCode: aCode
]

{ #category : 'visiting - inline elements' }
MicFigureCaptionChecker >> visitFigure: aFigure [
	self checkFigure ifTrue: [ self checkCaptionOf: aFigure ].
	^ super visitFigure: aFigure
]

{ #category : 'visiting - inline elements' }
MicFigureCaptionChecker >> visitMath: aMath [
	self checkMath ifTrue: [ self checkCaptionOf: aMath ].
	^ super visitMath: aMath
]
