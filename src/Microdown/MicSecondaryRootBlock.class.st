Class {
	#name : 'MicSecondaryRootBlock',
	#superclass : 'MicRootBlock',
	#instVars : [
		'file'
	],
	#category : 'Microdown-Model',
	#package : 'Microdown',
	#tag : 'Model'
}

{ #category : 'testing' }
MicSecondaryRootBlock >> accept: aVisitor [

	^ aVisitor visitSecondaryRootBlock: self
]

{ #category : 'testing' }
MicSecondaryRootBlock >> file [

	^ file
]

{ #category : 'testing' }
MicSecondaryRootBlock >> file: aFileReference [

	file := aFileReference
]
