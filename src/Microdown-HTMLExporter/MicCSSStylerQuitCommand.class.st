"
Command to close the application
"
Class {
	#name : #MicCSSStylerQuitCommand,
	#superclass : #MicCSSStylerCommand,
	#category : #'Microdown-HTMLExporter-Spec-Commands'
}

{ #category : #initialization }
MicCSSStylerQuitCommand class >> defaultDescription [ 

	^ 'Close the Styler'
]

{ #category : #initialization }
MicCSSStylerQuitCommand class >> defaultIconName [ 

	^ #smallQuit
]

{ #category : #'accessing - defaults' }
MicCSSStylerQuitCommand class >> defaultName [

	^ 'Quit'
]

{ #category : #accessing }
MicCSSStylerQuitCommand class >> order [

	^ 100
]

{ #category : #execution }
MicCSSStylerQuitCommand >> execute [

	^ self context delete
]
