"
I report that a code block contains code that is not the same than the one in the current image. 
"
Class {
	#name : 'MicDesynchronizedCodeResult',
	#superclass : 'MicResult',
	#instVars : [
		'originString',
		'bookContents',
		'imageContents',
		'pharoVersion'
	],
	#category : 'Microdown-BookTester-Results',
	#package : 'Microdown-BookTester',
	#tag : 'Results'
}

{ #category : 'kinds' }
MicDesynchronizedCodeResult class >> headerString [

	^ 'Desynchronized method body'
]

{ #category : 'accessing' }
MicDesynchronizedCodeResult >> bookContents [
	^ bookContents
]

{ #category : 'accessing' }
MicDesynchronizedCodeResult >> bookContents: aString [ 
	bookContents := aString
]

{ #category : 'accessing' }
MicDesynchronizedCodeResult >> explanation [

	^ 'The code block body of ', originString , ' is not in sync with the version in Pharo ', pharoVersion, 'in file: ', source  fullName
]

{ #category : 'accessing' }
MicDesynchronizedCodeResult >> imageContent: aString [ 
	imageContents := aString
]

{ #category : 'accessing' }
MicDesynchronizedCodeResult >> imageContents [
	^ imageContents
]

{ #category : 'initialization' }
MicDesynchronizedCodeResult >> initialize [

	super initialize.
	bookContents := 'book contents'.
	imageContents := 'image contents'.
	originString := 'C [class]>>#selector'.
	pharoVersion := '>12'
	
]

{ #category : 'accessing' }
MicDesynchronizedCodeResult >> originString [
	^ originString
]

{ #category : 'accessing' }
MicDesynchronizedCodeResult >> originString: aString [ 
	originString := aString
]

{ #category : 'accessing' }
MicDesynchronizedCodeResult >> pharoVersion: aString [ 
	pharoVersion := aString
]
