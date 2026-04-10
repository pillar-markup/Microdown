"
I convert a document with top level header (i.e. # or H1) into a slideBlock in which all the followers of the original top level header are children of the header.


"
Class {
	#name : 'MicMicrodownTopLevelHeaderToSlide',
	#superclass : 'MicrodownVisitor',
	#category : 'Microdown-BeamerExporter-Slide as header',
	#package : 'Microdown-BeamerExporter',
	#tag : 'Slide as header'
}

{ #category : 'instance-creation' }
MicMicrodownTopLevelHeaderToSlide class >> withContext: aPR [

	"does nothing with context"
	^ self new 
]

{ #category : 'building' }
MicMicrodownTopLevelHeaderToSlide >> contributeToPipelineBuilding: aPRPipelineBuilder [ 
	
	aPRPipelineBuilder addPillarDocumentTransformation: self
]

{ #category : 'preparation' }
MicMicrodownTopLevelHeaderToSlide >> prepareForExecutionOn: aPRProject [ 
	"emtpy"
]

{ #category : 'accessing' }
MicMicrodownTopLevelHeaderToSlide >> start: aMicRootBlock [ 
	| slideDoc |
	slideDoc := MicRootBlock new. 
	slideDoc properties: aMicRootBlock properties.
	aMicRootBlock accept: self.
	MicSlideFollowerNester new treatElements: aMicRootBlock children.
	^ aMicRootBlock
]

{ #category : 'visiting' }
MicMicrodownTopLevelHeaderToSlide >> visitHeader: aHeader [
	
	aHeader level = 1
		ifTrue: [ 
		aHeader parent replace: aHeader by: (MicSlideBlock new title: aHeader header)
		"now this is just part of the story because all the following element until the next header should
		be moved as children."
		]
]
