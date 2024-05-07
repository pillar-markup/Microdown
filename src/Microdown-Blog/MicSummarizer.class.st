Class {
	#name : 'MicSummarizer',
	#superclass : 'Object',
	#category : 'Microdown-Blog',
	#package : 'Microdown-Blog'
}

{ #category : 'as yet unclassified' }
MicSummarizer >> createSummerize: aListOfElementSummerizeBlock [

	| summarize |
	
	summarize := MicRootBlock new.
	
	(aListOfElementSummerizeBlock copyFrom: 1 to: 10) do:[ :each | summarize addChild: each title ; addChild: each resume ].
	
	^ summarize 
]

{ #category : 'as yet unclassified' }
MicSummarizer >> group: aListOfElementSummerizeBlock byDate: aDate [

	^ aListOfElementSummerizeBlock select: [ :each | ( each children at:1 ) at: #Date = aDate ]
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
