Class {
	#name : #MicResolvePath,
	#superclass : #MicrodownVisitor,
	#category : #'Microdown-ResolvePath'
}

{ #category : #visiting }
MicResolvePath >> visitFigure: aFigure [
	(aFigure url scheme = 'file' and: [ aFigure isRelativeFilePath  ])
			ifTrue: [ aFigure url: (aFigure originPath / ( aFigure url host ,'/', aFigure url path)) asUrl ].
	^ aFigure
]
