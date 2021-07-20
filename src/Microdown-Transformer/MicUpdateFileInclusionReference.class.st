Class {
	#name : #MicUpdateFileInclusionReference,
	#superclass : #MicrodownVisitor,
	#instVars : [
		'path'
	],
	#category : #'Microdown-Transformer'
}

{ #category : #visiting }
MicUpdateFileInclusionReference class >> isAbstract [
	^ false
]

{ #category : #visiting }
MicUpdateFileInclusionReference class >> start: aDocument with: aPath [
	^ self new
		path: aPath;
		start: aDocument
]

{ #category : #'instance creation' }
MicUpdateFileInclusionReference >> newReferenceFor: aReference [
	(aReference url includesSubstring: 'file://')
		ifTrue: [ ^ aReference url copyReplaceAll: 'file://' with: 'file://', self path , '/' ].

	^ self path
		ifEmpty: [ aReference label ]	
		ifNotEmpty: [ self path , '/' , aReference label]
]

{ #category : #accessing }
MicUpdateFileInclusionReference >> path [
	^ path
]

{ #category : #accessing }
MicUpdateFileInclusionReference >> path: aPath [
	path := aPath
]

{ #category : #visiting }
MicUpdateFileInclusionReference >> start: anObject [
	super visit: anObject.
	^ anObject
]

{ #category : #visiting }
MicUpdateFileInclusionReference >> visitAnchor: anAnchor [
	anAnchor hasLabel  
		ifTrue: [ anAnchor label: (self newReferenceFor: anAnchor) ].
	super visitAnchor: anAnchor
]

{ #category : #visiting }
MicUpdateFileInclusionReference >> visitFigure: aFigure [
	aFigure url: (self newReferenceFor: aFigure).
	super visitFigure: aFigure
]

{ #category : #visiting }
MicUpdateFileInclusionReference >> visitInternalLink: anInternalLink [
	anInternalLink hasReference  
		ifTrue: [ anInternalLink reference: (self newReferenceFor: anInternalLink) ].
	super visitInternalLink: anInternalLink
]

{ #category : #visiting }
MicUpdateFileInclusionReference >> visitText: aText [
]
