Class {
	#name : 'MicFigureEmptyCaption',
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
MicFigureEmptyCaption >> checkCaptionOf: aBlock [
	(self hasCorrectCaption: aBlock caption) ifFalse: [ 
		self results add: MicMissingFigureCaptionResult new ]
]

{ #category : 'accessing' }
MicFigureEmptyCaption >> checkCode [

	^ checkCode
]

{ #category : 'accessing' }
MicFigureEmptyCaption >> checkCode: anObject [

	checkCode := anObject
]

{ #category : 'accessing' }
MicFigureEmptyCaption >> checkFigure [

	^ checkFigure
]

{ #category : 'accessing' }
MicFigureEmptyCaption >> checkFigure: anObject [

	checkFigure := anObject
]

{ #category : 'accessing' }
MicFigureEmptyCaption >> checkMath [

	^ checkMath
]

{ #category : 'accessing' }
MicFigureEmptyCaption >> checkMath: anObject [

	checkMath := anObject
]

{ #category : 'visiting - inline elements' }
MicFigureEmptyCaption >> checkMissingCaptionIn: aBlock text: captionText [
	(captionText isEmpty or: [ (captionText anySatisfy: #isAlphaNumeric) not ]) ifTrue: [ 
		self results add: (MicMissingFigureCaptionResult new
			figure: aBlock; 
			yourself) ]
]

{ #category : 'visiting - inline elements' }
MicFigureEmptyCaption >> configureFrom: aDictionary [
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
MicFigureEmptyCaption >> explanationForConfiguration [
	^ 'I check that figures, math environments and code blocks have a valid and non-empty caption.'
]

{ #category : 'visiting - inline elements' }
MicFigureEmptyCaption >> hasCorrectCaption: aCaptionText [
    ^ aCaptionText isNotEmpty and: [ aCaptionText anySatisfy: #isAlphaNumeric ]
]

{ #category : 'visiting - inline elements' }
MicFigureEmptyCaption >> initialize [
	super initialize.
	self checkCode: true.
	self checkFigure: true.
	self checkMath: true.
]

{ #category : 'visiting - inline elements' }
MicFigureEmptyCaption >> visitCode: aCode [
	self checkCode ifTrue: [ self checkCaptionOf: aCode ].
	^ super visitCode: aCode
]

{ #category : 'visiting - inline elements' }
MicFigureEmptyCaption >> visitFigure: aFigure [
	self checkFigure ifTrue: [ self checkCaptionOf: aFigure ].
	^ super visitFigure: aFigure
]

{ #category : 'visiting - inline elements' }
MicFigureEmptyCaption >> visitMath: aMath [
	self checkMath ifTrue: [ self checkCaptionOf: aMath ].
	^ super visitMath: aMath
]
