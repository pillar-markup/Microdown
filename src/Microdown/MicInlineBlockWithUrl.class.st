"
I am used to represent links and images which has a url.
"
Class {
	#name : #MicInlineBlockWithUrl,
	#superclass : #MicInlineBlock,
	#instVars : [
		'url'
	],
	#category : #'Microdown-Model'
}

{ #category : #accessing }
MicInlineBlockWithUrl >> url [
	^ url
]

{ #category : #accessing }
MicInlineBlockWithUrl >> url: anObject [
	url := anObject
]
