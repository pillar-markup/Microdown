Class {
	#name : 'MicParagraphLabelChecker',
	#superclass : 'MicChecker',
	#instVars : [
		'labelShouldEndWithPeriod'
	],
	#category : 'Microdown-Rules-CodeLastPeriod',
	#package : 'Microdown-Rules',
	#tag : 'CodeLastPeriod'
}

{ #category : 'visiting' }
MicParagraphLabelChecker >> checkExtraPeriodIn: aMicHeader [
	(aMicHeader text trimRight endsWith: '.') ifTrue: [ 
		results add: (MicParagraphLabelResult new 
			micElement: aMicHeader;
			inFile: aMicHeader fromFile;
			labelShouldEndWithPeriod: labelShouldEndWithPeriod;
			detail: aMicHeader text;
			yourself
		)
		 ]
]

{ #category : 'visiting' }
MicParagraphLabelChecker >> checkMissingPeriodIn: aMicHeader [
	(aMicHeader text trimRight endsWith: '.') ifFalse: [ 
		results add: (MicParagraphLabelResult new 
			micElement: aMicHeader;
			inFile: aMicHeader fromFile;
			labelShouldEndWithPeriod: labelShouldEndWithPeriod;
			detail: aMicHeader text;
			yourself
		)
		 ]
]

{ #category : 'visiting' }
MicParagraphLabelChecker >> identifyExtraPeriod [
	labelShouldEndWithPeriod := false
]

{ #category : 'visiting' }
MicParagraphLabelChecker >> identifyMissingPeriod [
	labelShouldEndWithPeriod := true
]

{ #category : 'visiting' }
MicParagraphLabelChecker >> initialize [ 
	super initialize.
	labelShouldEndWithPeriod := true
]

{ #category : 'visiting' }
MicParagraphLabelChecker >> visitHeader: aMicHeader [
	aMicHeader level >= 4 ifTrue: [ 
		labelShouldEndWithPeriod 
			ifTrue: [ self checkMissingPeriodIn: aMicHeader ]
			ifFalse: [ self checkExtraPeriodIn: aMicHeader ] 
		 ]
]
