"
This transformer compiles the code content by a codeblock which have the parameters eval at true.

```
MicCodeblockEvaluator new 
	visit: (Microdown
	parse: '```eval=true
stream nextPutAll: ''Hello world''
\```')
```
"
Class {
	#name : 'MicCodeblockEvaluator',
	#superclass : 'MicNodeTransformer',
	#category : 'Microdown-Evaluator',
	#package : 'Microdown-Evaluator'
}

{ #category : 'visiting' }
MicCodeblockEvaluator >> visitCode: aCodeBlock [
	
	aCodeBlock isEvaluated
		ifTrue: [ self replaceCurrentNodeBy: aCodeBlock evaluate ]
]
