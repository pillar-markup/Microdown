Class {
	#name : 'MicTocBuilder',
	#superclass : 'MicrodownVisitor',
	#instVars : [
		'tocItems'
	],
	#category : 'Microdown-Toc',
	#package : 'Microdown-Toc'
}

{ #category : 'initialization' }
MicTocBuilder >> initialize [ 
	
	super initialize.
	tocItems := OrderedCollection new
]

{ #category : 'accessing' }
MicTocBuilder >> tocItems [
	^ tocItems
]

{ #category : 'as yet unclassified' }
MicTocBuilder >> tocitems [
	self shouldBeImplemented.
]

{ #category : 'initialization' }
MicTocBuilder >> visitHeader: aMicHeader [

	tocItems add: (MicTocEntry new for: aMicHeader)
	
]
