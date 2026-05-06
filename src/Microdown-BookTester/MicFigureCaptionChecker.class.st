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
MicFigureCaptionChecker >> configureFrom: aConfiguration [
	super configureFrom: aConfiguration.
	checkFigure := aConfiguration propertyAt: #checkFigure ifAbsent: [ true ].
	checkCode := aConfiguration propertyAt: #checkCode ifAbsent: [ true ].
	checkMath := aConfiguration propertyAt: #checkMath ifAbsent: [ true ].
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
	checkFigure := true.
	checkCode := true.
	checkMath := true.
]

{ #category : 'visiting - inline elements' }
MicFigureCaptionChecker >> visitCode: aCode [
	self checkCode ifTrue: [
		(self hasCorrectCaption: aCode caption) ifFalse: [ 
			self results add: MicMissingFigureCaptionResult new ] ]
]

{ #category : 'visiting - inline elements' }
MicFigureCaptionChecker >> visitFigure: aFigure [
	self checkFigure ifTrue: [
		(self hasCorrectCaption: aFigure caption) ifFalse: [ 
			self results add: MicMissingFigureCaptionResult new ] ]
]

{ #category : 'visiting - inline elements' }
MicFigureCaptionChecker >> visitMath: aMath [
	self checkMath ifTrue: [
		(self hasCorrectCaption: aMath caption) ifFalse: [ 
			self results add: MicMissingFigureCaptionResult new ] ]
]
