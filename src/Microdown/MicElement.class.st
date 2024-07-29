Class {
	#name : 'MicElement',
	#superclass : 'Object',
	#instVars : [
		'parent',
		'properties'
	],
	#pools : [
		'MicMicrodownSharedPool'
	],
	#category : 'Microdown-Model',
	#package : 'Microdown',
	#tag : 'Model'
}

{ #category : 'documentation' }
MicElement class >> buildMicroDownUsing: aBuilder  withComment: aComment [
	 | visitSelector visitors |
	super buildMicroDownUsing: aBuilder  withComment: aComment.
	visitSelector := ('visit', 
		((self name withoutSuffix: 'Block') 
			copyWithoutFirst trimLeft: [ :char |  char isLowercase ] ), 
			':' ) asSymbol.
	visitors := MicrodownVisitor allSubclasses  
		select: [ :class |  class includesSelector: visitSelector ].
	aBuilder newLine.
	aBuilder header: [ aBuilder text:'Visitors using me:' ] withLevel: 2.
	visitors 
		ifEmpty: [ 
			aBuilder text: 'I found no one implementing a ', 
				visitSelector, 
				' - perhaps I am abstract or the visitor is unconventionally named' ] 
		ifNotEmpty: [ 
			aBuilder unorderedListDuring: [
				visitors  do:  [:class |  aBuilder  item:  [ aBuilder monospace: (class name, '>>#', visitSelector ) ]]]]
]

{ #category : 'utilities' }
MicElement class >> extensionClassFor: tag [
	"I am a utility method used in extension blocks to find the right subclass to instantiate"
	^ self allSubclasses detect: [ :each | each tag = tag ] ifNone: [ self ]
]

{ #category : 'private' }
MicElement >> basicParent: aMicBlock [

	parent := aMicBlock
]

{ #category : 'accessing' }
MicElement >> fromFile [
	"Let us bubble up to the root to get the file"
	^ self parent fromFile
]

{ #category : 'accessing' }
MicElement >> fromSource [
	"Let us bubble up to the root to get the file"
	^ self parent 
]

{ #category : 'properties' }
MicElement >> hasProperties [
	^ properties isNotNil
]

{ #category : 'properties' }
MicElement >> hasProperty: aKey [
	"Answer whether there is a property named aKey."
	
	properties ifNil: [ ^ false ].
	^ properties includesKey: aKey
]

{ #category : 'public' }
MicElement >> inlineParse: aString [

	| inlineParser inlinedChildren |	
	inlineParser := self newInlineParser.
	inlinedChildren := inlineParser parse: aString.
	inlinedChildren do: [ :each | each parent: self ].
	^ inlinedChildren

]

{ #category : 'private' }
MicElement >> inlineParserClass [

	^ MicInlineParser
]

{ #category : 'testing' }
MicElement >> isMetaData [
	^ false
]

{ #category : 'private' }
MicElement >> newInlineParser [

	^ self inlineParserClass new
]

{ #category : 'accessing' }
MicElement >> parent [
	^ parent
]

{ #category : 'accessing' }
MicElement >> parent: aBlockChild [
	"Add the receiver as child of aBlockChild. 
	Make sure that aBlockChild is the parent of the receiver."
	
	parent := aBlockChild.
	aBlockChild addChild: self
]

{ #category : 'properties' }
MicElement >> properties [
	^ properties ifNil: [ properties := Dictionary new ]
]

{ #category : 'properties' }
MicElement >> propertiesCopy [
	self properties ifNil: [ ^ nil ].
	^ self properties collect: [ :each | each copy ]
]

{ #category : 'properties' }
MicElement >> propertyAt: aKey [
	"Answer the property value associated with aKey."
	
	^ self propertyAt: aKey ifAbsent: [ MicPropertyError signal: 'Property not found' ]
]

{ #category : 'properties' }
MicElement >> propertyAt: aKey ifAbsent: aBlock [
	"Answer the property value associated with aKey or, if aKey isn't found, answer the result of evaluating aBlock."

	^ self properties
		  ifNil: [ aBlock value ]
		  ifNotNil: [ self properties at: aKey ifAbsent: aBlock ]
]

{ #category : 'properties' }
MicElement >> propertyAt: aKey ifAbsentPut: aBlock [
	"Answer the property associated with aKey or, if aKey isn't found store the result of evaluating aBlock as new value."
	
	^ self propertyAt: aKey ifAbsent: [ self propertyAt: aKey put: aBlock value ]
]

{ #category : 'properties' }
MicElement >> propertyAt: aKey put: anObject [
	"Set the property at aKey to be anObject. If aKey is not found, create a new entry for aKey and set is value to anObject. Answer anObject."

	^ self properties at: aKey put: anObject
]

{ #category : 'properties' }
MicElement >> removeProperty: aKey [
	"Remove the property with aKey. Answer the property or raise an error if aKey isn't found."
	
	^ self removeProperty: aKey ifAbsent: [ MicPropertyError signal: 'Property not found' ]
]

{ #category : 'properties' }
MicElement >> removeProperty: aKey ifAbsent: aBlock [
	"Remove the property with aKey. Answer the value or, if aKey isn't found, answer the result of evaluating aBlock."
	
	| answer |
	self properties ifNil: [ ^ aBlock value ].
	answer := self properties removeKey: aKey ifAbsent: aBlock.
	self properties isEmpty ifTrue: [ properties := nil ].
	^ answer
]

{ #category : 'replacement' }
MicElement >> replaceBy: aMicElement [
	"Replace the receiver by the argument. 
	Make sure that the new element parent is the parent of the receiver."
	
	parent replace: self by: aMicElement.
	
]

{ #category : 'public' }
MicElement >> resolveFrom: aBase [
	Microdown resolveDocument: self withBase: aBase
]
