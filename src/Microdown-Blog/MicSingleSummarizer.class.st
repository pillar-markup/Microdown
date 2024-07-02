"
Create a MicRootBlock from another MicRootBlock ,or from a microdown file, with the fist header in a MicLink object and with the first paragraph.

For use it, you nedd to use summarizerFile: with a FileReference, or use summarize: with a MicRootBlock
"
Class {
	#name : 'MicSingleSummarizer',
	#superclass : 'MicAbstractBlogCreator',
	#instVars : [
		'maximumWords'
	],
	#category : 'Microdown-Blog',
	#package : 'Microdown-Blog'
}

{ #category : 'accessing' }
MicSingleSummarizer >> firstHeaderBlockOf: aMicRootBlock [

"Check if a Header exist and return it. Otherwise he create a new Header with 'Undefined' in value"

	| header newHeader |
	header := aMicRootBlock children
		          detect: [ :each | each isKindOf: MicHeaderBlock ]
		          ifNone: [
			          | h t |
			          h := MicHeaderBlock new.
			          t := MicTextBlock new bodyString:
				               'Please define a header'.
			          h level: 1.
			          t parent: h.
			          ^ h ].
	newHeader := MicHeaderBlock new.
	header headerElements do: [ :t | t copy parent: newHeader ].
	newHeader level: header level.
	^ newHeader
]

{ #category : 'accessing' }
MicSingleSummarizer >> firstParagraphBlockOf: aMicRootBlock [

"Check if a paragraph exist and return it. Otherwise he create a new paragraph with 'Undefined' in value"

	| p textElements newParagraph t |
	p := aMicRootBlock children
		     detect: [ :each | each isKindOf: MicParagraphBlock ]
		     ifNone: [
			     p := MicParagraphBlock new.
			     t := MicTextBlock new bodyString: 'Please add a paragraph'.
			     t parent: p.
			     ^ p ].

	textElements := self limitParagraphWord: p.

	newParagraph := MicParagraphBlock new.
	t := (MicInlineParser parse: textElements) first.
	t parent: newParagraph.
	^ newParagraph
]

{ #category : 'parsing' }
MicSingleSummarizer >> headerLink: aMicRootBlock [

"Take the first header of the MicRootBlock, and he transform the text inside the Header into a link"

	| headerLink header fileReference |
	headerLink := MicHeaderBlock new.
	header := self firstHeaderBlockOf: aMicRootBlock.

	fileReference := (aMicRootBlock fromFile withoutExtension fullName
		                  withoutPrefix: targetDirectory fullName) , '.html'.
	fileReference := fileReference asFileReference.

	headerLink
		addChild: (self makeALink: header text to: fileReference);
		level: header level.

	^ headerLink
]

{ #category : 'initialization' }
MicSingleSummarizer >> initialize [

	super initialize.
	maximumWords := 15.
]

{ #category : 'string-manipulation' }
MicSingleSummarizer >> limitParagraphWord: aMicParagraph [

"Limit the number of word in a paragraph with the maximumWords instance variable"

	| text sub selectionSize newSub textElements |
	text := '' writeStream.
	aMicParagraph children do: [ :each | text nextPutAll: each plainText ].
	text close.

	sub := text contents substrings: ' '.
	selectionSize := maximumWords min: sub size.
	newSub := sub first: selectionSize.

	textElements := '' writeStream.
	textElements nextPutAll: newSub first.
	2 to: newSub size do: [ :each |
		textElements
			nextPut: Character space;
			nextPutAll: (newSub at: each) ].

	sub size >= maximumWords ifTrue: [ textElements nextPutAll: '...' ].

	^ textElements close contents
]

{ #category : 'accessing' }
MicSingleSummarizer >> maximumWords: anInteger [ 
	maximumWords := anInteger
]

{ #category : 'parsing' }
MicSingleSummarizer >> summarize: aMicRootBlock [

	| element root dateparagraph |
	root := self verifyDateMetadata: aMicRootBlock.
	element := MicRootBlock new.

	dateparagraph := MicParagraphBlock new.
	dateparagraph addChild:
		(MicTextBlock new bodyString: (root children first body at: 'date')).

	element
		addChild: root children first;
		addChild: (self headerLink: aMicRootBlock);
		addChild: dateparagraph;
		addChild: (self firstParagraphBlockOf: root).

	^ element
]

{ #category : 'parsing' }
MicSingleSummarizer >> summarizeFile: aFileReference [

"parse and summarize a file"

	| root |
	root := Microdown parse: aFileReference asFileReference contents.
	root fromFile: aFileReference.
	^ self summarize: root
]
