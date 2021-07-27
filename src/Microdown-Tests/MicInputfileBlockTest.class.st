Class {
	#name : #MicInputfileBlockTest,
	#superclass : #TestCase,
	#instVars : [
		'parser'
	],
	#category : #'Microdown-Tests-Extensions'
}

{ #category : #running }
MicInputfileBlockTest >> setUp [
	super setUp.
	parser := MicroDownParser new
]

{ #category : #tests }
MicInputfileBlockTest >> testMicInputfileIsNotRelativeFilePath [
	| mic |
	mic := parser parse: '?{inputfile|path=file:///chapters/withStyle.mic}?'.
	self assert: mic children first children first isRelativeFilePath not
]

{ #category : #tests }
MicInputfileBlockTest >> testMicInputfileIsRelativeFilePath [
	| mic |
	mic := parser parse: '?{inputfile|path=file://chapters/withStyle.mic}?'.
	self assert: mic children first children first isRelativeFilePath
]

{ #category : #tests }
MicInputfileBlockTest >> testMicInputfilePath [
	| mic |
	mic := parser parse: '?{inputfile|path=file://chapters/withStyle.mic}?'.
	self assert: mic children first children first path equals: 'file://chapters/withStyle.mic'
]

{ #category : #tests }
MicInputfileBlockTest >> testMicInputfilePathError [
	| mic |
	mic := parser parse: '?{inputfile|path:errror=file://chapters/withStyle.mic}?'.
	self assert: mic children first children first path equals: 'path is absent'
]
