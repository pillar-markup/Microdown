Class {
	#name : #MicHTMLTag,
	#superclass : #MicHTMLBrush,
	#instVars : [
		'name'
	],
	#category : #'Microdown - HTML'
}

{ #category : #accessing }
MicHTMLTag >> name: aString [
	name := aString.
	stream nextPut: $<; << aString
]

{ #category : #accessing }
MicHTMLTag >> parameterAt: aString put: anotherString [
	stream space. stream << aString << '="' << anotherString << '"'
]

{ #category : #accessing }
MicHTMLTag >> with: aString [
	stream 
		nextPut: $>; 
		<< aString;
		<< '</'; 
		<< name;
		nextPut: $>
]
