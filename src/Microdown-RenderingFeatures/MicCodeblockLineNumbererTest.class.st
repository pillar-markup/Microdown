Class {
	#name : 'MicCodeblockLineNumbererTest',
	#superclass : 'TestCase',
	#instVars : [
		'visitor',
		'instance'
	],
	#category : 'Microdown-RenderingFeatures',
	#package : 'Microdown-RenderingFeatures'
}

{ #category : 'private' }
MicCodeblockLineNumbererTest >> actualClass [
	^ MicCodeblockLineNumberer 
]

{ #category : 'tests' }
MicCodeblockLineNumbererTest >> configuration [
	^ MicMinimalConfiguration new
]

{ #category : 'running' }
MicCodeblockLineNumbererTest >> setUp [
	super setUp.
	instance := self actualClass new.
	visitor := MicCodeblockLineNumberer new.
	visitor configuration: self configuration
]

{ #category : 'tests' }
MicCodeblockLineNumbererTest >> testScriptWithLineNumber [
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

{ #category : 'tests' }
MicCodeblockLineNumbererTest >> testScriptWithLineNumberFalse [
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

{ #category : 'tests' }
MicCodeblockLineNumbererTest >> testScriptWithSeveralLineNumbers [
	
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

{ #category : 'tests' }
MicCodeblockLineNumbererTest >> testScriptWithoutParameter [
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
