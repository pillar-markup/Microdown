Class {
	#name : #MicAbstractInlineBlockWithUrl,
	#superclass : #MicAbstractInlineBlock,
	#instVars : [
		'url'
	],
	#category : #'Microdown-ModelInline'
}

{ #category : #'pillar conversion' }
MicAbstractInlineBlockWithUrl class >> associatedPRClass [
	"I am abstract"
]

{ #category : #obsolete }
MicAbstractInlineBlockWithUrl class >> from: aStartInteger to: anEndInteger withKind: aKind withSubstring: aString withChildren: aChildren withURL: aURL [
	^ (self from: aStartInteger to: anEndInteger withKind: aKind withSubstring: aString withChildren: aChildren) url: aURL; urlTransformation; yourself
]

{ #category : #converting }
MicAbstractInlineBlockWithUrl >> asPillar [
	^(self class associatedPRClass) new
		setChildren: ( (MicInlineSplitter new start: self substring) collect: [:n | n asPillar]);
		reference: self url;
		yourself
]

{ #category : #accessing }
MicAbstractInlineBlockWithUrl >> url [
	^ url
]

{ #category : #accessing }
MicAbstractInlineBlockWithUrl >> url: anURL [
	url := anURL
]

{ #category : #transformation }
MicAbstractInlineBlockWithUrl >> urlTransformation [
	self url: (ZnUrl fromString: self url)
]
