Class {
	#name : 'MicFilenameWithSpaceChecker',
	#superclass : 'MicChecker',
	#instVars : [
		'errors'
	],
	#category : 'Microdown-BookTester-Checker-FilesWithSpace',
	#package : 'Microdown-BookTester',
	#tag : 'Checker-FilesWithSpace'
}

{ #category : 'public - name' }
MicFilenameWithSpaceChecker class >> checkerName [ 

	^ 'NoSpaceInFilename'
]

{ #category : 'accessing' }
MicFilenameWithSpaceChecker >> errors [
	^ errors ifNil: [ errors := OrderedCollection new ]
]

{ #category : 'accessing' }
MicFilenameWithSpaceChecker >> proposedNameFor: aFigure [
	^ aFigure url copyReplaceAll: ' ' with: '-'
]

{ #category : 'accessing' }
MicFilenameWithSpaceChecker >> renameFileOnDiskFor: aFigure [
	| oldFile newName |
	oldFile := aFigure url asFileReference.
	newName := self proposedNameFor: aFigure.
	oldFile exists ifTrue: [ oldFile renameTo: newName ]
]

{ #category : 'accessing' }
MicFilenameWithSpaceChecker >> visitFigure: aFigure [
	(aFigure url includes: $ ) ifTrue: [ 
		self errors add: aFigure ].
	super visitFigure: aFigure
]
