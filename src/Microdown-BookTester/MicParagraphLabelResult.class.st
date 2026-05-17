Class {
	#name : 'MicParagraphLabelResult',
	#superclass : 'MicAbstractResult',
	#instVars : [
		'detail',
		'labelShouldEndWithPeriod'
	],
	#category : 'Microdown-BookTester-Checker-LastPeriod',
	#package : 'Microdown-BookTester',
	#tag : 'Checker-LastPeriod'
}

{ #category : 'accessing' }
MicParagraphLabelResult >> detail [

	^ detail
]

{ #category : 'accessing' }
MicParagraphLabelResult >> detail: aString [

	detail := aString
]

{ #category : 'accessing' }
MicParagraphLabelResult >> explanation [ 
 	^ 'Paragraph: "' , micElement text
	, '" in file ' , fileReference fullName 
	, ' contains a mistake: label should'
	, (labelShouldEndWithPeriod 
		ifTrue: [ ' ' ]
		ifFalse: [ ' not ' ]
	), 'be terminated with a period (.).'
]

{ #category : 'accessing' }
MicParagraphLabelResult >> labelShouldEndWithPeriod: aBoolean [

	labelShouldEndWithPeriod := aBoolean
]
