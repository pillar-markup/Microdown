Class {
	#name : #MicAbstractInlineBlockWithUrl,
	#superclass : #MicAbstractInlineBlock,
	#instVars : [
		'url'
	],
	#category : #'Microdown-ModelInline'
}

{ #category : #obsolete }
MicAbstractInlineBlockWithUrl class >> from: aStartInteger to: anEndInteger withKind: aKind withSubstring: aString withChildren: aChildren withURL: aURL [
	^ (self from: aStartInteger to: anEndInteger withKind: aKind withSubstring: aString withChildren: aChildren) url: aURL; yourself
]

{ #category : #obsolete }
MicAbstractInlineBlockWithUrl class >> from: aStartInteger to: anEndInteger withKind: aKind withSubstring: aString withURL: aURL [
	^ (self from: aStartInteger to: anEndInteger withKind: aKind withSubstring: aString withChildren: Array empty) url: aURL; yourself
]

{ #category : #accessing }
MicAbstractInlineBlockWithUrl >> url [
	^ url
]

{ #category : #accessing }
MicAbstractInlineBlockWithUrl >> url: anURL [
	url := (anURL isKindOf: ZnUrl) ifTrue: [anURL] ifFalse: [ ZnUrl fromString: anURL ]
]
