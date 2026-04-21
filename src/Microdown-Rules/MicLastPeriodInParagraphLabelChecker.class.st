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
	#name : 'MicLastPeriodInParagraphLabelChecker',
	#superclass : 'MicLastPeriodChecker',
	#instVars : [
		'levelForParagraph'
	],
	#category : 'Microdown-Rules-LastPeriod',
	#package : 'Microdown-Rules',
	#tag : 'LastPeriod'
}

{ #category : 'public - name' }
MicLastPeriodInParagraphLabelChecker class >> checkerName [

	^ 'ParagraphLabelEndPeriod'
]

{ #category : 'visiting' }
MicLastPeriodInParagraphLabelChecker >> checkExtraPeriodIn: aMicHeader [
	(aMicHeader text trimRight endsWith: '.') ifTrue: [ 
		results add: (MicParagraphLabelResult new 
			micElement: aMicHeader;
			inFile: aMicHeader fromFile;
			labelShouldEndWithPeriod: isEndingWithPeriod;
			detail: aMicHeader text;
			yourself
		)
		 ]
]

{ #category : 'visiting' }
MicLastPeriodInParagraphLabelChecker >> checkMissingPeriodIn: aMicHeader [

	
	| text |
	text := aMicHeader text trimRight.
	
	(text occurrencesOf: $.) > 1 ifTrue: [ 
		results add: (MicDoublePeriodResult new 
			micElement: aMicHeader;
			inFile: aMicHeader fromFile;
			yourself) ].
		
	 
	(text endsWith: '.') ifFalse: [ 
		results add: (MicParagraphLabelResult new 
			micElement: aMicHeader;
			inFile: aMicHeader fromFile;
			labelShouldEndWithPeriod: isEndingWithPeriod;
			detail: aMicHeader text;
			yourself
		) ]
]

{ #category : 'visiting' }
MicLastPeriodInParagraphLabelChecker >> configureFrom: aConfiguration [

	"The configuration should handle the level too."
	

	aConfiguration isNil ifTrue: [ ^ self ].
	aConfiguration = 'true'
		ifTrue: [ isEndingWithPeriod := true ]
		ifFalse: [ isEndingWithPeriod := false ]
]

{ #category : 'visiting' }
MicLastPeriodInParagraphLabelChecker >> initialize [

	super initialize.
	isEndingWithPeriod := true.
	levelForParagraph := 4.
]

{ #category : 'accessing' }
MicLastPeriodInParagraphLabelChecker >> levelForParagraph [

	^ levelForParagraph
]

{ #category : 'accessing' }
MicLastPeriodInParagraphLabelChecker >> levelForParagraph: anObject [

	levelForParagraph := anObject
]

{ #category : 'visiting' }
MicLastPeriodInParagraphLabelChecker >> requiresPeriodFor: anElement [

	levelForParagraph ifNil: [ ^ false ].
	anElement level ifNil: [ ^ false ].
	^ anElement level >= levelForParagraph
]

{ #category : 'visiting' }
MicLastPeriodInParagraphLabelChecker >> visitHeader: aMicHeader [

	aMicHeader level >= levelForParagraph 
		ifTrue: [ 
			isEndingWithPeriod 
				ifTrue: [ self checkMissingPeriodIn: aMicHeader ]
				ifFalse: [ self checkExtraPeriodIn: aMicHeader ] 
		 	]
		
		ifFalse: [ "level 1 2 3 should not terminate with period" 
			self checkExtraPeriodIn: aMicHeader ]
]
