Class {
	#name : 'MicResultTest',
	#superclass : 'TestCase',
	#category : 'Microdown-BookTester-Tests',
	#package : 'Microdown-BookTester-Tests'
}

{ #category : 'tests' }
MicResultTest >> testExplanationDuplicatedAnchor [

	| res |
	res := MicDuplicatedAnchorResult new. 
	res anchorLabel: 'ancS0'.
	"pay attention since in this package fromFile is pass a fullName and not a file we will have to change 
	this later"
	res source: '/myDir/chapter1.md'.
	
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
	res source: '/myDir/chapter1.md'.
	
	self 
		assert: res explanation 
		equals: 'Anchor ancS0 is undefined in file: /myDir/chapter1.md'
	
]

{ #category : 'tests' }
MicResultTest >> testSTONFormatExplanationDuplicatedAnchor [

	| res association |
	res := MicDuplicatedAnchorResult new. 
	res anchorLabel: 'ancS0'.
	"pay attention since in this package fromFile is pass a fullName and not a file we will have to change 
	this later"
	res source: '/myDir/chapter1.md'.
	
	association := res stonFormatExplanation.
	
	self 
		assert: (association isKindOf: Association );
		assert:  association key equals: 'ancS0';
		assert: association value equals: '/myDir/chapter1.md'
	
]

{ #category : 'tests' }
MicResultTest >> testSTONFormatExplanationUndefinedAnchor [

	| res association |
	res := MicUndefinedAnchorResult new. 
	res anchorLabel: 'ancS0'.
	"pay attention since in this package fromFile is pass a fullName and not a file we will have to change 
	this later"
	res source: '/myDir/chapter1.md'.
	
	association := res stonFormatExplanation.
	
	self 
		assert: (association isKindOf: Association );
		assert:  association key equals: 'ancS0';
		assert: association value equals: '/myDir/chapter1.md'
	
]

{ #category : 'tests' }
MicResultTest >> testUndefinedFigureFile [

	| res |
	self skip. 
	res := MicUndefinedFigureFileResult new. 
	res inputFileBlock: (MicInputfileBlock new  path: 'myDir/foo.md').
	res source: '/myDir/chapter2.md'.
	"pay attention since in this package fromFile is pass a fullName and not a file we will have to change 
	this later"
	res source: '/myDir/chapter2.md'.
	
	self 
		assert: res explanation 
		equals: 'File input myDir/foo.md (in file /myDir/chapter2.md) does not exist'
	
]

{ #category : 'tests' }
MicResultTest >> testUndefinedInputFile [

	| res |
	res := MicUndefinedInputFileResult new. 
	res inputFileBlock: (MicInputfileBlock new  path: 'myDir/foo.md').
	res source: '/myDir/chapter2.md'.
	"pay attention since in this package fromFile is pass a fullName and not a file we will have to change 
	this later"
	res source: '/myDir/chapter2.md'.
	
	self 
		assert: res explanation 
		equals: 'File input myDir/foo.md (in file /myDir/chapter2.md) does not exist'
	
]
