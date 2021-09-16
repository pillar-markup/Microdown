"
may be rename the class later
"
Class {
	#name : #MicInputFileBlock,
	#superclass : #MicAnnotationBlock,
	#category : #'Microdown-Extensions'
}

{ #category : #accessing }
MicInputFileBlock class >> tag [ 
	^ #inputfile
]

{ #category : #visiting }
MicInputFileBlock >> accept: aVisitor [
	aVisitor visitInputfile: self
]

{ #category : #testing }
MicInputFileBlock >> closeMe [
	| p |
	super closeMe.
	p := arguments at: #path ifAbsent: [ 'notfound' ].
	p = 'notfound'
		ifTrue: [ self path: (MicBrokenResource new originalString: substring; yourself) ]
		ifFalse: [self path: (MicResourceReference fromString: (arguments at: #path)) ]
]

{ #category : #accessing }
MicInputFileBlock >> fileWithConfiguration: aConfiguration [
	"I search my file."
	self flag: 'can be better to use the MicPathResolver'.
	^ aConfiguration baseDirectory resolve: self path
]

{ #category : #testing }
MicInputFileBlock >> isRelativeFilePath [
	^ (self path beginsWith: '/') not
]

{ #category : #accessing }
MicInputFileBlock >> originalPath [
	^ properties at: #originalPath ifAbsent: [ self path ]
]

{ #category : #accessing }
MicInputFileBlock >> path [
	
	^ self arguments at: #path  ifAbsent: [ self halt. ^ 'path is absent' ]
]

{ #category : #accessing }
MicInputFileBlock >> path: aPath [
	
	arguments at: #'path' put: aPath
]
