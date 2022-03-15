"
may be rename the class later
"
Class {
	#name : #MicInputfileBlock,
	#superclass : #MicAnnotationBlock,
	#category : #'Microdown-Extensions'
}

{ #category : #accessing }
MicInputfileBlock class >> tag [ 
	^ #inputFile
]

{ #category : #visiting }
MicInputfileBlock >> accept: aVisitor [
	aVisitor visitInputFile: self
]

{ #category : #visiting }
MicInputfileBlock >> closeMe [
	super closeMe.
	(arguments includesKey: #path)
		ifTrue: [self path: (MicResourceReference fromUri: (arguments at: #path)) ]
		ifFalse: [ (MicParsingError new line: self text, ' must have path argument') signal]
]

{ #category : #accessing }
MicInputfileBlock >> fileWithConfiguration: aConfiguration [
	"I search my file."
	self flag: 'can be better to use the MicPathResolver'.
	^ aConfiguration baseDirectory resolve: self path
]

{ #category : #testing }
MicInputfileBlock >> isRelativeFilePath [
	^ (self path beginsWith: '/') not
]

{ #category : #accessing }
MicInputfileBlock >> originalPath [
	^ self properties at: #originalPath ifAbsent: [ self path ]
]

{ #category : #accessing }
MicInputfileBlock >> path [
	
	^ self arguments at: #path  ifAbsent: [ 'path is absent' ]
]

{ #category : #accessing }
MicInputfileBlock >> path: aPath [
	
	arguments at: #'path' put: aPath
]

{ #category : #accessing }
MicInputfileBlock >> reference [
	^ self arguments at: #path
]

{ #category : #accessing }
MicInputfileBlock >> reference: aMicResourceReference [

	self arguments at: #path put: aMicResourceReference
]
