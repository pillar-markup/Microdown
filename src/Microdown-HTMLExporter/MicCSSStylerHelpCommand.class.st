Class {
	#name : #MicCSSStylerHelpCommand,
	#superclass : #MicCSSStylerCommand,
	#category : #'Microdown-HTMLExporter-Spec-Commands'
}

{ #category : #'accessing - defaults' }
MicCSSStylerHelpCommand class >> defaultDescription [ 

	^ 'Help'
]

{ #category : #initialization }
MicCSSStylerHelpCommand class >> defaultIconName [

	^ #smallHelp
]

{ #category : #'accessing - defaults' }
MicCSSStylerHelpCommand class >> defaultName [

	^ 'Help'
]

{ #category : #default }
MicCSSStylerHelpCommand class >> defaultShortcutKey [

	^ $p command mac | $p ctrl win | $p ctrl unix
]

{ #category : #accessing }
MicCSSStylerHelpCommand class >> order [

	^ 9
]

{ #category : #executing }
MicCSSStylerHelpCommand >> execute [
	"Open a Help"

	MicHTMLStylerHelp open.

]
