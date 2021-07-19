Class {
	#name : #MicSuccess,
	#superclass : #MicStatus,
	#category : #'Microdown - HTML'
}

{ #category : #controlling }
MicSuccess >> and: aMicStatus [

	^ aMicStatus
]

{ #category : #controlling }
MicSuccess >> exitProcess [

	Exit signalSuccess
]

{ #category : #controlling }
MicSuccess >> isFailure [

	^ false
]

{ #category : #controlling }
MicSuccess >> isSuccess [

	^ true
]

{ #category : #controlling }
MicSuccess >> value [
	
	^ 0
]
