Class {
	#name : 'MicSingleSummarizer',
	#superclass : 'Object',
	#instVars : [
		'maximumWords'
	],
	#category : 'Microdown-Blog',
	#package : 'Microdown-Blog'
}

{ #category : 'accessing' }
MicSingleSummarizer >> firstHeaderBlockOf: aMicRootBlock [


	| header newHeader |
	header := aMicRootBlock children 
		detect: [ :each | each isKindOf: MicHeaderBlock ]
		ifNone: [
				| h t |
				 h := MicHeaderBlock new.
				t := MicTextBlock new bodyString: 'Please define a header'.
				h headerElements: { t }. 
				t parent: h.
				^ h ].
	newHeader := MicHeaderBlock new.
	header headerElements do: [ :t | t copy  parent: newHeader ].
	^ newHeader
]

{ #category : 'accessing' }
MicSingleSummarizer >> firstParagraphBlockOf: aMicRootBlock [
	
	| p textElements newParagraph selectionSize t |
	p := aMicRootBlock children 
		detect: [ :each | each isKindOf: MicParagraphBlock ]
		ifNone: [ 
			p := MicParagraphBlock new.
			t := MicTextBlock new bodyString: 'Please add a paragraph'.
			p textElements: { t }.
			t parent: p.
			^ p ].
	selectionSize := maximumWords min: p textElements size.
	textElements := (p textElements first: selectionSize).
	newParagraph := MicParagraphBlock new.
	textElements do: [ :t | 
		newParagraph addChild: t copy ].
	^ newParagraph
]

{ #category : 'initialization' }
MicSingleSummarizer >> initialize [

	super initialize.
	maximumWords := 15
]

{ #category : 'accessing' }
MicSingleSummarizer >> maximumWords: anInteger [ 
	maximumWords := anInteger
]

{ #category : 'parsing' }
MicSingleSummarizer >> summarize: aMicRootBlock [

	
	| element |
	element := MicRootBlock new.
	element 
		addChild: (self firstHeaderBlockOf: aMicRootBlock);
		addChild: (self firstParagraphBlockOf: aMicRootBlock).
	
	^ element.
]

{ #category : 'parsing' }
MicSingleSummarizer >> summarizeFile: aFileReference [

	| p |
	p := Microdown parse: aFileReference asFileReference contents.
	^ self summarize: p
]
