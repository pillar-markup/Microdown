"
In Microdown, labels of headers at certain levels (4 and above) serve as paragraph introducers (labels).
Depending on the convention, they should either end with a period or not.

I check that titles smaller than a given value do not terminate with a period and that titles below (4 and more for example) follow a given convention: always or never end with a period. 

```
Example of correct label (isEndingWithPeriod mode):
#### Color.
```

```
Example of incorrect label (isEndingWithPeriod mode):
#### Color
```


"
Class {
	#name : 'MicLastPeriodInParagraphLabelChecker',
	#superclass : 'MicLastPeriodChecker',
	#instVars : [
		'levelForParagraph'
	],
	#category : 'Microdown-BookTester-Checker-LastPeriod',
	#package : 'Microdown-BookTester',
	#tag : 'Checker-LastPeriod'
}

{ #category : 'public - name' }
MicLastPeriodInParagraphLabelChecker class >> checkerName [

	^ 'LastPeriodInParagraphLabel'
]

{ #category : 'configuration help' }
MicLastPeriodInParagraphLabelChecker class >> objectsForJSONConfigurationPart [

	^ { (#isEndingWithPeriod -> true) . (#levelForPagraph -> 4) } asDictionary
]

{ #category : 'visiting' }
MicLastPeriodInParagraphLabelChecker >> checkExtraPeriodIn: aMicHeader [

	(aMicHeader text trimRight endsWith: '.') ifTrue: [
		results add: (MicParagraphLabelResult new 
			micElement: aMicHeader;
			inFile: aMicHeader fromFile;
			labelShouldEndWithPeriod: isEndingWithPeriod;
			detail: aMicHeader text;
			yourself) ]
]

{ #category : 'visiting' }
MicLastPeriodInParagraphLabelChecker >> checkExtraPeriodIn: aMicHeader for: shouldEndWithPeriod [

	(aMicHeader text trimRight endsWith: '.') ifTrue: [
			results add: (MicParagraphLabelResult new
					 micElement: aMicHeader;
					 inFile: aMicHeader fromFile;
					 labelShouldEndWithPeriod: shouldEndWithPeriod;
					 detail: aMicHeader text;
					 yourself) ]
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

{ #category : 'configuration' }
MicLastPeriodInParagraphLabelChecker >> configureFrom: aConfiguration [

	aConfiguration class == Dictionary 
		ifFalse: [ ^ self ].
	
	aConfiguration 
		at: #levelForParagraph 
		ifPresent: [ :l | levelForParagraph := l asInteger clampBetween: 1 and: 6].
	aConfiguration 
		at: #isEndingWithPeriod 
		ifPresent: [ :b | isEndingWithPeriod := b ] 
]

{ #category : 'initialization' }
MicLastPeriodInParagraphLabelChecker >> defaultLevelForParagraph [

	^ 4
]

{ #category : 'initialization' }
MicLastPeriodInParagraphLabelChecker >> initialize [

	super initialize.
	isEndingWithPeriod := true.
	levelForParagraph := self defaultLevelForParagraph
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
MicLastPeriodInParagraphLabelChecker >> visitHeader: aMicHeader [

	aMicHeader level >= levelForParagraph 
		ifTrue: [ 
			isEndingWithPeriod 
				ifTrue: [ self checkMissingPeriodIn: aMicHeader ]
				ifFalse: [ self checkExtraPeriodIn: aMicHeader for: isEndingWithPeriod ] ]
		ifFalse: [ 
			"level 1 2 3 basically lower than levelForParagraph 
			should not terminate with period. The result should not use the state
			of the checker for reporting, it is always false. " 
			self checkExtraPeriodIn: aMicHeader for: false ]
]
