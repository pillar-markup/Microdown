"
`MicPathResolver` uses the originPath of the figure to create an absolutePath for the figure.
The originPath is defined when we use the `MicroDownParser>>#parseFile:` else originPath takes per default the FileSystem workingDirectory.
The `MicPathResolver` replace the  url by an absolute file path and it keep the original url in originUrl in the properties of figure
"
Class {
	#name : #MicPathResolver,
	#superclass : #MicrodownVisitor,
	#category : #'Microdown-ResolvePath'
}

{ #category : #visiting }
MicPathResolver >> visitFigure: aFigure [
	| originUrl |
	originUrl := aFigure url.
	(aFigure url scheme = 'file' and: [ aFigure isRelativeFilePath  ])
			ifTrue: [ aFigure url:(aFigure originPath / ( aFigure url host ,'/', aFigure url path)) asUrl ].
	aFigure propertyAt: #originUrl put: originUrl.
	^ aFigure
]
