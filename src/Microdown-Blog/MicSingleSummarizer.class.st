Class {
	#name : 'MicSingleSummarizer',
	#superclass : 'Object',
	#instVars : [
		'maximumWords',
		'destinationDirectory'
	],
	#category : 'Microdown-Blog',
	#package : 'Microdown-Blog'
}

{ #category : 'rendering' }
MicSingleSummarizer >> createHtmlFile: aMicRoot [

	| a q date header |
	a := (MicHTMLVisitor new visit: aMicRoot) at: 1.

	date := (aMicRoot children at: 1) body at: #date.
	date := date asDate.
	header := MicSingleSummarizer new firstHeaderBlockOf: aMicRoot.

	q := MicHTMLDocument new.
	q configuration: a configuration.
	q configuration document: q.
	q
		setCharSetUTF8;
		destinationPath:
			'\Users\qmout\Documents\Pharo\images\Microdown\output\html' , '\'
			, date year asString , '\' , date monthName , '\'
			, date day asString , '\'.
	^ q
		  fileName: header text , '.html';
		  writeDocument: a contents;
		  "writeToFileNamed: q destinationPath, header text;"contents
]

{ #category : 'accessing' }
MicSingleSummarizer >> destinationDirectory [

	^ destinationDirectory
]

{ #category : 'accessing' }
MicSingleSummarizer >> destinationDirectory: aDestination [

	destinationDirectory := aDestination
]

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

	| p textElements newParagraph selectionSize t sub newSub |
	p := aMicRootBlock children
		     detect: [ :each | each isKindOf: MicParagraphBlock ]
		     ifNone: [
			     p := MicParagraphBlock new.
			     t := MicTextBlock new bodyString: 'Please add a paragraph'.
			     t parent: p.
			     ^ p ].

	sub := p text substrings: ' '.
	selectionSize := maximumWords min: sub size.
	newSub := sub first: selectionSize.

	textElements := '' writeStream.
	newSub do: [ :each |
		textElements
			nextPutAll: each;
			nextPut: Character space ].
		
	sub size >= maximumWords ifTrue: [ textElements
			nextPutAll: '...' ].
		
		textElements close.


	newParagraph := MicParagraphBlock new.
	t := MicTextBlock new bodyString: textElements ensureNoSpace contents.
	t parent: newParagraph.
	^ newParagraph
]

{ #category : 'initialization' }
MicSingleSummarizer >> initialize [

	super initialize.
	maximumWords := 15.
	"Directory for testing, we should change this for the final directory"
	destinationDirectory := '\Users\qmout\Documents\Pharo\images\Microdown\output\html'
]

{ #category : 'accessing' }
MicSingleSummarizer >> maximumWords: anInteger [ 
	maximumWords := anInteger
]

{ #category : 'parsing' }
MicSingleSummarizer >> summarize: aMicRootBlock [

	| element headerLink |
	self createHtmlFile: aMicRootBlock .
	element := MicRootBlock new.
	headerLink := self transformHeaderToLinkHeader: (self firstHeaderBlockOf: aMicRootBlock).
	element
		addChild: aMicRootBlock children first;
		addChild: headerLink;
		addChild: (self firstParagraphBlockOf: aMicRootBlock).

	^ element
]

{ #category : 'parsing' }
MicSingleSummarizer >> summarizeFile: aFileReference [

	| p |
	p := Microdown parse: aFileReference asFileReference contents.
	^ self summarize: p
]

{ #category : 'parsing' }
MicSingleSummarizer >> transformHeaderToLinkHeader: aHeader [

	| headerLink |
	headerLink := MicHeaderBlock new.
	headerLink
		addChild:
			((MicInlineParser parse: '[' , aHeader text , '](''/'')') at: 1);
		level: aHeader level.
		
	^ headerLink
]
