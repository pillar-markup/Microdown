Class {
	#name : #MicDocumentList,
	#superclass : #MicAnnotationBlock,
	#category : #'Microdown-Extensions'
}

{ #category : #accessing }
MicDocumentList class >> tag [ 
	^ #documentlist
]

{ #category : #visiting }
MicDocumentList >> accept: aVisitor [

	^ aVisitor visitDocListAnnotation: self
]

{ #category : #visiting }
MicDocumentList >> limit [

	^ self arguments at: #limit ifAbsent: [ '3' ]
]

{ #category : #visiting }
MicDocumentList >> path [

	^ self arguments at: #path
]

{ #category : #visiting }
MicDocumentList >> sort [

	^ self arguments at: #sort ifAbsent: [ '' ]
]

{ #category : #visiting }
MicDocumentList >> summaryMaxSize [

	^ self arguments at: #summaryMaxSize
		ifPresent: [ :size | size asInteger ]
		ifAbsent: [ 500 ]
]

{ #category : #visiting }
MicDocumentList >> templates [

	^ self arguments at: #templates ifAbsent: [ #() ]
]
