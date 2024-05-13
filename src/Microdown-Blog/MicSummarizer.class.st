Class {
	#name : 'MicSummarizer',
	#superclass : 'Object',
	#instVars : [
		'maximumFile'
	],
	#category : 'Microdown-Blog',
	#package : 'Microdown-Blog'
}

{ #category : 'as yet unclassified' }
MicSummarizer >> group: aListOfSingleSummarizer byDate: aDate [

	| metadataDate |

	^ aListOfSingleSummarizer select: [ :each | metadataDate := ( each children at:1 ) body at: #date.
		( metadataDate asDate isOnOrAfter:aDate ) and: [ metadataDate asDate isBefore: (aDate addMonths: 1) ] ]
]

{ #category : 'initialization' }
MicSummarizer >> initialize [

	super initialize.
	maximumFile := 10
]

{ #category : 'accessing' }
MicSummarizer >> maximumFile [

	^ maximumFile
]

{ #category : 'accessing' }
MicSummarizer >> maximumFile: aNumber [

	maximumFile := aNumber
]

{ #category : 'rendering' }
MicSummarizer >> render: aMicSummerizeBlock [

	| a q |
	
	a := (MicHTMLVisitor new visit: aMicSummerizeBlock ) at: 1.

	q := MicHTMLDocument new.
	q configuration: a configuration.
	q configuration document: q.
	q setCharSetUTF8.
	^ q writeDocument: a contents;
	writeToFile;
	contents.
]

{ #category : 'as yet unclassified' }
MicSummarizer >> summarize: aListOfSingleSummarizer [

	| summarize root singleSummarizer selectionSize |
	summarize := MicRootBlock new.

	singleSummarizer := MicSingleSummarizer new.
	
	selectionSize := maximumFile min: aListOfSingleSummarizer size.

	1 to: selectionSize do: [ :each |
		root := aListOfSingleSummarizer at: each.
		summarize
			addChild: (singleSummarizer firstHeaderBlockOf: root);
			addChild: (singleSummarizer firstParagraphBlockOf: root) ].

	^ summarize
]

{ #category : 'as yet unclassified' }
MicSummarizer >> summarizeFile: aListOfFile [

	| list singleSummarizer selectionSize |
	singleSummarizer := MicSingleSummarizer new.

	list := Array new: aListOfFile size.
	
	selectionSize := maximumFile min: aListOfFile size.

	1 to: selectionSize do: [ :each |
		list
			at: each
			put: (singleSummarizer summarizeFile: (aListOfFile at: each)) ].

	^ self summarize: list
]
