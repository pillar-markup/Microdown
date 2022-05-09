Class {
	#name : #MicMathBlockExtensionTest,
	#superclass : #TestCase,
	#category : #'Microdown-Tests-Extensions'
}

{ #category : #tests }
MicMathBlockExtensionTest >> testExtension [
	
	| doc extension|
	doc := Microdown parse:  
'
&mathBlockExtentionTest
stuff which is left for the extension to handle
&'.
	self assert: doc children size equals: 1.
	extension := doc children first.
	self assert: extension class equals: MicMathBlockExtensionForTest.
	self assert: extension body equals: 'stuff which is left for the extension to handle'
]
