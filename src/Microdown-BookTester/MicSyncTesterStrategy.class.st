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

{ #category : 'as yet unclassified' }
MicSyncTesterStrategy >> handleBrokenSyncValue: aString of: aMicCodeBlock [ 

	results add: (MicBrokenSyncDefinition new
							syncValue: aString;
							codeBlock: aMicCodeBlock;
							yourself)
]

{ #category : 'main API' }
MicSyncTesterStrategy >> verify: aCodeBlock [

	| originString imageCode syncValue |
	
	"we check to handle sync=false and sync=whatever"
	syncValue := aCodeBlock arguments at: self class handleKey. 

	"we do not check if declared to not check"	
	syncValue = 'false'
		ifTrue: [  ^ self ].
	
	"for all the values other than 'true' we report a problem because
	the user took the time to define it but he made a typo."
		
	syncValue = 'true'
		ifFalse: [ self handleBrokenSyncValue: syncValue of: aCodeBlock ]
		ifTrue: [
		
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
]
