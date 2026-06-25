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
MicSecondaryRootBlock >> fromFile: aFileOrResource [
	self propertyAt: #file put: aFileOrResource
]

{ #category : 'testing' }
MicSecondaryRootBlock >> isSecondaryRoot [
	^ true
]

{ #category : 'testing' }
MicSecondaryRootBlock >> updateLineNumberIn: aParser [
	aParser currentLineNumber: 1.
]
