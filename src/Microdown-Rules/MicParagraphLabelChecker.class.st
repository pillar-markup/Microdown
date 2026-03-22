"
I check that paragraph labels at heading levels 4, 5 and 6 end with a period.
In Microdown, labels at these levels serve as paragraph introducers rather than real titles.
Depending on the convention, they should either end with a period or not.

Example of correct label (identifyMissingPeriod mode):
#### Color.

Example of incorrect label (identifyMissingPeriod mode):
#### Color

I can be configured in two modes:

identifyMissingPeriod: flags labels that do Not end with a period.
identifyExtraPeriod: flags labels that Do end with a period.
"
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

{ #category : 'public - name' }
MicParagraphLabelChecker class >> checkerName [

	^ 'ParagraphLabelEndPeriod'
]

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
	"Report a problem when paragrah label should not end with a period"
	labelShouldEndWithPeriod := false
]

{ #category : 'visiting' }
MicParagraphLabelChecker >> identifyMissingPeriod [
	"Report a problem when paragraph label should end with a period"
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
