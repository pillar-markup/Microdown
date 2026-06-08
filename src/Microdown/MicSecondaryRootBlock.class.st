Class {
	#name : 'MicSecondaryRootBlock',
	#superclass : 'MicRootBlock',
	#category : 'Microdown-Model',
	#package : 'Microdown',
	#tag : 'Model'
}

{ #category : 'testing' }
MicSecondaryRootBlock >> accept: aVisitor [

	^ aVisitor visitSecondaryRootBlock: self
]

{ #category : 'testing' }
MicSecondaryRootBlock >> isSecondaryRoot [
	^ true
]
