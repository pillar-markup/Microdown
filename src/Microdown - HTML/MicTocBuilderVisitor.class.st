Class {
	#name : #MicTocBuilderVisitor,
	#superclass : #MicrodownVisitor,
	#instVars : [
		'toc',
		'tocsStack',
		'documentSource',
		'currentFile',
		'inProcessFiles'
	],
	#category : #'Microdown - HTML'
}

{ #category : #testing }
MicTocBuilderVisitor class >> isAbstract [

	^ false
]

{ #category : #visiting }
MicTocBuilderVisitor >> addToToc: aTocTitle [
	self top level < aTocTitle level
		ifTrue: [ self top addChildren: aTocTitle.
			self push: aTocTitle ]
		ifFalse: [ self pop.
			self addToToc: aTocTitle ]
]

{ #category : #accessing }
MicTocBuilderVisitor >> currentFile [
	^ currentFile
]

{ #category : #accessing }
MicTocBuilderVisitor >> currentFile: anObject [
	currentFile := anObject
]

{ #category : #accessing }
MicTocBuilderVisitor >> documentSource [
	^ documentSource
]

{ #category : #accessing }
MicTocBuilderVisitor >> documentSource: anObject [
	documentSource := anObject
]

{ #category : #accessing }
MicTocBuilderVisitor >> inProcessFiles: anObject [
	inProcessFiles := anObject
]

{ #category : #initialization }
MicTocBuilderVisitor >> initialize [
	super initialize.
	toc := MicToc new level: 0.
	tocsStack := Stack new.
	tocsStack push: toc.
	inProcessFiles := #()
]

{ #category : #accessing }
MicTocBuilderVisitor >> pop [
	^ tocsStack pop
]

{ #category : #accessing }
MicTocBuilderVisitor >> push: aToc [
	^ tocsStack push: aToc
]

{ #category : #accessing }
MicTocBuilderVisitor >> tableOfContents [
	^ toc
]

{ #category : #accessing }
MicTocBuilderVisitor >> top [
	^ tocsStack top
]

{ #category : #initialization }
MicTocBuilderVisitor >> validateInclusionOfFile: aSource [
	
	self documentSource = aSource ifTrue: [ 
		MicCyclicFileInclusionError new
			files: { aSource };
			signal
	].

	(inProcessFiles includes: aSource)
		ifTrue: [ MicCyclicFileInclusionError new
			files: (inProcessFiles copyWith: aSource);
			signal 
	]
]

{ #category : #visiting }
MicTocBuilderVisitor >> visit: aDocument [
	super visit: aDocument.
	^ toc
]

{ #category : #visiting }
MicTocBuilderVisitor >> visitHeader: aHeader [
	| titleToc|
	titleToc := MicToc new name: aHeader text; level: aHeader level; fileReference: currentFile.
	self addToToc: titleToc
	
]

{ #category : #initialization }
MicTocBuilderVisitor >> visitInputfile: anAnnotation [
	| document sourceSave currentSave newSource |
	"Resolve and parse the new file"
	sourceSave := self documentSource.
	currentSave := self currentFile.
	newSource := self documentSource parent resolve: anAnnotation path.
	self validateInclusionOfFile: newSource.
	document := MicroDownParser new parse: newSource contents.
	self documentSource: newSource.
	self currentFile: anAnnotation path.

	"Update inProcessFiles with the actual document"
	self
		inProcessFiles: (inProcessFiles copyWith: self documentSource);
		visit: document.

	"Get the original values"
	self currentFile: currentSave.
	self documentSource: sourceSave
]
