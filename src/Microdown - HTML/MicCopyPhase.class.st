Class {
	#name : #MicCopyPhase,
	#superclass : #Object,
	#instVars : [
		'destinationDirectory',
		'sourceDirectory'
	],
	#category : #'Microdown - HTML'
}

{ #category : #'instance-creation' }
MicCopyPhase class >> directory: aString [ 
	
	^ self new
		directory: aString;
		yourself
]

{ #category : #accessing }
MicCopyPhase >> destinationDirectory [
	^ destinationDirectory
]

{ #category : #accessing }
MicCopyPhase >> destinationDirectory: anObject [
	destinationDirectory := anObject
]

{ #category : #executing }
MicCopyPhase >> executeOn: aPRCompilationContext [
	destinationDirectory exists
		ifTrue: [ ^ self ].
	destinationDirectory ensureCreateDirectory.
	sourceDirectory copyAllTo: destinationDirectory.
	^ self
]

{ #category : #accessing }
MicCopyPhase >> sourceDirectory [
	^ sourceDirectory
]

{ #category : #accessing }
MicCopyPhase >> sourceDirectory: anObject [
	sourceDirectory := anObject
]
