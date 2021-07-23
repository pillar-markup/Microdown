"
I'm a visitor handling references to file. In particular
"
Class {
	#name : #MicPathResolver,
	#superclass : #MicrodownVisitor,
	#category : #'Microdown-ResolvePath'
}

{ #category : #visiting }
MicPathResolver >> visitFigure: aFigure [
	(aFigure url scheme = 'file' and: [ aFigure isRelativeFilePath  ])
			ifTrue: [ aFigure url: (aFigure originPath / ( aFigure url host ,'/', aFigure url path)) asUrl ].
	^ aFigure
]
