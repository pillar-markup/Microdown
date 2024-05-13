Class {
	#name : 'MicMicrodownToSlideVisitor',
	#superclass : 'MicrodownVisitor',
	#category : 'Microdown-BeamerExporter',
	#package : 'Microdown-BeamerExporter'
}

{ #category : 'visiting' }
MicMicrodownToSlideVisitor >> visitHeader: aHeader [

	aHeader parent replace: aHeader by: (MicSlideBlock new title: aHeader header)
	
]
