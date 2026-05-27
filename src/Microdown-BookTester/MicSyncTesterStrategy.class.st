Class {
	#name : 'MicSyncTesterStrategy',
	#superclass : 'MicCodeBlockTesterStrategy',
	#category : 'Microdown-BookTester-Checker-CodeBlockAnalysis',
	#package : 'Microdown-BookTester',
	#tag : 'Checker-CodeBlockAnalysis'
}

{ #category : 'hook' }
MicSyncTesterStrategy class >> handleKey [

	^ #sync

]

{ #category : 'main API' }
MicSyncTesterStrategy >> handleBrokenOrigin: aString of: aMicCodeBlock [ 
	
	results add: ( MicBrokenSyncOriginDefinitionResult new 
							originString: aString;
							inFile: aMicCodeBlock fromFile;
							yourself )
]

{ #category : 'main API' }
MicSyncTesterStrategy >> handleBrokenSyncValue: aString of: aMicCodeBlock [ 

	results add: (MicBrokenSyncDefinitionResult new
							syncValue: aString;
							inFile: aMicCodeBlock fromFile;
							yourself)
]

{ #category : 'main API' }
MicSyncTesterStrategy >> verify: aCodeBlock [

	| originString syncValue splits method className isMeta |
	
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

			splits := originString splitOn: '>>'.
			( splits size = 2 ) 
				ifFalse: [ self handleBrokenOrigin: originString of: aCodeBlock ]
				ifTrue: [
					| class |
			
					className := splits first splitOn: Character space. 
					isMeta := false.
					className size = 2
						ifTrue: [ isMeta := className second trimBoth.
							isMeta := isMeta = 'class'  ].
					class := Smalltalk globals 
							at: className first asSymbol	
							ifAbsent: [ ^ self handleBrokenOrigin: originString of: aCodeBlock ].
			isMeta 
				ifTrue: [ class := class class ].	
			
			class 
				compiledMethodAt: splits second trimBoth allButFirst asSymbol
				ifPresent: [ :m | method := m  ]
				ifAbsent: [ ^ self 
									handleBrokenOrigin: originString 
									of: aCodeBlock ].
		
		aCodeBlock body = method sourceCode ifFalse: [
			results add: (MicDesynchronizedCodeResult new
					 originString: originString;
					 inFile: aCodeBlock fromFile;
					 bookContents: aCodeBlock body;
					 imageContent: method sourceCode;
					 pharoVersion:SystemVersion current major) ] ]
		]
]
