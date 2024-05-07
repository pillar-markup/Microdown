Class {
	#name : 'MicSummerizeBlock',
	#superclass : 'Object',
	#category : 'Web - Summarizer',
	#package : 'Web - Summarizer'
}

{ #category : 'as yet unclassified' }
MicSummerizeBlock >> parseListOfElementSummerizeBlockToSummurizeBlock: aListOfElementSummerizeBlock [

	| summarize |
	
	summarize := MicRootBlock new.
	
	aListOfElementSummerizeBlock do: [ :each | summarize addChild: each title ; addChild: each resume ].
	
	^ summarize 
]

{ #category : 'rendering' }
MicSummerizeBlock >> render: aMicSummerizeBlock [

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
