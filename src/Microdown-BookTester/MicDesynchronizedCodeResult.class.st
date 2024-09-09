Class {
	#name : 'MicDesynchronizedCodeResult',
	#superclass : 'MicResult',
	#instVars : [
		'originString',
		'bookContents',
		'imageContents',
		'pharoVersion'
	],
	#category : 'Microdown-BookTester',
	#package : 'Microdown-BookTester'
}

{ #category : 'as yet unclassified' }
MicDesynchronizedCodeResult >> bookContent [
	^ bookContents
]

{ #category : 'accessing' }
MicDesynchronizedCodeResult >> bookContents [
	^ bookContents
]

{ #category : 'as yet unclassified' }
MicDesynchronizedCodeResult >> bookContents: aString [ 
	bookContents := aString
]

{ #category : 'as yet unclassified' }
MicDesynchronizedCodeResult >> imageContent: aString [ 
	imageContents := aString
]

{ #category : 'accessing' }
MicDesynchronizedCodeResult >> imageContents [
	^ imageContents
]

{ #category : 'accessing' }
MicDesynchronizedCodeResult >> originString [
	^ originString
]

{ #category : 'as yet unclassified' }
MicDesynchronizedCodeResult >> originString: aString [ 
	originString := aString
]

{ #category : 'as yet unclassified' }
MicDesynchronizedCodeResult >> pharoVersion: aString [ 
	pharoVersion := aString
]
