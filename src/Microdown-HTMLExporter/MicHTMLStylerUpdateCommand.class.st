"
Command to update the application source code and styles
"
Class {
	#name : #MicHTMLStylerUpdateCommand,
	#superclass : #MicHTMLStylerCommand,
	#category : #'Microdown-HTMLExporter-Spec-Commands'
}

{ #category : #default }
MicHTMLStylerUpdateCommand class >> defaultDescription [ 

	^ 'Check for CSS frameworks updates'
]

{ #category : #'accessing - defaults' }
MicHTMLStylerUpdateCommand class >> defaultIconName [ 

	^ #smallUpdate
]

{ #category : #default }
MicHTMLStylerUpdateCommand class >> defaultName [ 

	^ 'Update'
]

{ #category : #accessing }
MicHTMLStylerUpdateCommand class >> order [

	^ 12
]
