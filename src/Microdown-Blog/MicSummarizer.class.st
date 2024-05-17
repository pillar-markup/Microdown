Class {
	#name : 'MicSummarizer',
	#superclass : 'MicDocumentTransformer',
	#instVars : [
		'maximumFile'
	],
	#category : 'Microdown-Blog',
	#package : 'Microdown-Blog'
}

{ #category : 'grouping' }
MicSummarizer >> group: aListOfSingleSummarizer byDate: aDate [

	| metadataDate |

	^ aListOfSingleSummarizer select: [ :each | metadataDate := ( each children at:1 ) body at: #date.
		 (metadataDate asDate month) = aDate ]
]

{ #category : 'initialization' }
MicSummarizer >> initialize [

	super initialize.
	maximumFile := 10.
]

{ #category : 'accessing' }
MicSummarizer >> maximumFile [

	^ maximumFile
]

{ #category : 'accessing' }
MicSummarizer >> maximumFile: aNumber [

	maximumFile := aNumber
]

{ #category : 'as yet unclassified' }
MicSummarizer >> summarize: aListOfSingleSummarizer [

	| summarize root singleSummarizer selectionSize |
	summarize := MicRootBlock new.

	singleSummarizer := MicSingleSummarizer new.
	singleSummarizer targetDirectory: targetDirectory.

	selectionSize := maximumFile min: aListOfSingleSummarizer size.

	1 to: selectionSize do: [ :each |
		root := aListOfSingleSummarizer at: each.
		summarize
			addChild: (root children at: 2);
			addChild: (root children at: 3) ].

	^ summarize
]

{ #category : 'as yet unclassified' }
MicSummarizer >> summarizeFile: aListOfFile [

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
