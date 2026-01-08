Class {
	#name : 'MicTocBuilder',
	#superclass : 'MicrodownVisitor',
	#instVars : [
		'tocItems',
		'headerStack'
	],
	#category : 'Microdown-Toc',
	#package : 'Microdown-Toc'
}

{ #category : 'initialization' }
MicTocBuilder >> initialize [ 
	
	super initialize.
	tocItems := OrderedCollection new.
	headerStack := Stack new.
]

{ #category : 'accessing' }
MicTocBuilder >> toc [

	^ MicRootBlock new children: { 
			(MicOrderedListBlock new 
				children: tocItems; yourself) } ; 
			yourself  
]

{ #category : 'accessing' }
MicTocBuilder >> tocItems [
	^ tocItems
]

{ #category : 'visiting' }
MicTocBuilder >> visitHeader: aMicHeader [

	headerStack isEmpty ifTrue: [
			| newTopLevelTocEntry |
			newTopLevelTocEntry := MicTocEntry new for: aMicHeader.
			headerStack push: newTopLevelTocEntry.
			tocItems add: newTopLevelTocEntry.
			^ self ].
	aMicHeader level = headerStack top level
		ifTrue: [
				| newTopLevelTocEntry |
				headerStack pop.
				newTopLevelTocEntry := MicTocEntry new for: aMicHeader.
				headerStack push: newTopLevelTocEntry.
				tocItems add: newTopLevelTocEntry ]
		ifFalse: [
				aMicHeader level > headerStack top level ifTrue: [
						| newTocEntry |
						newTocEntry := MicTocEntry new for: aMicHeader.
						headerStack top addChild: newTocEntry.
						headerStack push: newTocEntry ] ]
]
