"
I am a pillar visitor that updates all references to be latex compatible. I am particularly useful in windows platforms that use the \ delimiter, which is not correctly parsed by the latex compiler.

Latex Paths have to use the / delimiter, even in windows. The following are examples of correct paths:

/usr/lib/bla

C:/Program Files/Something

For now I'm a copy and paste from Pillar (to avoid to have to patch all the visit API).
"
Class {
	#name : 'MicLatexPathUpdateVisitor',
	#superclass : 'MicrodownVisitor',
	#category : 'Microdown-LaTeXExporter',
	#package : 'Microdown-LaTeXExporter'
}

{ #category : 'visiting' }
MicLatexPathUpdateVisitor class >> key [

	^ #latexPathUpdate
]

{ #category : 'visiting' }
MicLatexPathUpdateVisitor class >> start: aDocument [
	^ self new start: aDocument
]

{ #category : 'instance creation' }
MicLatexPathUpdateVisitor >> newReferenceFor: aReference [
	
	^ aReference reference copyReplaceAll: '\' with: '/'
]

{ #category : 'visiting' }
MicLatexPathUpdateVisitor >> visitFigure: aFigure [
	aFigure reference: (self newReferenceFor: aFigure).
	super visitFigure: aFigure
]

{ #category : 'unused' }
MicLatexPathUpdateVisitor >> visitInternalLink: anInternalLink [
	anInternalLink hasReference  
		ifTrue: [ anInternalLink reference: (self newReferenceFor: anInternalLink) ].
	super visitInternalLink: anInternalLink
]
