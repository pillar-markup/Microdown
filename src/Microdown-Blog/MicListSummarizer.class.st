Class {
	#name : 'MicListSummarizer',
	#superclass : 'MicAbstractBlogCreator',
	#instVars : [
		'maximumFile'
	],
	#category : 'Microdown-Blog',
	#package : 'Microdown-Blog'
}

{ #category : 'grouping' }
MicListSummarizer >> group: aListOfSingleSummarizer byDate: aMonth [

	| metadataDate |
	^ aListOfSingleSummarizer select: [ :each |
		  metadataDate := (each children at: 1) body at: #date.
		  metadataDate asDate month = aMonth ]
]

{ #category : 'initialization' }
MicListSummarizer >> initialize [

	super initialize.
	maximumFile := 10.
]

{ #category : 'accessing' }
MicListSummarizer >> maximumFile [

	^ maximumFile
]

{ #category : 'accessing' }
MicListSummarizer >> maximumFile: aNumber [

	maximumFile := aNumber
]

{ #category : 'summarize' }
MicListSummarizer >> summarize: aListOfSingleSummarizer [

	| summarize root selectionSize |
	summarize := MicRootBlock new.

	selectionSize := maximumFile min: aListOfSingleSummarizer size. 

	1 to: selectionSize do: [ :each |
		root := aListOfSingleSummarizer at: each.
		summarize
			addChild: (root children at: 2);
			addChild: (root children at: 3) ].

	^ summarize
]

{ #category : 'summarize' }
MicListSummarizer >> summarizeFile: aListOfFile [

	| list singleSummarizer selectionSize |
	singleSummarizer := MicSingleSummarizer new.
	singleSummarizer targetDirectory: targetDirectory.

	list := Array new: aListOfFile size.

	selectionSize := maximumFile min: aListOfFile size.

	1 to: selectionSize do: [ :each |
		list
			at: each
			put: (singleSummarizer summarizeFile: (aListOfFile at: each)) ].

	^ self summarize: list
]
