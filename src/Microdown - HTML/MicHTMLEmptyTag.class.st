Class {
	#name : #MicHTMLEmptyTag,
	#superclass : #MicHTMLBrush,
	#instVars : [
		'name'
	],
	#category : #'Microdown - HTML'
}

{ #category : #accessing }
MicHTMLEmptyTag >> closeTag [
	stream << '/>'
]

{ #category : #accessing }
MicHTMLEmptyTag >> name: aString [
	name := aString.
	stream nextPut: $<; << aString
]

{ #category : #accessing }
MicHTMLEmptyTag >> parameterAt: aString put: anotherString [
	stream space. stream << aString << '="' << anotherString << '"'
]
