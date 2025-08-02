"
I am a bridge to access resources from Microdown clone
"
Class {
	#name : 'MicBridge',
	#superclass : 'GitBridge',
	#category : 'Microdown-Blog-Tests-Utils',
	#package : 'Microdown-Blog-Tests',
	#tag : 'Utils'
}

{ #category : 'accessing' }
MicBridge class >> resources [
	^ self root / 'ressource'
]
