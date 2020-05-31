Class {
	#name : #MicInlineBlockWithUrl2,
	#superclass : #MicInlineBlock2,
	#instVars : [
		'url'
	],
	#category : #'Microdown-Model'
}

{ #category : #'instance creation' }
MicInlineBlockWithUrl2 class >> from: aStartInteger to: anEndInteger withKind: aKind withString: aString withChildren: aChildren withURL: aURL [
	^ (self from: aStartInteger to: anEndInteger withKind: aKind withString: aString withChildren: aChildren) url: aURL; yourself
]

{ #category : #obsolete }
MicInlineBlockWithUrl2 class >> from: aStartInteger to: anEndInteger withKind: aKind withSubstring: aString withChildren: aChildren withURL: aURL [
	^ (self from: aStartInteger to: anEndInteger withKind: aKind withSubstring: aString withChildren: aChildren) url: aURL; yourself
]

{ #category : #accessing }
MicInlineBlockWithUrl2 >> url [
	^ url
]

{ #category : #accessing }
MicInlineBlockWithUrl2 >> url: anURL [
	url := anURL
]
