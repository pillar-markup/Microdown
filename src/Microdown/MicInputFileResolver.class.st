Class {
	#name : #MicInputFileResolver,
	#superclass : #MicrodownVisitor,
	#instVars : [
		'topPath'
	],
	#category : #'Microdown-Visitor'
}

{ #category : #accessing }
MicInputFileResolver >> topPath [

	^ topPath
]

{ #category : #accessing }
MicInputFileResolver >> topPath: anObject [

	topPath := anObject
]

{ #category : #visiting }
MicInputFileResolver >> visitInputFile: anInputFile [

	| fileToInput astToInput |
	
	fileToInput := topPath parent resolve: anInputFile path path.
	
	astToInput := Microdown parse: fileToInput readStream.
	
	self visit: astToInput.
	
	"An input file should not be inserted as an inline element.
	Instead it shoud be inserted as a block.
	So, we replace the parent of the input file annotation by the file."
	anInputFile parent replaceByAll: astToInput children
]
