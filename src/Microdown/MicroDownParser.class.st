"
I'm a temporary class that should be merged in the superclass.
"
Class {
	#name : #MicroDownParser,
	#superclass : #MicAbstractParser,
	#category : #'Microdown-Parser'
}

{ #category : #'node creation' }
MicroDownParser >> blockExtensionStarterClassFrom: line [
	"return the class of a block which can start with line, or nil if none"
	(line beginsWith: self metaDataOpeningBlockMarkup)
		ifTrue: [ ^ MicMetaDataBlock ].
	(line beginsWith: self annotatedParagraphMarkup)
		ifTrue: [ ^ MicAnnotatedBlock ].
	(line beginsWith: self anchorMarkup )
		ifTrue: [ ^ MicAnchorBlock ].
	(line beginsWith: self commentedLineMarkup )
		ifTrue: [ ^ MicCommentBlock ].
	(line beginsWith: self mathOpeningBlockMarkup)
		ifTrue: [ ^ MicMathBlock ].
	(line beginsWith: self environmentOpeningBlockMarkup)
		ifTrue: [ ^ MicEnvironmentBlock ].	
	(line beginsWith: self horizontalLineMarkup)
		ifTrue: [ ^ MicHorizontalLineBlock ].
	^ nil
]

{ #category : #accessing }
MicroDownParser >> builder [
	"return a little helper to build microdown correct expression"
	
	^ self class builder
]
