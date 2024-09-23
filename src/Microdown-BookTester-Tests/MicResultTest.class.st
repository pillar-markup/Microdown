Class {
	#name : 'MicResultTest',
	#superclass : 'MicFileTest',
	#category : 'Microdown-BookTester-Tests',
	#package : 'Microdown-BookTester-Tests'
}

{ #category : 'tests' }
MicResultTest >> testExplanationDuplicatedAnchor [

	| res |
	res := MicDuplicatedAnchorResult new. 
	res anchorLabel: 'ancS0'.
	res sourceFileReference: '/myDir/chapter1.md' asFileReference.
	
	self 
		assert: res explanation 
		equals: 'Anchor ancS0 is duplicated in file: /myDir/chapter1.md'
	
]

{ #category : 'tests' }
MicResultTest >> testExplanationUndefinedAnchor [

	| res |
	res := MicUndefinedAnchorResult new. 
	res anchorLabel: 'ancS0'.
	"pay attention since in this package fromFile is pass a fullName and not a file we will have to change 
	this later"
	res sourceFileReference: '/myDir/chapter1.md' asFileReference.
	
	self 
		assert: res explanation 
		equals: 'Anchor ancS0 is undefined in file: /myDir/chapter1.md'
	
]

{ #category : 'tests - basic result creation' }
MicResultTest >> testMicBookTestResultExplanationWorksWithEmptyInstance [
	

	self 
		assert: MicBookTestResult new explanation 
		equals: 'test status: Passed
isExpectedFailure?  false
Description of the test result : Test failed without raising an exception
the concerned code Block  :  here we should get an expression
from the source file:  /'
]

{ #category : 'tests - basic result creation' }
MicResultTest >> testMicBrokenSyncDefinitionResultExplanationWorksWithEmptyInstance [
	
	self flag: #improve. 
	"I do not like these tests that test string."
	self 
		assert: MicBrokenSyncDefinition new explanation 
		equals: 'The sync definition has the following broken value: empty .'
]

{ #category : 'tests - basic result creation' }
MicResultTest >> testResultCreation [

	{ MicBookTestResult . MicBrokenSyncDefinition . MicBrokenSyncOriginDefinition . MicDesynchronizedCodeResult .  MicDuplicatedAnchorResult . MicUndefinedAnchorResult . MicUndefinedFigureFileResult . MicUndefinedInputFileResult} do: [ :each | each new printString ]
]

{ #category : 'tests - basic result creation' }
MicResultTest >> testResultCreationSmokeTest [

	{ MicBookTestResult . MicBrokenSyncDefinition . MicBrokenSyncOriginDefinition . MicDesynchronizedCodeResult .  MicDuplicatedAnchorResult . MicUndefinedAnchorResult . MicUndefinedFigureFileResult . MicUndefinedInputFileResult} do: [ :each | each new printString ]
]

{ #category : 'tests' }
MicResultTest >> testSTONFormatExplanationDuplicatedAnchor [

	| res association |
	res := MicDuplicatedAnchorResult new. 
	res anchorLabel: 'ancS0'.
	"pay attention since in this package fromFile is pass a fullName and not a file we will have to change 
	this later"
	res sourceFileReference: '/myDir/chapter1.md' asFileReference.
	
	association := res stonFormatExplanation.
	
	self 
		assert: (association isKindOf: Association );
		assert:  association key equals: 'ancS0';
		assert: association value fullName equals: '/myDir/chapter1.md'
	
]

{ #category : 'tests' }
MicResultTest >> testSTONFormatExplanationUndefinedAnchor [

	| res association |
	res := MicUndefinedAnchorResult new. 
	res anchorLabel: 'ancS0'.
	"pay attention since in this package fromFile is pass a fullName and not a file we will have to change 
	this later"
	res sourceFileReference: '/myDir/chapter1.md' asFileReference .
	
	association := res stonFormatExplanation.
	
	self 
		assert: (association isKindOf: Association );
		assert:  association key equals: 'ancS0';
		assert: association value fullName equals: '/myDir/chapter1.md'
	
]

{ #category : 'tests' }
MicResultTest >> testUndefinedFigureFile [

	| res |
	res := MicUndefinedFigureFileResult new. 
	res figureFileString: 'myDir/foo.png'.
	res sourceFileReference: '/myDir/chapter2.md' asFileReference.
	
	self 
		assert: res explanation 
		equals: 'File input myDir/foo.png (in file /myDir/chapter2.md) does not exist'
	
]

{ #category : 'tests' }
MicResultTest >> testUndefinedInputFile [

	| res |
	res := MicUndefinedInputFileResult new. 
	res inputFileBlock: (MicInputfileBlock new  path: 'myDir/foo.md').
	res sourceFileReference: '/myDir/chapter2.md' asFileReference.
	res sourceFileReference: '/myDir/chapter2.md' asFileReference.
	
	self 
		assert: res explanation 
		equals: 'File input myDir/foo.md (in file /myDir/chapter2.md) does not exist'
	
]
