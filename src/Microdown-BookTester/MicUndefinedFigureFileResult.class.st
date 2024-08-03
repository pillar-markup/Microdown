Class {
	#name : 'MicUndefinedFigureFileResult',
	#superclass : 'MicFileResult',
	#instVars : [
		'figureFileString'
	],
	#category : 'Microdown-BookTester',
	#package : 'Microdown-BookTester'
}

{ #category : 'accessing' }
MicUndefinedFigureFileResult >> figureFileString: aString [
	
	figureFileString := aString
]

{ #category : 'accessing' }
MicUndefinedFigureFileResult >> what [ 

	^ figureFileString
]
