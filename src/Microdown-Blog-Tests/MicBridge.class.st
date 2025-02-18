"
I am a bridge to access resources from Microdown clone
"
Class {
	#name : 'MicBridge',
	#superclass : 'GitBridge',
	#category : 'Microdown-Blog-Tests',
	#package : 'Microdown-Blog-Tests'
}

{ #category : 'accessing' }
MicBridge class >> resources [
	^ self root / 'ressource'
]
