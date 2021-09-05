"
`MicPathResolver` uses the originPath of the figure to create an absolutePath for the figure.
The originPath is defined when we use the `MicroDownParser>>#parseFile:` else originPath takes per default the FileSystem workingDirectory.
The `MicPathResolver` replaces the  url by an url which contains an absolute file path and it keeps the original url in originUrl in the properties of figure
"
Class {
	#name : #MicPathResolver,
	#superclass : #MicrodownVisitor,
	#instVars : [
		'root'
	],
	#category : #'Microdown-Core'
}

{ #category : #initialization }
MicPathResolver >> initialize [ 
	
	super initialize. 
	root := FileSystem workingDirectory
]

{ #category : #visiting }
MicPathResolver >> root [
	"Return an URL or a file reference. May be in the future we should have a URL resolver and a file resolver."
	^ root 
]

{ #category : #visiting }
MicPathResolver >> root: aRoot [
	"To set as root for resolution, an absolute URL or file reference."
	
	root := aRoot 
]

{ #category : #visiting }
MicPathResolver >> visitFigure: aFigure [
	
	self halt.
	"if this http:/ or https:// then this an absolute so no need to resolve it. Tell me otherwise"
	(aFigure resources isHttp | aFigure resources isHttps)
		ifTrue: [ ^ aFigure ].

	aFigure resources isFile
			ifTrue: [ 
				aFigure resources: (aFigure resources resolvedBy: self root).
				^ aFigure ].
	^ aFigure
]

{ #category : #visiting }
MicPathResolver >> visitInputfile: anInputFile [
	self halt.
	 anInputFile isRelativeFilePath
			ifTrue: [ anInputFile path: (anInputFile originPath asResolvedBy: self root) pathString ].
	^ anInputFile
]
