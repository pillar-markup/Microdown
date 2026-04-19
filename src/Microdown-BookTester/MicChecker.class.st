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

{ #category : 'public - name' }
MicChecker class >> checkerName [ 
	^ 'UnnamedChecker'
]

{ #category : 'configuration help' }
MicChecker class >> configurationJSONPart [

	^ #()
]

{ #category : 'configuration help' }
MicChecker class >> configurationPart: newline [
	"To be removed... you should use configurationPartWithNewLine:"
	
	^ self configurationPartWithNewLine: newline
]

{ #category : 'configuration help' }
MicChecker class >> configurationPartWithNewLine: newline [
	"self configurationPart"
	
	"^ STON toJsonStringPretty: { self checkerName -> self configurationJSONPart } asDictionary"
	
	^ String streamContents: [ :s | 
		| writer |
		writer := STONWriter new.
		writer on: s.
		writer	jsonMode: true.
		writer prettyPrint: true;
		newLine: newline;
		nextPut: (Dictionary new 
						at: self checkerName put: self configurationJSONPart;
						yourself ) ]
]

{ #category : 'configuration help' }
MicChecker class >> explanationForConfiguration [
	"self explanationForConfiguration"
	
	^ String streamContents: [ :str | 
		str << self comment. 
		str cr.
		self configurationJSONPart ifNotEmpty: [ 
			str cr.
			str << 'In the pillar.conf file you can add the following key values:'. 
			str cr.
			str << (self configurationPartWithNewLine: Character lf asString) ]] 
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

{ #category : 'configuration' }
MicChecker >> configureFrom: aConfiguration [
	"By default a checker does not need to be configured"
	
	^ self 
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
