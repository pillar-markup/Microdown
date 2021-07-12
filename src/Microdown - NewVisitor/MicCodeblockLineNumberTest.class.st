Class {
	#name : #MicCodeblockLineNumberTest,
	#superclass : #PRNodeTransformerTest,
	#instVars : [
		'visitor'
	],
	#category : #'Microdown - NewVisitor'
}

{ #category : #private }
MicCodeblockLineNumberTest >> actualClass [
	^ MicCodeblockLineNumber 
]

{ #category : #tests }
MicCodeblockLineNumberTest >> configuration [
	^ ConfigurationForMicrodown new
]

{ #category : #running }
MicCodeblockLineNumberTest >> setUp [
	super setUp.
	instance := self actualInstance.
	visitor := MicCodeblockLineNumber new.
	visitor configuration: self configuration
]

{ #category : #tests }
MicCodeblockLineNumberTest >> testScriptWithLineNumber [
	| input |
	input := MicRootBlock new
		addChild:
				((MicCodeBlock new body: 'stream nextPut: $h; nextPut: $e; nextPut: $l; nextPutAll: ''lo''')
						lineNumber: true;
						eval: false;
						yourself);
		yourself.
	visitor visit: input.
	self assert: input children first class equals: MicCodeBlock.
	self assert: input children first body equals: '1	stream nextPut: $h; nextPut: $e; nextPut: $l; nextPutAll: ''lo'''
]

{ #category : #tests }
MicCodeblockLineNumberTest >> testScriptWithLineNumberFalse [
	| input |
	input := MicRootBlock new
		addChild:
				((MicCodeBlock new body: 'stream nextPut: $h; nextPut: $e; nextPut: $l; nextPutAll: ''lo''')
						lineNumber: false;
						eval: false;
						yourself);
		yourself.
	visitor visit: input.
	self assert: input children first class equals: MicCodeBlock.
	self assert: input children first body equals: 'stream nextPut: $h; nextPut: $e; nextPut: $l; nextPutAll: ''lo'''
]

{ #category : #tests }
MicCodeblockLineNumberTest >> testScriptWithSeveralLineNumbers [
	
	| input  |
	input := MicRootBlock new
		addChild:
				((MicCodeBlock new body: 'stream nextPut: $h; nextPut: $e; nextPut: $l; nextPutAll: ''lo''
 world
 !')
						lineNumber: true;
						eval: false;
						yourself);
		yourself.
	visitor visit: input.
	self assert: input children first class equals: MicCodeBlock.
	self assert: input children first body  equals: '1	stream nextPut: $h; nextPut: $e; nextPut: $l; nextPutAll: ''lo''
2	 world
3	 !'
]

{ #category : #tests }
MicCodeblockLineNumberTest >> testScriptWithoutParameter [
	| input |
	input := MicRootBlock new
		addChild:
				((MicCodeBlock new body: 'stream nextPut: $h; nextPut: $e; nextPut: $l; nextPutAll: ''lo''')
						yourself);
		yourself.
	visitor visit: input.
	self assert: input children first class equals: MicCodeBlock.
	self assert: input children first body equals: 'stream nextPut: $h; nextPut: $e; nextPut: $l; nextPutAll: ''lo'''
]
