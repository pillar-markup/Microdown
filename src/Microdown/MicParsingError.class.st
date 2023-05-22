"
I am Parsing error.
I should be obsoleted.

<!inputFile|pa=foo!> 
"
Class {
	#name : #MicParsingError,
	#superclass : #Error,
	#instVars : [
		'line'
	],
	#category : #'Microdown-Parser'
}

{ #category : #accessing }
MicParsingError >> line [
	^ line
]

{ #category : #accessing }
MicParsingError >> line: anObject [
	line := anObject
]
