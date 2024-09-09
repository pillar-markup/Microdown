Class {
	#name : 'MicSyncTesterStrategy',
	#superclass : 'MicBookTesterStrategy',
	#category : 'Microdown-BookTester',
	#package : 'Microdown-BookTester'
}

{ #category : 'as yet unclassified' }
MicSyncTesterStrategy class >> handleKey [

	^ 'sync'

]

{ #category : 'main API' }
MicSyncTesterStrategy >> verify: aCodeBlock [

	| originString imageCode |
	
	"we check to handle sync=false"
	aCodeBlock isSync
		ifFalse: [ ^ self ].
	
	
	originString := aCodeBlock arguments at: #origin.
	
	('*>>*' match: originString) ifTrue: [
		imageCode := (OpalCompiler new
			              source: originString;
			              evaluate) sourceCode.
		"we should think about all the possible uglies that may arise here
			- wrong class
			- wrong method and even do not use evaluate:"
		aCodeBlock body = imageCode ifFalse: [
			results add: (MicDesynchronizedCodeResult new
					 originString: originString;
					 bookContents: aCodeBlock body;
					 imageContent: imageCode;
					 pharoVersion: Smalltalk image lastUpdateString) ] ]
]
