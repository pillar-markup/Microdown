Class {
	#name : #MicInstanceTest,
	#superclass : #MicElementTest,
	#instVars : [
		'instance'
	],
	#category : #'Microdown-Tests-Parser'
}

{ #category : #tests }
MicInstanceTest >> instance [

	^ instance ifNil: [ instance := self testedClass new ]
]

{ #category : #tests }
MicInstanceTest >> testedClass [

	^ self subclassResponsibility 
]
