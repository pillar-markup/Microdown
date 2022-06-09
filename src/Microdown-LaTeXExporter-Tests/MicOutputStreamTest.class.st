Class {
	#name : #MicOutputStreamTest,
	#superclass : #TestCase,
	#instVars : [
		'stream'
	],
	#category : #'Microdown-LaTeXExporter-Tests'
}

{ #category : #running }
MicOutputStreamTest >> setUp [
	
	super setUp.
	stream := MicOutputStream new.
]

{ #category : #tests }
MicOutputStreamTest >> testCrAsNewLine [ 

	stream crAsNewLine.
	self assert: stream configuration newLine equals: Character cr
]

{ #category : #tests }
MicOutputStreamTest >> testCrlfAsNewLine [ 

	stream crlfAsNewLine.
	self assert: stream configuration newLine equals: String crlf
]

{ #category : #tests }
MicOutputStreamTest >> testLfAsNewLine [ 

	stream lfAsNewLine.
	self assert: stream configuration newLine equals: Character lf
]
