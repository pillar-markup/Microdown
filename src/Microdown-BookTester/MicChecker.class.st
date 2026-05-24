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
						at: self checkerName put: self objectsForJSONConfigurationPart;
						yourself ) ]
]

{ #category : 'configuration help' }
MicChecker class >> explanationForConfiguration [
	"self explanationForConfiguration"
	
	^ String streamContents: [ :str | 
		str << self comment. 
		str cr.
			str cr.
			str << 'In the pillar.conf file you can add the following key values:'. 
			str cr.
			str << (self configurationPartWithNewLine: Character lf asString) ] 
]

{ #category : 'testing' }
MicChecker class >> isAbstract [ 
	
	^ self = MicChecker
]

{ #category : 'configuration help' }
MicChecker class >> objectsForJSONConfigurationPart [
	"return either a boolean for non composite configurations or a dictionary."
	^ #()
]

{ #category : 'visiting' }
MicChecker >> addResult: aResult [

	results add: aResult
]

{ #category : 'visiting' }
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

{ #category : 'visiting' }
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

{ #category : 'initialization' }
MicChecker >> initialize [ 

	super initialize.
	results := OrderedCollection new. 
]

{ #category : 'testing' }
MicChecker >> isOkay [
	^ results isEmpty
]

{ #category : 'accessing' }
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
