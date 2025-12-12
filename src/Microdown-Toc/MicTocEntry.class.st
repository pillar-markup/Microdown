Class {
	#name : 'MicTocEntry',
	#superclass : 'Object',
	#instVars : [
		'children',
		'header'
	],
	#category : 'Microdown-Toc',
	#package : 'Microdown-Toc'
}

{ #category : 'instance creation' }
MicTocEntry >> for: aMicHeaderBlock [ 
	
	header := aMicHeaderBlock 
]
