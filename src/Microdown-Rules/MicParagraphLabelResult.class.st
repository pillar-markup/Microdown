Class {
	#name : 'MicParagraphLabelResult',
	#superclass : 'MicAbstractResult',
	#instVars : [
		'detail',
		'labelShouldEndWithPeriod'
	],
	#category : 'Microdown-Rules-LastPeriod',
	#package : 'Microdown-Rules',
	#tag : 'LastPeriod'
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
 	^ '- Paragraph: "' , micElement text
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
