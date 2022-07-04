Class {
	#name : #MicCSSStylerPublishCommand,
	#superclass : #MicCSSStylerCommand,
	#category : #'Microdown-HTMLExporter-Spec-Commands'
}

{ #category : #'accessing - defaults' }
MicCSSStylerPublishCommand class >> defaultDescription [ 

	^ 'Publish the HTML version to the web'
]

{ #category : #initialization }
MicCSSStylerPublishCommand class >> defaultIconName [

	^ #smallPublish
]

{ #category : #'accessing - defaults' }
MicCSSStylerPublishCommand class >> defaultName [

	^ 'Publish'
]

{ #category : #default }
MicCSSStylerPublishCommand class >> defaultShortcutKey [

	^ $p command mac | $p ctrl win | $p ctrl unix
]

{ #category : #accessing }
MicCSSStylerPublishCommand class >> order [

	^ 9
]

{ #category : #execution }
MicCSSStylerPublishCommand >> execute [

	self halt
]
