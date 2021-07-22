Class {
	#name : #MicNodeTransformer,
	#superclass : #MicrodownVisitor,
	#instVars : [
		'replacement',
		'configuration'
	],
	#category : #'Microdown-Transformer'
}

{ #category : #execution }
MicNodeTransformer class >> executeOn: aMicContext [
	self new
		"configuration: aMicContext configuration;"
		start: aMicContext input.
	^ aMicContext
]

{ #category : #'instance-creation' }
MicNodeTransformer class >> withContext: aContext [
	"The API is done this way (without using the parameter) because most of the subclasses do not need to access the context of the process (such as files, configuration). Some subclasses may get access by redefine it."
	
	^ self new 
		
]

{ #category : #accessing }
MicNodeTransformer >> configuration [
	"may be delete this later"
	^ configuration
]

{ #category : #accessing }
MicNodeTransformer >> configuration: anObject [
	self halt.
	"may be delete this later"
	configuration := anObject.

]

{ #category : #enumerating }
MicNodeTransformer >> delete [
	"When we do a transformation I replace the current node by nothing."
	self replace: {  }
]

{ #category : #execution }
MicNodeTransformer >> executeOn: aMicContext [
	
	self start: aMicContext input.
	^ aMicContext
]

{ #category : #enumerating }
MicNodeTransformer >> initialize [
	super initialize.
	replacement := Stack new
]

{ #category : #enumerating }
MicNodeTransformer >> replace: newNodes [
	"When we do a transformation I replace the current node by his transformation."

	replacement pop.
	replacement push: newNodes
]

{ #category : #execution }
MicNodeTransformer >> start: anObject [
	super visit: anObject.
	^ anObject
]

{ #category : #execution }
MicNodeTransformer >> visit: aGroup [
	aGroup
		children:
			(aGroup children
				flatCollect: [ :child | 
					replacement push: {child}.
					self visit: child.
					replacement pop]). 
	aGroup accept: self.
]

{ #category : #execution }
MicNodeTransformer >> visitRoot: aGroup [
	aGroup
		children:
			(aGroup children
				flatCollect: [ :child | 
					replacement push: {child}.
					self visit: child.
					replacement pop]). 
]
