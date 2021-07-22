"
MicPathResolver use the originPath of the figure to create an absolutePath for the figure.
The originPath is define during when we use parseFile: else originPath take per default the FileSystem workingDirectory
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
