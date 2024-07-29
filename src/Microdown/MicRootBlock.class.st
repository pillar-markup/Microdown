"
I am the root of the markup tree.
"
Class {
	#name : 'MicRootBlock',
	#superclass : 'MicAbstractBlock',
	#category : 'Microdown-Model',
	#package : 'Microdown',
	#tag : 'Model'
}

{ #category : 'visiting' }
MicRootBlock >> accept: aVisitor [
 	^ aVisitor visitRoot: self
]

{ #category : 'testing' }
MicRootBlock >> addLineAndReturnNextNode: line [
	"add line to this node. 
	Notice, the action is allowed to create new nodes in the block tree.
	Returns the node to handle next line - typically self."

	| newBlock |
	newBlock := self newBlockFor: line parent: self.
	^ newBlock 
]

{ #category : 'testing' }
MicRootBlock >> canConsumeLine: line [
	"The root block can always consume everything no matter what it is."

	^ true
]

{ #category : 'accessing' }
MicRootBlock >> fromFile [
	^ self propertyAt: #file ifAbsent: [ 'fakedFile' ]
]

{ #category : 'accessing' }
MicRootBlock >> fromFile: aFile [ 
	"Store the file from which the document was built"
	
	self propertyAt: #file put: aFile
]

{ #category : 'accessing' }
MicRootBlock >> fromSource [
	^ self   
]

{ #category : 'testing' }
MicRootBlock >> hasFile [
	^ self hasProperty: #file
]

{ #category : 'testing' }
MicRootBlock >> hasMetaDataElement [
	
	^ children 
		ifEmpty: [false]
		ifNotEmpty: [ children first isMetaData ]
]

{ #category : 'accessing' }
MicRootBlock >> indent [
	^0
]

{ #category : 'testing' }
MicRootBlock >> metaDataElement [
	"if self hasMetaDataElement then metaDataElement returns it.
	else it returns the first element."
	^ children first
]

{ #category : 'accessing' }
MicRootBlock >> properties: aConfigurationForPillar [
	"Pay attention the strong hypothesis here is that keys of microdown properties and pillar configuration should not overlap. A possible solution would be to have clever at: and at:put: that check for example for a prefix for microdown properties.
	
	This way the user would write
		aMicElement at: #prop
		aMicElement at: #prop put: 123
				
		the system would store: #mic_prop
	
	"

	"to avoid trashing the potential existing properties of a mic element, 
	we copied them into the configuration which is a special kind of dictionary and 
	store the dictionary values in it.
	"
	
	self properties keysAndValuesDo: [ :k :v | aConfigurationForPillar at: k put: v ].
	properties := aConfigurationForPillar
]

{ #category : 'accessing' }
MicRootBlock >> resolveYourself [

	MicZincPathResolver
			resolve: self
			withBase: self fromFile.
]
