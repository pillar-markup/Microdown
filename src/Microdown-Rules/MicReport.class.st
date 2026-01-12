Class {
	#name : 'MicReport',
	#superclass : 'Object',
	#instVars : [
		'file',
		'rule',
		'text',
		'concern'
	],
	#category : 'Microdown-Rules-BogusImplementation',
	#package : 'Microdown-Rules',
	#tag : 'BogusImplementation'
}

{ #category : 'accessing' }
MicReport >> concern [
	^ concern
]

{ #category : 'accessing' }
MicReport >> concern: aString [ 
	concern := aString
]

{ #category : 'accessing' }
MicReport >> inFile [
	
	^ file
]

{ #category : 'accessing' }
MicReport >> inFile: aFileReference [ 
	file := aFileReference
]

{ #category : 'accessing' }
MicReport >> micElement [
	^ text
]

{ #category : 'accessing' }
MicReport >> micElement: aMicText [

	text := aMicText 
]

{ #category : 'accessing' }
MicReport >> rule: aRule [ 
	
	rule := aRule
]

{ #category : 'accessing' }
MicReport >> text [

	^ text
]
