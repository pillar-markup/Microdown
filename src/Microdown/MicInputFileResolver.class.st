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
	
	astToInput := anInputFile parser parse: fileToInput readStream.

	self visit: astToInput.
	
	anInputFile replaceByAll: astToInput children
]
