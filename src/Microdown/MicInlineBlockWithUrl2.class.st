Class {
	#name : #MicInlineBlockWithUrl2,
	#superclass : #MicInlineBlock2,
	#instVars : [
		'url'
	],
	#category : #'Microdown-Model'
}

{ #category : #obsolete }
MicInlineBlockWithUrl2 class >> from: aStartInteger to: anEndInteger withKind: aKind withSubstring: aString withChildren: aChildren withURL: aURL [
	^ (self from: aStartInteger to: anEndInteger withKind: aKind withSubstring: aString withChildren: aChildren) url: aURL; urlTransformation; yourself
]

{ #category : #accessing }
MicInlineBlockWithUrl2 >> url [
	^ url
]

{ #category : #accessing }
MicInlineBlockWithUrl2 >> url: anURL [
	url := anURL
]

{ #category : #transformation }
MicInlineBlockWithUrl2 >> urlTransformation [
	self url: (ZnUrl fromString: self url)
]
