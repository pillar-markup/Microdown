"
I am a lazy collection. I do not load my children until asked.
"
Class {
	#name : #MicClassPackageDocumentCollection,
	#superclass : #MicDocumentCollection,
	#category : #'Microdown-DocumentBrowser-Model'
}

{ #category : #displaying }
MicClassPackageDocumentCollection >> subLevels [
	"I ask my provider to get my children"
	"It is important the first #children is iv, and the second is method call"
	^ children ifNil: [ self provider setChildrenOf: self. self children ].
]
