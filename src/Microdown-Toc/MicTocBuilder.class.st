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

{ #category : 'initialization' }
MicTocBuilder >> visitHeader: aMicHeader [

	headerStack isEmpty 
		ifTrue: [ 
			| newTopLevelTocEnty |
			newTopLevelTocEnty := MicTocEntry new for: aMicHeader.
			headerStack push: newTopLevelTocEnty.
			tocItems add: newTopLevelTocEnty.
			^ self ].
	aMicHeader level = headerStack top level
		ifTrue: [ 
			| newTopLevelTocEnty |
			headerStack pop.
			newTopLevelTocEnty := MicTocEntry new for: aMicHeader.
			headerStack push: newTopLevelTocEnty.
			tocItems add: newTopLevelTocEnty.
			]
		ifFalse: [ 
			aMicHeader level > headerStack top level
				ifTrue: [ 
					headerStack top addChild: (MicTocEntry new for: aMicHeader) ] ]
]
