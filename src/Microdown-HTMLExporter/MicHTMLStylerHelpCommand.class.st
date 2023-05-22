"
A command to open a Help window explaining Microdown HTML styler topics.
"
Class {
	#name : #MicHTMLStylerHelpCommand,
	#superclass : #MicHTMLStylerCommand,
	#category : #'Microdown-HTMLExporter-Spec-Commands'
}

{ #category : #default }
MicHTMLStylerHelpCommand class >> defaultDescription [ 

	^ 'Help'
]

{ #category : #initialization }
MicHTMLStylerHelpCommand class >> defaultIconName [

	^ #smallHelp
]

{ #category : #default }
MicHTMLStylerHelpCommand class >> defaultName [

	^ 'Help'
]

{ #category : #default }
MicHTMLStylerHelpCommand class >> defaultShortcutKey [

	^ $p command mac | $p ctrl win | $p ctrl unix
]

{ #category : #accessing }
MicHTMLStylerHelpCommand class >> order [

	^ 9
]

{ #category : #executing }
MicHTMLStylerHelpCommand >> execute [
	"Open a Help"

	MicHTMLStylerHelp open.

]
