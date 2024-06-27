"
Given a list of documents (often documents coming from another summarizer such the SingleDocumentSummarizer) I produce a new document consisting in a list of such summarizer.

I take the first header and paragraph of the documents I work on to produce the new documents. 
"
Class {
	#name : 'MicListSummarizer',
	#superclass : 'MicAbstractBlogCreator',
	#instVars : [
		'maximumFile'
	],
	#category : 'Microdown-Blog',
	#package : 'Microdown-Blog'
}

{ #category : 'summarize' }
MicListSummarizer >> assembleSummarizedDocuments: aListOfSingleSummarizer [

	| summarized selectionSize |
	selectionSize := maximumFile min: aListOfSingleSummarizer size.

	summarized := MicRootBlock new.

	1 to: selectionSize do: [ :each |
		| rootOfSourceDocument |
		
		rootOfSourceDocument := aListOfSingleSummarizer at: each.
		
		2 to: rootOfSourceDocument children size do: [ :eachChild |
			summarized addChild: (rootOfSourceDocument children at: eachChild) ] ].

	^ summarized
]

{ #category : 'grouping' }
MicListSummarizer >> group: aListOfSingleSummarizer byDate: aMonth [
	"precondition: date is set"
	| metadataDate |
	^ aListOfSingleSummarizer select: [ :each |
		 metadataDate := each children first body at: #date.
		 metadataDate := (Date readFrom: metadataDate pattern: 'y/m/d').
		 metadataDate month = aMonth ]
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

	^ self assembleSummarizedDocuments: aListOfSingleSummarizer
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
