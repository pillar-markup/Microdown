"
A simple command to request for open .mic files.
"
Class {
	#name : #MicCSSStylerOpenCommand,
	#superclass : #MicCSSStylerCommand,
	#category : #'Microdown-HTMLExporter-Spec-Commands'
}

{ #category : #'accessing - defaults' }
MicCSSStylerOpenCommand class >> defaultDescription [ 

	^ 'Open a Microdown document'
]

{ #category : #'accessing - defaults' }
MicCSSStylerOpenCommand class >> defaultIconName [ 

	^ #smallOpen
]

{ #category : #'accessing - defaults' }
MicCSSStylerOpenCommand class >> defaultName [

	^ 'Open'
]

{ #category : #'accessing - defaults' }
MicCSSStylerOpenCommand class >> defaultShortcutKey [ 

	^ $o command mac | $o ctrl win | $o ctrl unix
]

{ #category : #accessing }
MicCSSStylerOpenCommand class >> order [

	^ 2
]

{ #category : #execution }
MicCSSStylerOpenCommand >> execute [

	(self requestFileNameForOpen: '*.mic')
		ifNotNil: [ : answer | 
			(self isValidMic: answer)
				ifTrue: [ self context micDocumentFileRef: answer asFileReference ]
				ifFalse: [ self inform: 'File not recognized as Microdown format' ] ]

]

{ #category : #testing }
MicCSSStylerOpenCommand >> isValidMic: aString [ 
	"Answer <true> if aString is a valid Microdown file (determined by its extension)"
	
	| fileRef |
	
	fileRef := aString asFileReference.
	^ fileRef exists and: [ fileRef extension asLowercase = 'mic'  ]
]

{ #category : #execution }
MicCSSStylerOpenCommand >> requestFileNameForOpen: extensionString [
	" Open request dialog to select a file "
	
	^ UIManager default 
		chooseFullFileNameMatching: (Array with: extensionString)
		label: 'Choose ' , extensionString , ' file'
]
