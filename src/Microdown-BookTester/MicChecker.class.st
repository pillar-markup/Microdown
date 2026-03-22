"
I'm the root of the checker.
Right now I'm a visitor but may be I will invoke visitors in the future. 
Still my API and responsibility should be the same. 

I should check a project and report results. 
"
Class {
	#name : 'MicChecker',
	#superclass : 'MicrodownVisitor',
	#instVars : [
		'reportWriter',
		'results',
		'rootDirectory'
	],
	#category : 'Microdown-BookTester-Core',
	#package : 'Microdown-BookTester',
	#tag : 'Core'
}

{ #category : 'as yet unclassified' }
MicChecker class >> checkerName [ 
	^ 'UnnamedChecker'
]

{ #category : 'visiting' }
MicChecker >> addResult: aResult [

	results add: aResult
]

{ #category : 'accessing' }
MicChecker >> checkProject: aFileReference [

	| collector |
	collector := self fileCollectorForMainFileReference: aFileReference.
	collector visitedFilesAsDOM do: [ :each | each accept: self  ]
]

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
MicChecker >> fileSystem: aReference [

	rootDirectory := aReference
]

{ #category : 'visiting' }
MicChecker >> initialize [ 

	super initialize.
	results := OrderedCollection new. 
]

{ #category : 'testing' }
MicChecker >> isOkay [
	^ results isEmpty
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

{ #category : 'accessing' }
MicChecker >> rootDirectory: aFileReference [

	rootDirectory := aFileReference
]
