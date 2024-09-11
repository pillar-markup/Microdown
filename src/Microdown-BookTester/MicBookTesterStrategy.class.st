Class {
	#name : 'MicBookTesterStrategy',
	#superclass : 'Object',
	#instVars : [
		'results'
	],
	#category : 'Microdown-BookTester',
	#package : 'Microdown-BookTester'
}

{ #category : 'hook' }
MicBookTesterStrategy class >> handleKey [

	^ self subclassResponsibility 

]

{ #category : 'accessing' }
MicBookTesterStrategy >> results: aCollection [ 
	results := aCollection
]
