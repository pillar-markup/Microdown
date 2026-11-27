"
I represent a list of toc entries. 
"
Class {
	#name : 'MicTocEntryList',
	#superclass : 'MicElement',
	#instVars : [
		'children'
	],
	#category : 'Microdown-Toc',
	#package : 'Microdown-Toc'
}

{ #category : 'accessing' }
MicTocEntryList >> accept: aVisitor [

	aVisitor visitToEntryList: self
]

{ #category : 'accessing' }
MicTocEntryList >> children [

	^ children 
]

{ #category : 'accessing' }
MicTocEntryList >> children: aListOfChildren [

	children := aListOfChildren
]
