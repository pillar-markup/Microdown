"
I'm a special visitor that replaces a node by another one. 

I'm used for example to replace a codeblock by the result of the evaluation of the code block body.
Another important example is how to input a file in another one.
"
Class {
	#name : 'MicNodeTransformer',
	#superclass : 'MicrodownVisitor',
	#instVars : [
		'replacement',
		'configuration'
	],
	#category : 'Microdown-Transformer',
	#package : 'Microdown-Transformer'
}

{ #category : 'execution' }
MicNodeTransformer class >> executeOn: aMicContext [
	self new
		"configuration: aMicContext configuration;"
		start: aMicContext input.
	^ aMicContext
]

{ #category : 'instance creation' }
MicNodeTransformer class >> withContext: aContext [
	"The API is done this way (without using the parameter) because most of the subclasses do not need to access the context of the process (such as files, configuration). Some subclasses may get access by redefine it."
	
	^ self new 
		
]

{ #category : 'accessing' }
MicNodeTransformer >> configuration [

	^ configuration
]

{ #category : 'accessing' }
MicNodeTransformer >> configuration: anObject [

	configuration := anObject.

]

{ #category : 'enumerating' }
MicNodeTransformer >> delete [
	"When we do a transformation I replace the current node by nothing."
	
	self replaceCurrentNodeBy: {  }
]

{ #category : 'execution' }
MicNodeTransformer >> executeOn: aMicContext [
	
	self visit: aMicContext input.
	^ aMicContext
]

{ #category : 'enumerating' }
MicNodeTransformer >> initialize [

	super initialize.
	replacement := Stack new
]

{ #category : 'execution' }
MicNodeTransformer >> replaceChildrenOf: aGroup [
	aGroup
		children:
			(aGroup children
				flatCollect: [ :child | 
					replacement push: {child}.
					self visitAll: child.
					replacement pop]). 
]

{ #category : 'enumerating' }
MicNodeTransformer >> replaceCurrentNodeBy: newNodes [
	"When we do a transformation I replace the current node by its transformation."

	replacement pop.
	replacement push: newNodes
]

{ #category : 'execution' }
MicNodeTransformer >> visit: anObject [
	super visit: anObject.
	^ anObject
]

{ #category : 'execution' }
MicNodeTransformer >> visitAll: aGroup [
	self replaceChildrenOf: aGroup.
	aGroup accept: self.
]

{ #category : 'execution' }
MicNodeTransformer >> visitRoot: aGroup [
	self replaceChildrenOf: aGroup 
]
