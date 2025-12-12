"
Command to close the application
"
Class {
	#name : 'MicHTMLStylerQuitCommand',
	#superclass : 'MicHTMLStylerCommand',
	#category : 'Microdown-HTMLExporterTools',
	#package : 'Microdown-HTMLExporterTools'
}

{ #category : 'default' }
MicHTMLStylerQuitCommand class >> defaultDescription [ 

	^ 'Close the Styler'
]

{ #category : 'initialization' }
MicHTMLStylerQuitCommand class >> defaultIconName [ 

	^ #smallQuit
]

{ #category : 'default' }
MicHTMLStylerQuitCommand class >> defaultName [

	^ 'Quit'
]

{ #category : 'accessing' }
MicHTMLStylerQuitCommand class >> order [

	^ 100
]

{ #category : 'executing' }
MicHTMLStylerQuitCommand >> execute [

	^ self context delete
]
