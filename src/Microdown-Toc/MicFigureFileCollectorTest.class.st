"
I test `MicFigureFileCollector`, the pass that answers the local files shown by the figures of a document, so that a site copies only them.
"
Class {
	#name : 'MicFigureFileCollectorTest',
	#superclass : 'TestCase',
	#category : 'Microdown-Toc',
	#package : 'Microdown-Toc'
}

{ #category : 'helpers' }
MicFigureFileCollectorTest >> pathsOf: aString [

	^ MicFigureFileCollector new collect: (Microdown parse: aString)
]

{ #category : 'tests' }
MicFigureFileCollectorTest >> testExampleOfADocument [

	self
		assert: MicFigureFileCollector exampleOfADocument paths asArray
		equals: #( 'figures/x.png' )
]

{ #category : 'tests' }
MicFigureFileCollectorTest >> testFigureOutsideTheBookIsNotCollected [

	| document |
	document := Microdown parse: '![A caption.](figures/x.png)'.
	document children first children first reference:
		(FileSystem memory / 'elsewhere' / 'x.png') asMicResourceReference.

	self assertEmpty: (MicFigureFileCollector new collect: document)
]

{ #category : 'tests' }
MicFigureFileCollectorTest >> testFigureShownTwiceIsCollectedOnce [

	self
		assert: (self pathsOf: '![One.](figures/x.png)

![Two.](figures/x.png)') asArray
		equals: #( 'figures/x.png' )
]

{ #category : 'tests' }
MicFigureFileCollectorTest >> testFiguresAreCollectedInTheOrderOfTheDocument [

	self
		assert: (self pathsOf: '![One.](figures/b.png)

![Two.](figures/a.png)') asArray
		equals: #( 'figures/b.png' 'figures/a.png' )
]

{ #category : 'tests' }
MicFigureFileCollectorTest >> testLocalFigureIsCollected [

	self
		assert:
		(self pathsOf: '![A caption.](Chapters/figures/x.png)') asArray
		equals: #( 'Chapters/figures/x.png' )
]

{ #category : 'tests' }
MicFigureFileCollectorTest >> testWebFigureIsNotCollected [

	self assertEmpty:
		(self pathsOf: '![A caption.](https://pharo.org/x.png)')
]
