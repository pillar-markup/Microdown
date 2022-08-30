"
A simple command to request for open .mic files.
"
Class {
	#name : #MicHTMLStylerOpenCommand,
	#superclass : #MicHTMLStylerCommand,
	#category : #'Microdown-HTMLExporter-Spec-Commands'
}

{ #category : #default }
MicHTMLStylerOpenCommand class >> defaultDescription [ 

	^ 'Open a Microdown document'
]

{ #category : #initialization }
MicHTMLStylerOpenCommand class >> defaultIconName [ 

	^ #smallOpen
]

{ #category : #default }
MicHTMLStylerOpenCommand class >> defaultName [

	^ 'Open'
]

{ #category : #'accessing - defaults' }
MicHTMLStylerOpenCommand class >> defaultShortcutKey [ 

	^ $o command mac | $o ctrl win | $o ctrl unix
]

{ #category : #accessing }
MicHTMLStylerOpenCommand class >> order [

	^ 2
]

{ #category : #executing }
MicHTMLStylerOpenCommand >> execute [

	(self requestFileNameForOpen: '*.mic')
		ifNotNil: [ : answer | 
			(self isValidMic: answer)
				ifTrue: [ self context micDocumentFileRef: answer asFileReference ]
				ifFalse: [ self inform: 'File not recognized as Microdown format' ] ]

]

{ #category : #testing }
MicHTMLStylerOpenCommand >> isValidMic: aString [ 
	"Answer <true> if aString is a valid Microdown file (determined by its extension)"
	
	| fileRef |
	
	fileRef := aString asFileReference.
	^ fileRef exists and: [ fileRef extension asLowercase = 'mic'  ]
]

{ #category : #execution }
MicHTMLStylerOpenCommand >> requestFileNameForOpen: extensionString [
	" Open request dialog to select a file "
	
	^ UIManager default 
		chooseFullFileNameMatching: (Array with: extensionString)
		label: 'Choose ' , extensionString , ' file'
]
