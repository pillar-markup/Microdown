Class {
	#name : 'MicFigureEmptyCaptionChecker',
	#superclass : 'MicChecker',
	#instVars : [
		'checkFigure',
		'checkCode',
		'checkMath'
	],
	#category : 'Microdown-BookTester-Checker-EmptyCaption',
	#package : 'Microdown-BookTester',
	#tag : 'Checker-EmptyCaption'
}

{ #category : 'public - name' }
MicFigureEmptyCaptionChecker class >> checkerName [ 

	^ 'EmptyCaption'
]

{ #category : 'checking' }
MicFigureEmptyCaptionChecker >> checkCaptionOf: aBlock [
	(self hasCorrectCaption: aBlock caption) ifFalse: [ 
		self results add: MicMissingFigureCaptionResult new ]
]

{ #category : 'checking' }
MicFigureEmptyCaptionChecker >> checkCode [

	^ checkCode
]

{ #category : 'checking' }
MicFigureEmptyCaptionChecker >> checkCode: anObject [

	checkCode := anObject
]

{ #category : 'checking' }
MicFigureEmptyCaptionChecker >> checkFigure [

	^ checkFigure
]

{ #category : 'checking' }
MicFigureEmptyCaptionChecker >> checkFigure: anObject [

	checkFigure := anObject
]

{ #category : 'checking' }
MicFigureEmptyCaptionChecker >> checkMath [

	^ checkMath
]

{ #category : 'checking' }
MicFigureEmptyCaptionChecker >> checkMath: anObject [

	checkMath := anObject
]

{ #category : 'visiting - inline elements' }
MicFigureEmptyCaptionChecker >> checkMissingCaptionIn: aBlock text: captionText [
	(captionText isEmpty or: [ (captionText anySatisfy: #isAlphaNumeric) not ]) ifTrue: [ 
		self results add: (MicMissingFigureCaptionResult new
			figure: aBlock; 
			yourself) ]
]

{ #category : 'configuration' }
MicFigureEmptyCaptionChecker >> configureFrom: aDictionary [
	super configureFrom: aDictionary.
	aDictionary at: 'checkOnly' ifPresent: [ :list | 
		self checkCode: false.
		self checkFigure: false.
		self checkMath: false.
		(list includes: 'code') ifTrue: [ self checkCode: true ].
		(list includes: 'figure') ifTrue: [ self checkFigure: true ].
		(list includes: 'math') ifTrue: [ self checkMath: true ] ]
]

{ #category : 'configuration' }
MicFigureEmptyCaptionChecker >> explanationForConfiguration [
	^ 'I check that figures, math environments and code blocks have a valid and non-empty caption.'
]

{ #category : 'visiting - inline elements' }
MicFigureEmptyCaptionChecker >> hasCorrectCaption: aCaptionText [
    ^ aCaptionText isNotEmpty and: [ aCaptionText anySatisfy: #isAlphaNumeric ]
]

{ #category : 'initialization' }
MicFigureEmptyCaptionChecker >> initialize [
	super initialize.
	self checkCode: true.
	self checkFigure: true.
	self checkMath: true.
]

{ #category : 'visiting - inline elements' }
MicFigureEmptyCaptionChecker >> visitCode: aCode [
	self checkCode ifTrue: [ self checkCaptionOf: aCode ].
	^ super visitCode: aCode
]

{ #category : 'visiting - inline elements' }
MicFigureEmptyCaptionChecker >> visitFigure: aFigure [
	self checkFigure ifTrue: [ self checkCaptionOf: aFigure ].
	^ super visitFigure: aFigure
]

{ #category : 'visiting - inline elements' }
MicFigureEmptyCaptionChecker >> visitMath: aMath [
	self checkMath ifTrue: [ self checkCaptionOf: aMath ].
	^ super visitMath: aMath
]
