Class {
	#name : 'MicNoteBlock',
	#superclass : 'MicAnnotationBlock',
	#category : 'Microdown-Extensions',
	#package : 'Microdown',
	#tag : 'Extensions'
}

{ #category : 'accessing' }
MicNoteBlock class >> tag [
	^ #note
]

{ #category : 'visiting' }
MicNoteBlock >> accept: aVisitor [
	aVisitor visitNote: self
]

{ #category : 'accessing' }
MicNoteBlock >> contents [
	^ arguments at: 'contents' ifAbsent: [ '' ]
]
