"
I check that `MicPageLevelAnchorCollector` collects the labels of anchors and of anchored figures, code and math blocks, ignores the ones without anchor, and starts afresh for each document.
"
Class {
	#name : 'MicPageLevelAnchorCollectorTest',
	#superclass : 'TestCase',
	#category : 'Microdown-Toc',
	#package : 'Microdown-Toc'
}

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
