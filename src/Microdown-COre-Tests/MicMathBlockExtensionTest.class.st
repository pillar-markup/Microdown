Class {
	#name : #MicMathBlockExtensionTest,
	#superclass : #TestCase,
	#pools : [
		'MicMicrodownSharedPool'
	],
	#category : #'Microdown-Tests-Extensions'
}

{ #category : #tests }
MicMathBlockExtensionTest >> testExtension [
	"test that the math environment can also be extended. For this we just have to specify the tag
	associated to the class."
	
	| doc extension|
	doc := Microdown parse:  
MathOpeningBlockMarkup, 'mathBlockExtentionTest
stuff which is left for the extension to handle
', MathClosingBlockMarkup.
	self assert: doc children size equals: 1.
	extension := doc children first.
	self assert: extension class equals: MicMathBlockExtensionForTest.
	self assert: extension body equals: 'stuff which is left for the extension to handle'
]
