Class {
	#name : 'MicScriptBlockExtensionTest',
	#superclass : 'TestCase',
	#pools : [
		'MicMicrodownSharedPool'
	],
	#category : 'Microdown-Tests-Extensions',
	#package : 'Microdown-Tests',
	#tag : 'Extensions'
}

{ #category : 'tests' }
MicScriptBlockExtensionTest >> testExtension [
	"test that codeblock syntax be extended.
	The helper class MicScriptBlockExtensionForTest has extension tag scriptBlockExtentionTest"
	
	| doc extension|
	doc := Microdown parse:  
CodeblockMarkup , 'scriptBlockExtentionTest
stuff which is left for the extension to handle
', CodeblockMarkup.
	self assert: doc children size equals: 1.
	extension := doc children first.
	self assert: extension class equals: MicScriptBlockExtensionForTest.
	self assert: extension body equals: 'stuff which is left for the extension to handle'
]

{ #category : 'tests' }
MicScriptBlockExtensionTest >> testExtensionWithArguments [
	"test that script interpret the arguments correctly"
	
	| doc extension|
	doc := Microdown parse:  
CodeblockMarkup , 'scriptBlockExtentionTest|foo=bar&foe=42
stuff which is left for the extension to handle
', CodeblockMarkup.
	extension := doc children first.
	self 
		assert: (extension arguments at: 'language') equals: 'scriptBlockExtentionTest';
		assert: (extension arguments at: 'foo') equals: 'bar';
		assert: (extension arguments at: 'foe') equals: '42'
]

{ #category : 'tests' }
MicScriptBlockExtensionTest >> testExtensionsAreNotDoneToCodeBlock [
	"One should not make subclasses of codeblock, but script block"
	self assert: MicCodeBlock allSubclasses isEmpty
]

{ #category : 'tests' }
MicScriptBlockExtensionTest >> testUndefinedExtensionIsCodeblock [
	"test that unknown script extensions result in codeblock"
	
	| doc extension|
	doc := Microdown parse:  
CodeblockMarkup , 'unknownExtensionName
stuff which is left for the extension to handle
', CodeblockMarkup.
	extension := doc children first.
	self assert: extension class equals: MicCodeBlock
]
