"
`MicPathResolver` uses the originPath of the figure to create an absolutePath for the figure.
The originPath is defined when we use the `MicroDownParser>>#parseFile:` else originPath takes per default the FileSystem workingDirectory.
The `MicPathResolver` replaces the  url by an url which contains an absolute file path and it keeps the original url in originUrl in the properties of figure
"
Class {
	#name : #MicPathResolver,
	#superclass : #MicrodownVisitor,
	#category : #'Microdown-ResolvePath'
}

{ #category : #visiting }
MicPathResolver >> visitFigure: aFigure [
	| originUrl |
	originUrl := aFigure originUrl.
	aFigure url: originUrl.
	(aFigure url scheme = 'file' and: [ aFigure isRelativeFilePath  ])
			ifTrue: [ aFigure url:(aFigure originPath / ( aFigure url host ,'/', aFigure url path)) asUrl ].
	aFigure propertyAt: #originUrl put: originUrl.
	^ aFigure
]

{ #category : #visiting }
MicPathResolver >> visitInputfile: anInputFile [
	anInputFile path: (anInputFile propertyAt: #originalPath  ifAbsent: [ 
		anInputFile propertyAt: #originalPath put: anInputFile path ]).
	 anInputFile isRelativeFilePath
			ifTrue: [ anInputFile path: (anInputFile originPath / anInputFile originalPath ) pathString ].
	^ anInputFile
]
