"
I verify that captions are not left empty. 
I check figures, tables, and math caption by default: the user can ignore of a kind if needed. 
"
Class {
	#name : 'MicEmptyCaptionChecker',
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
MicEmptyCaptionChecker class >> checkerName [ 

	^ 'EmptyCaption'
]

{ #category : 'checking' }
MicEmptyCaptionChecker >> checkCaptionOf: aBlock [
	(self hasCorrectCaption: aBlock caption) ifFalse: [ 
		self results add: (MicMissingFigureCaptionResult new 
			figure: aBlock; 
			yourself) ]
]

{ #category : 'checking' }
MicEmptyCaptionChecker >> checkCode [

	^ checkCode
]

{ #category : 'checking' }
MicEmptyCaptionChecker >> checkCode: anObject [

	checkCode := anObject
]

{ #category : 'checking' }
MicEmptyCaptionChecker >> checkFigure [

	^ checkFigure
]

{ #category : 'checking' }
MicEmptyCaptionChecker >> checkFigure: anObject [

	checkFigure := anObject
]

{ #category : 'checking' }
MicEmptyCaptionChecker >> checkMath [

	^ checkMath
]

{ #category : 'checking' }
MicEmptyCaptionChecker >> checkMath: anObject [

	checkMath := anObject
]

{ #category : 'visiting - inline elements' }
MicEmptyCaptionChecker >> checkMissingCaptionIn: aBlock text: captionText [
	(captionText isEmpty or: [ (captionText anySatisfy: #isAlphaNumeric) not ]) ifTrue: [ 
		self results add: (MicMissingFigureCaptionResult new
			figure: aBlock; 
			yourself) ]
]

{ #category : 'configuration' }
MicEmptyCaptionChecker >> configureFrom: aDictionary [
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
MicEmptyCaptionChecker >> explanationForConfiguration [
	^ 'I check that figures, math environments and code blocks have a valid and non-empty caption.'
]

{ #category : 'visiting - inline elements' }
MicEmptyCaptionChecker >> hasCorrectCaption: aCaptionText [
    ^ aCaptionText isNotEmpty and: [ aCaptionText anySatisfy: #isAlphaNumeric ]
]

{ #category : 'initialization' }
MicEmptyCaptionChecker >> initialize [
	super initialize.
	self checkCode: true.
	self checkFigure: true.
	self checkMath: true.
]

{ #category : 'visiting - inline elements' }
MicEmptyCaptionChecker >> visitCode: aCode [
	self checkCode ifTrue: [ self checkCaptionOf: aCode ].
	^ super visitCode: aCode
]

{ #category : 'visiting - inline elements' }
MicEmptyCaptionChecker >> visitFigure: aFigure [
	self checkFigure ifTrue: [ self checkCaptionOf: aFigure ].
	^ super visitFigure: aFigure
]

{ #category : 'visiting - inline elements' }
MicEmptyCaptionChecker >> visitMath: aMath [
	self checkMath ifTrue: [ self checkCaptionOf: aMath ].
	^ super visitMath: aMath
]
