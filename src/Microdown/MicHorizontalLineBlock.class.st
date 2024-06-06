"
I am a horizontal line. I'm expressed by starting a new line with `***`

*** the rest of the line is ignored.
"
Class {
	#name : 'MicHorizontalLineBlock',
	#superclass : 'MicSingleLineBlock',
	#category : 'Microdown-Model',
	#package : 'Microdown',
	#tag : 'Model'
}

{ #category : 'visiting' }
MicHorizontalLineBlock >> accept: aVisitor [ 
 	^ aVisitor visitHorizontalLine: self
]
