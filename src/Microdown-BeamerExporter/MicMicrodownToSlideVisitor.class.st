Class {
	#name : 'MicMicrodownToSlideVisitor',
	#superclass : 'MicrodownVisitor',
	#instVars : [
		'newDoc'
	],
	#category : 'Microdown-BeamerExporter-Slide as header',
	#package : 'Microdown-BeamerExporter',
	#tag : 'Slide as header'
}

{ #category : 'instance-creation' }
MicMicrodownToSlideVisitor class >> withContext: aPR [

	"does nothing with context"
	^ self new 
]

{ #category : 'building' }
MicMicrodownToSlideVisitor >> contributeToPipelineBuilding: aPRPipelineBuilder [ 
	
	aPRPipelineBuilder addPillarDocumentTransformation: self
]

{ #category : 'preparation' }
MicMicrodownToSlideVisitor >> prepareForExecutionOn: aPRProject [ 
	"emtpy"
]

{ #category : 'accessing' }
MicMicrodownToSlideVisitor >> start: aMicRootBlock [ 
	
	newDoc := MicRootBlock new.
	newDoc properties: aMicRootBlock properties. 
	aMicRootBlock accept: self.
	"headers 1 are now slideblock"
	
	^ newDoc
]

{ #category : 'visiting' }
MicMicrodownToSlideVisitor >> visitHeader: aHeader [
	
	aHeader level = 1 
		ifTrue: [ 
			aHeader parent replace: aHeader by: (MicSlideBlock new title: aHeader header) ]
]
