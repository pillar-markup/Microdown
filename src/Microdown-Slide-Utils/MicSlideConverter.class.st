Class {
	#name : 'MicSlideConverter',
	#superclass : 'PRVisitor',
	#instVars : [
		'mic'
	],
	#category : 'Microdown-Slide-Utils',
	#package : 'Microdown-Slide-Utils'
}

{ #category : 'visiting' }
MicSlideConverter >> start: aPRDocument [
	mic := MicRootBlock new.
	super start: aPRDocument.
	^ mic

	
]

{ #category : 'visiting' }
MicSlideConverter >> visitSlide: aSlide [

	
]
