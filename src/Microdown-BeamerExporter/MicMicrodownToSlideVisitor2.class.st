Class {
	#name : 'MicMicrodownToSlideVisitor2',
	#superclass : 'MicrodownVisitor',
	#category : 'Microdown-BeamerExporter-Slide as header',
	#package : 'Microdown-BeamerExporter',
	#tag : 'Slide as header'
}

{ #category : 'instance-creation' }
MicMicrodownToSlideVisitor2 class >> withContext: aPR [

	"does nothing with context"
	^ self new 
]

{ #category : 'building' }
MicMicrodownToSlideVisitor2 >> contributeToPipelineBuilding: aPRPipelineBuilder [ 
	
	aPRPipelineBuilder addPillarDocumentTransformation: self
]

{ #category : 'preparation' }
MicMicrodownToSlideVisitor2 >> prepareForExecutionOn: aPRProject [ 
	"emtpy"
]

{ #category : 'accessing' }
MicMicrodownToSlideVisitor2 >> start: aMicRootBlock [ 
	| slideDoc |
	slideDoc := MicRootBlock new. 
	slideDoc properties: aMicRootBlock properties.
	aMicRootBlock accept: self.
	^ slideDoc
]

{ #category : 'visiting' }
MicMicrodownToSlideVisitor2 >> visitHeader: aHeader [
	
	aHeader parent replace: aHeader by: (MicSlideBlock new title: aHeader header)
	"now this is wrong because I would get all the following until the next header as children."
	
]
