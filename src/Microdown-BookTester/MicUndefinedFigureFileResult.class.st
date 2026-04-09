"
I represent a figure referencing an image file that does not exist.
"
Class {
	#name : 'MicUndefinedFigureFileResult',
	#superclass : 'MicFileResult',
	#instVars : [
		'figureFileString'
	],
	#category : 'Microdown-BookTester-References',
	#package : 'Microdown-BookTester',
	#tag : 'References'
}

{ #category : 'kinds' }
MicUndefinedFigureFileResult class >> errorType [

	^ 'UndefinedFigureFiles:'
]

{ #category : 'kinds' }
MicUndefinedFigureFileResult class >> headerString [

	^ 'Undefined figure files:'
]

{ #category : 'accessing' }
MicUndefinedFigureFileResult >> explanation [

	^ 'Figure not found: ', self what,' (in file ', source fullName , ') was not found.'
	
]

{ #category : 'accessing' }
MicUndefinedFigureFileResult >> figureFileString [

	^ figureFileString
]

{ #category : 'accessing' }
MicUndefinedFigureFileResult >> figureFileString: aString [
	
	figureFileString := aString
]

{ #category : 'kinds' }
MicUndefinedFigureFileResult >> headerString [
    ^ 'Undefined Figure File'
]

{ #category : 'accessing' }
MicUndefinedFigureFileResult >> what [ 

	^ figureFileString
]
