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

{ #category : 'accessing' }
MicFigureEmptyCaptionChecker >> checkCaptionOf: aBlock [
	(self hasCorrectCaption: aBlock caption) ifFalse: [ 
		self results add: MicMissingFigureCaptionResult new ]
]

{ #category : 'accessing' }
MicFigureEmptyCaptionChecker >> checkCode [

	^ checkCode
]

{ #category : 'accessing' }
MicFigureEmptyCaptionChecker >> checkCode: anObject [

	checkCode := anObject
]

{ #category : 'accessing' }
MicFigureEmptyCaptionChecker >> checkFigure [

	^ checkFigure
]

{ #category : 'accessing' }
MicFigureEmptyCaptionChecker >> checkFigure: anObject [

	checkFigure := anObject
]

{ #category : 'accessing' }
MicFigureEmptyCaptionChecker >> checkMath [

	^ checkMath
]

{ #category : 'accessing' }
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

{ #category : 'visiting - inline elements' }
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

{ #category : 'visiting - inline elements' }
MicFigureEmptyCaptionChecker >> explanationForConfiguration [
	^ 'I check that figures, math environments and code blocks have a valid and non-empty caption.'
]

{ #category : 'visiting - inline elements' }
MicFigureEmptyCaptionChecker >> hasCorrectCaption: aCaptionText [
    ^ aCaptionText isNotEmpty and: [ aCaptionText anySatisfy: #isAlphaNumeric ]
]

{ #category : 'visiting - inline elements' }
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
