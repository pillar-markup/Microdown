"
I represent an error result computed by a checker for example `MicReferenceChecker`.

I am composed of:
- an explanation (of my error)
- a specification (the name of concerned file or reference)

My error type allows a report writer to sort the results into meaning groups.


"
Class {
	#name : 'MicResult',
	#superclass : 'Object',
	#instVars : [
		'message',
		'status',
		'source',
		'explanation'
	],
	#category : 'Microdown-BookTester-Core',
	#package : 'Microdown-BookTester',
	#tag : 'Core'
}

{ #category : 'kinds' }
MicResult class >> errorType [

	^ self subclassResponsibility 
]

{ #category : 'kinds' }
MicResult class >> headerString [

	^ 'Unreferenced Figures'
]

{ #category : 'accessing' }
MicResult >> detail [
	^ nil
]

{ #category : 'accessing' }
MicResult >> explanation [

	^ self subclassResponsibility
]

{ #category : 'kinds' }
MicResult >> headerString [ 
	^ self class name
]

{ #category : 'accessing' }
MicResult >> inFile: aFileReference [
    source := aFileReference
]

{ #category : 'accessing' }
MicResult >> message [

	^ message
]

{ #category : 'accessing' }
MicResult >> message: anObject [

	message := anObject
]

{ #category : 'accessing' }
MicResult >> sourceFileReference [

	^ source
]

{ #category : 'accessing' }
MicResult >> sourceFileReference: anObject [

	source := anObject
]

{ #category : 'accessing' }
MicResult >> status [

	^ status
]

{ #category : 'accessing' }
MicResult >> status: anObject [

	status := anObject
]

{ #category : 'accessing' }
MicResult >> stonFormatExplanation [

	^ self subclassResponsibility
]

{ #category : 'accessing' }
MicResult >> what [
	^ nil
]
