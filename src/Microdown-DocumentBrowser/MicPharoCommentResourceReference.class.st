Class {
	#name : #MicPharoCommentResourceReference,
	#superclass : #MicAbsoluteResourceReference,
	#category : #'Microdown-DocumentBrowser-ResourceModel'
}

{ #category : #'instance creation' }
MicPharoCommentResourceReference class >> newFromUri: aUri [
	"I assume aUri to be a ZnUrl"
	aUri host = 'class'
		ifTrue: [ ^ MicPharoClassCommentResourceReference new uri: aUri ].
	aUri host = 'package'
		ifTrue: [ ^ MicPharoPackageCommentResourceReference  new uri: aUri ].
	(MicResourceReferenceError new 
		messageText: 'the host in comments must be either class or package - in ', aUri printString
	) signal
]

{ #category : #accessing }
MicPharoCommentResourceReference >> binaryReadStream [
	"comments are not in binary format"
	MicResourceReferenceError signal: 'Pharo comments cannot be read in binary format'
]
