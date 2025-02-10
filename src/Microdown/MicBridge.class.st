"
I am a bridge to access resources from Microdown clone
"
Class {
	#name : 'MicBridge',
	#superclass : 'GitBridge',
	#category : 'Microdown-Utils',
	#package : 'Microdown',
	#tag : 'Utils'
}

{ #category : 'accessing' }
MicBridge class >> resources [
	^ self root / 'ressource'
]
