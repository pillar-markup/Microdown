Class {
	#name : 'MicMicrodownToSlideVisitor',
	#superclass : 'MicrodownVisitor',
	#category : 'Microdown-BeamerExporter',
	#package : 'Microdown-BeamerExporter'
}

{ #category : 'visiting' }
MicMicrodownToSlideVisitor >> visitHeader: aHeader [

	aHeader level = 1 
		ifTrue: [ aHeader parent  ]
]
