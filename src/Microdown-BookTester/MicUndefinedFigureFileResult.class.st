Class {
	#name : 'MicUndefinedFigureFileResult',
	#superclass : 'MicFileResult',
	#instVars : [
		'figureFileString'
	],
	#category : 'Microdown-BookTester-Results',
	#package : 'Microdown-BookTester',
	#tag : 'Results'
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
MicUndefinedFigureFileResult >> figureFileString: aString [
	
	figureFileString := aString
]

{ #category : 'accessing' }
MicUndefinedFigureFileResult >> what [ 

	^ figureFileString
]
