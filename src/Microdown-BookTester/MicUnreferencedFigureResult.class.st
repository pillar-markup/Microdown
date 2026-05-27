"
I represent a figure that refers to a file that does not exist.
"
Class {
	#name : 'MicUnreferencedFigureResult',
	#superclass : 'MicResult',
	#instVars : [
		'figure',
		'anchorLabel',
		'figurePath'
	],
	#category : 'Microdown-BookTester-Checker-References',
	#package : 'Microdown-BookTester',
	#tag : 'Checker-References'
}

{ #category : 'accessing' }
MicUnreferencedFigureResult >> anchorLabel [

	^ anchorLabel 
]

{ #category : 'accessing' }
MicUnreferencedFigureResult >> anchorLabel: aString [

	anchorLabel := aString
]

{ #category : 'accessing' }
MicUnreferencedFigureResult >> explanation [

	^ 'Figure ', self what,' with anchor ', anchorLabel printString, ' (in file ', fileReference fullName , ') is not referenced.'
	
]

{ #category : 'accessing' }
MicUnreferencedFigureResult >> figure: aFigureBlock [

	figure := aFigureBlock
]

{ #category : 'accessing' }
MicUnreferencedFigureResult >> figurePath [

	^ figurePath
]

{ #category : 'accessing' }
MicUnreferencedFigureResult >> figurePath: aString [

	figurePath := aString
]

{ #category : 'accessing' }
MicUnreferencedFigureResult >> what [ 

	^ figurePath printString
]
