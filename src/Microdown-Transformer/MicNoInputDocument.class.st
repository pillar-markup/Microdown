"
I represent unknown file extension.
"
Class {
	#name : #MicNoInputDocument,
	#superclass : #MicInputDocument,
	#category : #'Microdown-Transformer'
}

{ #category : #registration }
MicNoInputDocument class >> doesHandleExtension: anExtension [

	^ false
]

{ #category : #accessing }
MicNoInputDocument >> parserClass [ 
	"may be the error should not be raised here."
	
	self error: 'Extension file ', file extension, 'not recognized'
]
