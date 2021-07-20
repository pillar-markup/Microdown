Class {
	#name : #MicStatus,
	#superclass : #Object,
	#category : #'Microdown - HTML'
}

{ #category : #'instance creation' }
MicStatus class >> withStatus: aBoolean [


	^ aBoolean 
		ifTrue: [ MicSuccess new ]
		ifFalse: [ MicFailure new ]
]

{ #category : #controlling }
MicStatus >> and: aPRStatus [

	self subclassResponsibility
]

{ #category : #controlling }
MicStatus >> exitProcess [

	self subclassResponsibility
]

{ #category : #controlling }
MicStatus >> isFailure [

	self subclassResponsibility 
]

{ #category : #controlling }
MicStatus >> isSuccess [

	self subclassResponsibility 
]

{ #category : #controlling }
MicStatus >> value [

	self subclassResponsibility
	

]
