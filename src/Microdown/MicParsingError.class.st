"
I am Parsing error.
I should be obsoleted.

<!inputFile|pa=foo!> 
"
Class {
	#name : 'MicParsingError',
	#superclass : 'Error',
	#instVars : [
		'line'
	],
	#category : 'Microdown-Parser',
	#package : 'Microdown',
	#tag : 'Parser'
}

{ #category : 'accessing' }
MicParsingError >> line [
	^ line
]

{ #category : 'accessing' }
MicParsingError >> line: anObject [
	line := anObject
]
