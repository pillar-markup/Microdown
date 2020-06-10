"
I am used to represent links and images which has a url.
"
Class {
	#name : #MicInlineBlockWithUrl,
	#superclass : #MicInlineBlock,
	#instVars : [
		'url'
	],
	#category : #'Microdown-Kasper'
}

{ #category : #'as yet unclassified' }
MicInlineBlockWithUrl >> asPillar [
	^(self class pillarNodeFromKind: self kind) new
		setChildren: ( (MicIntraBlockSplitter new splitString: self literal) collect: [:n | n asPillar]);
		reference: self url;
		yourself
]

{ #category : #accessing }
MicInlineBlockWithUrl >> url [
	^ url
]

{ #category : #accessing }
MicInlineBlockWithUrl >> url: anObject [
	url := anObject
]
