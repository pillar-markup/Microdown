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
			          t := MicTextBlock new bodyString:
				               'Please define a header'.
			          t parent: h.
			          ^ h ].
	newHeader := MicHeaderBlock new.
	header headerElements do: [ :t | t copy parent: newHeader ].
	newHeader level: header level.
	^ newHeader
]

{ #category : 'accessing' }
MicSingleSummarizer >> firstParagraphBlockOf: aMicRootBlock [

	| p textElements newParagraph selectionSize t sub |
	p := aMicRootBlock children
		     detect: [ :each | each isKindOf: MicParagraphBlock ]
		     ifNone: [
			     p := MicParagraphBlock new.
			     t := MicTextBlock new bodyString: 'Please add a paragraph'.
			     t parent: p.
			     ^ p ].
		
	sub := p text substrings: ' '.
	selectionSize := maximumWords min: sub size.
	sub := sub first: selectionSize.

	textElements := '' writeStream.
	sub do: [ :each |
		textElements
			nextPutAll: each;
			nextPut: Character space ].

	newParagraph := MicParagraphBlock new.
	t := MicTextBlock new bodyString: textElements ensureNoSpace contents.
	t parent: newParagraph.
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

	| element headerLink header |
	element := MicRootBlock new.
	header := self firstHeaderBlockOf: aMicRootBlock.
	headerLink := MicHeaderBlock new.
	headerLink addChild: ((MicInlineParser parse: '[',header text,'](''/'')') at:1);
	level: header level.
	element
		addChild: aMicRootBlock children first;
		addChild: headerLink;
		"addChild: (self firstHeaderBlockOf: aMicRootBlock);"addChild:
			(self firstParagraphBlockOf: aMicRootBlock).

	^ element
]

{ #category : 'parsing' }
MicSingleSummarizer >> summarizeFile: aFileReference [

	| p |
	p := Microdown parse: aFileReference asFileReference contents.
	^ self summarize: p
]
