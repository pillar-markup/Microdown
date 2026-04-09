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
	#category : 'Microdown-BookTester-References',
	#package : 'Microdown-BookTester',
	#tag : 'References'
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

	^ 'Figure ', self what,' with anchor ', anchorLabel printString, ' (in file ', source fullName , ') is not referenced.'
	
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

{ #category : 'kinds' }
MicUnreferencedFigureResult >> headerString [
    ^ 'Unreferenced Figure'
]

{ #category : 'accessing' }
MicUnreferencedFigureResult >> what [ 

	^ figurePath
]
