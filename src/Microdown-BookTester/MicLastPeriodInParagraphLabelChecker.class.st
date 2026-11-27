"
I check the final period of headers. A paragraph label (a header at the paragraph level of the book or deeper, `#####` by default, see `MicBookStructure`) follows the convention of the book: always (the default) or never end with a period. Any other header never ends with a period.

The paragraph level is not mine to configure: it is the one of the book (`""paragraphLevel""` in `pillar.conf`), which Pillar gives to every checker (`MicChecker>>bookStructure:`). My configuration part only says whether labels end with a period:

```
""LastPeriodInParagraphLabel"" : { ""isEndingWithPeriod"" : true }
```

Example of a correct label (isEndingWithPeriod mode):
```
##### Color.
```

Example of an incorrect label (isEndingWithPeriod mode):
```
##### Color
```

"
Class {
	#name : 'MicLastPeriodInParagraphLabelChecker',
	#superclass : 'MicLastPeriodChecker',
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

	^ { (#isEndingWithPeriod -> true) } asDictionary
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
	"The level of the paragraph labels is not mine to configure: it comes from the structure of the book (paragraphLevel in pillar.conf)."

	aConfiguration class == Dictionary ifFalse: [ ^ self ].
	aConfiguration
		at: #isEndingWithPeriod
		ifPresent: [ :b | isEndingWithPeriod := b ]
]

{ #category : 'initialization' }
MicLastPeriodInParagraphLabelChecker >> initialize [

	super initialize.
	isEndingWithPeriod := true
]

{ #category : 'visiting' }
MicLastPeriodInParagraphLabelChecker >> visitHeader: aMicHeader [
	"A paragraph label (see MicBookStructure>>isParagraph:) follows the convention of the book: always or never end with a period. Any other header never ends with a period."

	(aMicHeader bookStructure isParagraph: aMicHeader)
		ifTrue: [
				isEndingWithPeriod
					ifTrue: [ self checkMissingPeriodIn: aMicHeader ]
					ifFalse: [
					self checkExtraPeriodIn: aMicHeader for: isEndingWithPeriod ] ]
		ifFalse: [ "The result should not use the state of the checker for reporting, it is always false."
			self checkExtraPeriodIn: aMicHeader for: false ]
]
