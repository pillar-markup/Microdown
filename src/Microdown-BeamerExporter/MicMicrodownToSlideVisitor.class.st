Class {
	#name : 'MicMicrodownToSlideVisitor',
	#superclass : 'MicrodownVisitor',
	#category : 'Microdown-BeamerExporter',
	#package : 'Microdown-BeamerExporter'
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
	aMicRootBlock accept: self.
	^ aMicRootBlock
]

{ #category : 'visiting' }
MicMicrodownToSlideVisitor >> visitHeader: aHeader [
	
	aHeader parent replace: aHeader by: (MicSlideBlock new title: aHeader header)
	"now this is wrong because I would get all the following until the next header as children."
	
]
