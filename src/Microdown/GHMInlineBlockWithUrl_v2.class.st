Class {
	#name : #'GHMInlineBlockWithUrl_v2',
	#superclass : #'GHMInlineBlock_v2',
	#instVars : [
		'url'
	],
	#category : #'Microdown-Model'
}

{ #category : #'instance creation' }
GHMInlineBlockWithUrl_v2 class >> from: aStartInteger to: anEndInteger withKind: aKind withSubstring: aString withChildren: aChildren withURL: aURL [
	^ (self from: aStartInteger to: anEndInteger withKind: aKind withSubstring: aString withChildren: aChildren) url: aURL; yourself
]

{ #category : #accessing }
GHMInlineBlockWithUrl_v2 >> url [
	^ url
]

{ #category : #accessing }
GHMInlineBlockWithUrl_v2 >> url: anURL [
	url := anURL
]
