"
I'm a little util class that encapsulates writing reports about analyses.
"
Class {
	#name : 'MicAnalysisReportWriter',
	#superclass : 'Object',
	#instVars : [
		'results'
	],
	#category : 'Microdown-BookTester-Analysis',
	#package : 'Microdown-BookTester',
	#tag : 'Analysis'
}

{ #category : 'adding' }
MicAnalysisReportWriter >> addResults: aCollection [

	results addAll: aCollection
]

{ #category : 'reporting' }
MicAnalysisReportWriter >> buildReportOn: str [ 

	| dict | 
	dict := results groupedBy: [ :each | each class ].
	dict keysAndValuesDo: [ :k :v | 
		str cr; nextPutAll: '## ' ;nextPutAll: k headerString; cr; cr.
		self reportElements: v on: str.
		str cr; cr.
		]
]

{ #category : 'reporting' }
MicAnalysisReportWriter >> buildReportSTONFormatOn: str [ 

	| dict list | 
	dict := results groupedBy: [ :each | each class ].
	dict keysAndValuesDo: [ :k :v | |array|
		array := Array new: 2.
		list := OrderedCollection new.
		self reportElementsSTONFormatOn: list.
		list := list asArray.
		array 
			at: 1 put: (Association new key: 'type' value: k errorType);
			at: 2 put: list.
		(String streamContents: [ :out | STON put: array onStream: str ])
		]
]

{ #category : 'initialization' }
MicAnalysisReportWriter >> initialize [

	super initialize. 
	results := OrderedCollection new
]

{ #category : 'testing' }
MicAnalysisReportWriter >> isOkay [

	^ results isEmpty
]

{ #category : 'reporting' }
MicAnalysisReportWriter >> report [

	^ String streamContents: [ :str |
		self buildReportOn: str
		]
]

{ #category : 'reporting' }
MicAnalysisReportWriter >> reportElements: partialResults on: aStream [

	partialResults 
		do: [ :each | aStream tab; nextPutAll: each explanation ] 
		separatedBy: [ aStream cr ]
	
]

{ #category : 'reporting' }
MicAnalysisReportWriter >> reportElementsOn: aStream [

	results 
		do: [ :each | aStream tab; nextPutAll: each explanation ] 
		separatedBy: [ aStream cr ]
	
]

{ #category : 'reporting' }
MicAnalysisReportWriter >> reportElementsSTONFormatOn: aList [

		results do: [ :each | aList add: each stonFormatExplanation ].
	
]

{ #category : 'reporting' }
MicAnalysisReportWriter >> reportSTONFormat [

	^ String streamContents: [ :str |
		self buildReportSTONFormatOn: str
		]
]

{ #category : 'accessing' }
MicAnalysisReportWriter >> results [

	^ results
]

{ #category : 'accessing' }
MicAnalysisReportWriter >> results: anObject [

	results := anObject
]
