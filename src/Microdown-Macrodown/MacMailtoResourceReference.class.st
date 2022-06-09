"
Definition of ""mailto"" scheme (to let the links recognise it).
"
Class {
	#name : #MacMailtoResourceReference,
	#superclass : #MicAbsoluteResourceReference,
	#category : #'Microdown-Macrodown'
}

{ #category : #'instance creation' }
MacMailtoResourceReference class >> handlesUriScheme: scheme [
	^ scheme beginsWith: 'mailto'
]

{ #category : #accessing }
MacMailtoResourceReference >> contents [

	^ self error: 'Should not arrive here?'
]
