"
I'm the root of book validation strategy.
A strategy is attached to a tag in a codeblock.

For example, when a codeblock contains the example tag as defined below, then the CodeBlockValidator will execute the strategy associated with it (using handleKey). 

```example

3 + 2 
>>> 5

```


"
Class {
	#name : 'MicCodeBlockTesterStrategy',
	#superclass : 'Object',
	#instVars : [
		'results'
	],
	#category : 'Microdown-BookTester-Checker-CodeBlockAnalysis',
	#package : 'Microdown-BookTester',
	#tag : 'Checker-CodeBlockAnalysis'
}

{ #category : 'hook' }
MicCodeBlockTesterStrategy class >> handleKey [

	^ self subclassResponsibility 

]

{ #category : 'accessing' }
MicCodeBlockTesterStrategy >> results: aCollection [ 
	results := aCollection
]
