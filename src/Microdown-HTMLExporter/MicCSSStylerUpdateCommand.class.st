"
Command to update the application source code and styles
"
Class {
	#name : #MicCSSStylerUpdateCommand,
	#superclass : #MicCSSStylerCommand,
	#category : #'Microdown-HTMLExporter-Spec-Commands'
}

{ #category : #'accessing - defaults' }
MicCSSStylerUpdateCommand class >> defaultDescription [ 

	^ 'Check for CSS frameworks updates'
]

{ #category : #'accessing - defaults' }
MicCSSStylerUpdateCommand class >> defaultIconName [ 

	^ #smallUpdate
]

{ #category : #'accessing - defaults' }
MicCSSStylerUpdateCommand class >> defaultName [ 

	^ 'Update'
]

{ #category : #accessing }
MicCSSStylerUpdateCommand class >> order [

	^ 12
]
