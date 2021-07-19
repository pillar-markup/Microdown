Class {
	#name : #MicFailure,
	#superclass : #MicStatus,
	#category : #'Microdown - HTML'
}

{ #category : #controlling }
MicFailure >> and: aMicStatus [
	
	^ self
]

{ #category : #controlling }
MicFailure >> exitProcess [

	Exit signalFailure
]

{ #category : #controlling }
MicFailure >> isFailure [

	^ true
]

{ #category : #controlling }
MicFailure >> isSuccess [

	^ false
]

{ #category : #controlling }
MicFailure >> value [

	^ 1
]
