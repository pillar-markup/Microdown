Class {
	#name : 'MicMailtoResourceReference',
	#superclass : 'MicAbsoluteResourceReference',
	#category : 'Microdown-Core',
	#package : 'Microdown',
	#tag : 'Core'
}

{ #category : 'instance creation' }
MicMailtoResourceReference class >> handlesUriScheme: scheme [
	^ scheme beginsWith: 'mailto'
]
