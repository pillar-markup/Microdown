Class {
	#name : 'MicElementSummerizeBlock',
	#superclass : 'Object',
	#instVars : [
		'title',
		'resume'
	],
	#category : 'Web - Summarizer',
	#package : 'Web - Summarizer'
}

{ #category : 'as yet unclassified' }
MicElementSummerizeBlock >> getFirstMicHeaderBlock: aMicRootBlock [

	^ (aMicRootBlock children select: [ :each | each isKindOf: MicHeaderBlock ]) at:1
]

{ #category : 'as yet unclassified' }
MicElementSummerizeBlock >> getFirstMicParagraphBlock: aMicRootBlock [

	^ (aMicRootBlock children select: [ :each | each isKindOf: MicParagraphBlock ]) at:1
]

{ #category : 'parsing' }
MicElementSummerizeBlock >> parseFile: aFileReference [

	| p |
	p := Microdown parse: aFileReference asFileReference contents.
	title := self getFirstMicHeaderBlock: p.
	resume := self getFirstMicParagraphBlock: p.
]

{ #category : 'accessing' }
MicElementSummerizeBlock >> resume [

	^ resume
]

{ #category : 'accessing' }
MicElementSummerizeBlock >> resume: aResume [

	resume := aResume
]

{ #category : 'accessing' }
MicElementSummerizeBlock >> title [

	^ title
]

{ #category : 'accessing' }
MicElementSummerizeBlock >> title: aTitle [

	title := aTitle
]
