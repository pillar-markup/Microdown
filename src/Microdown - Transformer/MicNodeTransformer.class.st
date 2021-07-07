Class {
	#name : #MicNodeTransformer,
	#superclass : #MicrodownVisitor,
	#instVars : [
		'replacement',
		'configuration'
	],
	#category : #'Microdown - Transformer'
}

{ #category : #execution }
MicNodeTransformer class >> executeOn: aMicContext [
	self new
		configuration: aMicContext configuration;
		start: aMicContext input.
	^ aMicContext
]

{ #category : #accessing }
MicNodeTransformer >> configuration [
	^ configuration
]

{ #category : #accessing }
MicNodeTransformer >> configuration: anObject [
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

{ #category : #execution }
MicNodeTransformer >> visitText: aText [
]
