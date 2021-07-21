Class {
	#name : #MicResolvePath,
	#superclass : #MicrodownVisitor,
	#category : #'Microdown-ResolvePath'
}

{ #category : #visiting }
MicResolvePath >> visitFigure: aFigure [
	aFigure scheme = 'file' 
		ifTrue: [ 
			aFigure isRelativeFilePath 
				ifTrue: [ aFigure propertyAt: #originPath put: aFigure originPath / ( aFigure url host ,'/', aFigure url path) ] 
				ifFalse: [ aFigure propertyAt: #originPath put: FileSystem workingDirectory / ( aFigure url host ,'/', aFigure url path) ]
			].
	^ aFigure
]
