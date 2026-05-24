Class {
	#name : 'MicFileNameWithSpaceChecker',
	#superclass : 'MicChecker',
	#instVars : [
		'errors'
	],
	#category : 'Microdown-BookTester-FilesWithSpace',
	#package : 'Microdown-BookTester',
	#tag : 'FilesWithSpace'
}

{ #category : 'public - name' }
MicFileNameWithSpaceChecker class >> checkerName [ 

	^ 'NoSpaceInFilename'
]

{ #category : 'accessing' }
MicFileNameWithSpaceChecker >> errors [
	^ errors ifNil: [ errors := OrderedCollection new ]
]

{ #category : 'accessing' }
MicFileNameWithSpaceChecker >> proposedNameFor: aFigure [
	^ aFigure url copyReplaceAll: ' ' with: '-'
]

{ #category : 'accessing' }
MicFileNameWithSpaceChecker >> renameFileOnDiskFor: aFigure [
	| oldFile newName |
	oldFile := aFigure url asFileReference.
	newName := self proposedNameFor: aFigure.
	oldFile exists ifTrue: [ oldFile renameTo: newName ]
]

{ #category : 'accessing' }
MicFileNameWithSpaceChecker >> visitFigure: aFigure [
	(aFigure url includes: $ ) ifTrue: [ 
		self errors add: aFigure ].
	super visitFigure: aFigure
]
