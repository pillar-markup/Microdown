"
Definition of ""mailto"" scheme (to let the links recognise it).
"
Class {
	#name : 'MicMailtoResourceReference',
	#superclass : 'MicAbsoluteResourceReference',
	#category : 'Microdown-Macro',
	#package : 'Microdown',
	#tag : 'Macro'
}

{ #category : 'instance creation' }
MicMailtoResourceReference class >> handlesUriScheme: scheme [
	^ scheme beginsWith: 'mailto'
]

{ #category : 'accessing' }
MicMailtoResourceReference >> contents [

	^ self error: 'Should not arrive here?'
]
