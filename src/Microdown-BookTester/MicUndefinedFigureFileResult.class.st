"
I represent a figure referencing an image file that does not exist.
"
Class {
	#name : 'MicUndefinedFigureFileResult',
	#superclass : 'MicFileResult',
	#instVars : [
		'figureFileString'
	],
	#category : 'Microdown-BookTester-Checker-References',
	#package : 'Microdown-BookTester',
	#tag : 'Checker-References'
}

{ #category : 'kinds' }
MicUndefinedFigureFileResult class >> errorType [

	^ 'UndefinedFigureFiles:'
]

{ #category : 'accessing' }
MicUndefinedFigureFileResult >> explanation [

	^ 'Figure not found: ', self what,' (in file ', fileReference fullName , ') was not found.'
	
]

{ #category : 'accessing' }
MicUndefinedFigureFileResult >> figureFileString [

	^ figureFileString
]

{ #category : 'accessing' }
MicUndefinedFigureFileResult >> figureFileString: aString [
	
	figureFileString := aString
]

{ #category : 'accessing' }
MicUndefinedFigureFileResult >> headerString [

	^ 'Undefined Figure File'
]

{ #category : 'accessing' }
MicUndefinedFigureFileResult >> what [ 

	^ figureFileString
]
