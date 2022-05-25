"
Definition of ""mailto"" scheme (to let the links recognise it).
"
Class {
	#name : #MdsMailtoResourceReference,
	#superclass : #MicAbsoluteResourceReference,
	#category : #'Microdown-MarkdownStrict'
}

{ #category : #'instance creation' }
MdsMailtoResourceReference class >> handlesUriScheme: scheme [
	^ scheme beginsWith: 'mailto'
]

{ #category : #accessing }
MdsMailtoResourceReference >> contents [

	^ self error: 'Should not arrive here?'
]
