"
I'm a little file wrapper so that we can mix pillar and microdown file within a document.
As such I'm responsible to determine how my instances are parsed.
"
Class {
	#name : 'MicInputDocument',
	#superclass : 'Object',
	#instVars : [
		'project',
		'file'
	],
	#category : 'Microdown-Transformer',
	#package : 'Microdown-Transformer'
}

{ #category : 'factory' }
MicInputDocument class >> forFile: aFile [
	
	^ (self inputClassForFile: aFile) new file: aFile ; yourself
]

{ #category : 'factory' }
MicInputDocument class >> inputClassForFile: aFile [
	
	^ self subclasses
		detect: [ :each | each doesHandleExtension: aFile extension ]
		ifNone: [ MicNoInputDocument  ]
]

{ #category : 'accessing' }
MicInputDocument >> basename [
	
	^ file basename
]

{ #category : 'building' }
MicInputDocument >> contributeToPipelineBuilding: aPRPipelineBuilder [ 
	
	self error: 'To be fixed'.
	self flag: #maybeToRemove.
	
	aPRPipelineBuilder setInputDocument: file.
	aPRPipelineBuilder parser: self parser
]

{ #category : 'accessing' }
MicInputDocument >> file [
	^ file
]

{ #category : 'accessing' }
MicInputDocument >> file: aFileReference [ 
	file := aFileReference
]

{ #category : 'accessing' }
MicInputDocument >> fullName [
	^ file fullName
]

{ #category : 'accessing' }
MicInputDocument >> path [
	
	^ file path
]

{ #category : 'printing' }
MicInputDocument >> printOn: aStream [
	aStream
		nextPutAll: self class name;
		nextPutAll: '(';
		nextPutAll: file fullName;
		nextPutAll: ')'
]

{ #category : 'accessing' }
MicInputDocument >> project [
	^ project
]

{ #category : 'accessing' }
MicInputDocument >> project: aProject [ 
	project := aProject
]
