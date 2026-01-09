Class {
	#name : 'MicTocEntry',
	#superclass : 'MicElement',
	#instVars : [
		'header',
		'children'
	],
	#category : 'Microdown-Toc',
	#package : 'Microdown-Toc'
}

{ #category : 'visiting' }
MicTocEntry >> accept: aVisitor [

	aVisitor visitTocEntry: self
]

{ #category : 'adding' }
MicTocEntry >> addChild: aMicTocEntry [ 
	children add: aMicTocEntry
]

{ #category : 'accessing' }
MicTocEntry >> children [
	^ children
]

{ #category : 'instance creation' }
MicTocEntry >> for: aMicHeaderBlock [ 
	
	header := aMicHeaderBlock 
]

{ #category : 'accessing' }
MicTocEntry >> header [
	^ header
]

{ #category : 'initialization' }
MicTocEntry >> initialize [
	
	super initialize. 
	children := OrderedCollection new
]

{ #category : 'accessing' }
MicTocEntry >> level [
	^ header level
]

{ #category : 'printing' }
MicTocEntry >> printOn: aStream [

	super printOn: aStream.
	aStream space. 
	aStream print: header
]
