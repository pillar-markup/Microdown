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
MicSummarizer >> generateDateListSince2014 [

	| date t |

	date := Date newDay: 1 month: 1  year: 2014.

	t := Timespan starting: date duration: (Duration years: [ Date today year - date year + 1] value ).
	^ t months
 
]

{ #category : 'as yet unclassified' }
MicSummarizer >> generateMicListBlockOfDate [

	| root link text |
	
	root := MicUnorderedListBlock new.

	MicSummarizer new generateDateListSince2014 do: [ :each |
		link := MicLinkBlock new.
		text := MicTextBlock new bodyString: each asString.
		link
			children: (Array new: 1 withAll: text);
			url: '/TRUC'.
		link parent: root ].
	^ root
]

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
MicSummarizer >> render: aMicSummerize [

	| a q |
	a := (MicHTMLVisitor new visit: aMicSummerize) at: 1.

	q := MicHTMLDocument new.
	q configuration: a configuration.
	q configuration document: q.
	q setCharSetUTF8.
	^ q
		  writeDocumentBody: a contents;
		  writeToFile;
		  contents
]

{ #category : 'rendering' }
MicSummarizer >> renderFiles: aListOfFiles [

	^ self render: ( self summarizeFile: aListOfFiles )
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
			addChild: (root children at:2);
			addChild: (root children at:3) ].

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
