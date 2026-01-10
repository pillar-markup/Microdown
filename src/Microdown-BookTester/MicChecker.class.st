Class {
	#name : 'MicChecker',
	#superclass : 'MicrodownVisitor',
	#instVars : [
		'reportWriter',
		'results',
		'rootDirectory'
	],
	#category : 'Microdown-BookTester-CodeBlockAnalysis',
	#package : 'Microdown-BookTester',
	#tag : 'CodeBlockAnalysis'
}

{ #category : 'accessing' }
MicChecker >> fileCollectorForMainFileReference: aFileReference [

	| mainMic collector |
	mainMic := Microdown parseFile: aFileReference.
	collector := MicFileCollector new.
	collector
		rootDirectory: rootDirectory;
		visit: mainMic.
	^ collector
]

{ #category : 'accessing' }
MicChecker >> reportWriter [

	^ reportWriter
]

{ #category : 'accessing' }
MicChecker >> reportWriter: anObject [

	reportWriter := anObject
]

{ #category : 'visiting' }
MicChecker >> results [

	^ results
]

{ #category : 'accessing' }
MicChecker >> results: anObject [

	results := anObject
]
