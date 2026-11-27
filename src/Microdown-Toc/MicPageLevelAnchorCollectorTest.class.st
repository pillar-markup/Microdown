"
I check that `MicPageLevelAnchorCollector` collects the labels of anchors and of anchored figures, code and math blocks, ignores the ones without anchor, and starts afresh for each document.
"
Class {
	#name : 'MicPageLevelAnchorCollectorTest',
	#superclass : 'TestCase',
	#category : 'Microdown-Toc',
	#package : 'Microdown-Toc'
}

{ #category : 'helpers' }
MicPageLevelAnchorCollectorTest >> numbersOfLabelsIn: aString [
	"Number the document of aString (chapters at ##), collect its labels and answer the number each label stands for."

	| document collector |
	document := Microdown parse: aString.
	MicNumberer new number: document.
	collector := MicPageLevelAnchorCollector new.
	collector labelsOf: document.
	^ collector labelNumbers
]

{ #category : 'tests - numbers' }
MicPageLevelAnchorCollectorTest >> testAnchorBelowAHeaderStandsForTheHeaderNumber [

	self
		assert: ((self numbersOfLabelsIn: '## A

### B
@b') at: 'b')
		equals: #( 1 1 )
]

{ #category : 'tests - numbers' }
MicPageLevelAnchorCollectorTest >> testAnchorInsideASectionStandsForTheSectionNumber [

	self
		assert: ((self numbersOfLabelsIn: '## A

### B

Some text.

@here

More text.') at: 'here')
		equals: #( 1 1 )
]

{ #category : 'tests - numbers' }
MicPageLevelAnchorCollectorTest >> testAnchorOfAnUnnumberedElementStandsForNoNumber [

	| numbers |
	numbers := self numbersOfLabelsIn: '@intro

## A'.

	self assert: (numbers includesKey: 'intro').
	self assert: (numbers at: 'intro') isNil
]

{ #category : 'tests - example' }
MicPageLevelAnchorCollectorTest >> testExampleOfAChapter [

	self
		assert: MicPageLevelAnchorCollector exampleOfAChapter anchorLabels
		equals: #( 'toto' 'fig1' 'code1' ) asSet
]

{ #category : 'tests - numbers' }
MicPageLevelAnchorCollectorTest >> testFigureAnchorStandsForTheFigureNumber [

	self
		assert: ((self numbersOfLabelsIn: '## A

![A caption.](a.png anchor=fa)') at: 'fa')
		equals: #( 1 1 )
]

{ #category : 'tests - labels' }
MicPageLevelAnchorCollectorTest >> testLabelsIgnoreFiguresAndCodesWithoutAnchor [

	self
		assert: (MicPageLevelAnchorCollector new labelsOf:
				 (Microdown parse: '![A caption.](figures/x.png)

```
foo
```'))
		equals: Set new
]

{ #category : 'tests - labels' }
MicPageLevelAnchorCollectorTest >> testLabelsOfAnchors [

	self
		assert:
			(MicPageLevelAnchorCollector new labelsOf: (Microdown parse: '## Toto
@toto

Some text.

@other'))
		equals: #( 'toto' 'other' ) asSet
]

{ #category : 'tests - labels' }
MicPageLevelAnchorCollectorTest >> testLabelsOfFiguresCodesAndMaths [

	self
		assert: (MicPageLevelAnchorCollector new labelsOf:
				 (Microdown parse: '![A caption.%anchor=fig1](figures/x.png)

```anchor=code1
foo
```

$$ %anchor=eq1
x
$$'))
		equals: #( 'fig1' 'code1' 'eq1' ) asSet
]

{ #category : 'tests - labels' }
MicPageLevelAnchorCollectorTest >> testLabelsOfTwoDocumentsAreSeparate [

	| collector |
	collector := MicPageLevelAnchorCollector new.
	collector labelsOf: (Microdown parse: '@one').

	self
		assert: (collector labelsOf: (Microdown parse: '@two'))
		equals: #( 'two' ) asSet
]
