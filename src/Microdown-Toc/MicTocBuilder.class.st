Class {
	#name : 'MicTocBuilder',
	#superclass : 'MicrodownVisitor',
	#instVars : [
		'tocItems',
		'headerStack',
		'limit'
	],
	#category : 'Microdown-Toc',
	#package : 'Microdown-Toc'
}

{ #category : 'initialization' }
MicTocBuilder >> initialize [

	super initialize.
	tocItems := OrderedCollection new.
	headerStack := Stack new.
	limit := 6
]

{ #category : 'configure' }
MicTocBuilder >> limitUpTo: anInteger [

	limit := anInteger
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

	| newTocEntry |
	newTocEntry := MicTocEntry new for: aMicHeader.

	aMicHeader level > limit ifTrue: [ ^ self ].

	headerStack isEmpty ifTrue: [
			headerStack push: newTocEntry.
			tocItems add: newTocEntry.
			^ self ].

	aMicHeader level = headerStack top level
		ifTrue: [
				headerStack pop.
				headerStack isEmpty
					ifTrue: [ tocItems add: newTocEntry ]
					ifFalse: [ headerStack top addChild: newTocEntry ] ]
		ifFalse: [
				aMicHeader level > headerStack top level
					ifTrue: [ headerStack top addChild: newTocEntry ]
					ifFalse: [
							[
								headerStack isNotEmpty and: [
									headerStack top level >= aMicHeader level ] ] whileTrue: [
								headerStack pop ].
							headerStack isEmpty ifTrue: [ tocItems add: newTocEntry ] ] ].
	headerStack push: newTocEntry
]
