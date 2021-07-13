Class {
	#name : #MicHTMLWriter,
	#superclass : #MicDocumentWriter,
	#instVars : [
		'footnoteID',
		'noteDictionary'
	],
	#category : #'Microdown - HTML'
}

{ #category : #accessing }
MicHTMLWriter class >> fileExtension [
	^ 'html'
]

{ #category : #accessing }
MicHTMLWriter class >> folderName [
	^ #html
]

{ #category : #accessing }
MicHTMLWriter class >> writerName [
	^ #html
]

{ #category : #private }
MicHTMLWriter >> addAnchorFrom: anAnchor To: href [
	"I am here for the deck.js exporter or other exporter that would need to change the way anchor are generated."

	^ href , '#' , anAnchor anchor
]

{ #category : #accessing }
MicHTMLWriter >> canvas [
	
	^ canvas
]

{ #category : #accessing }
MicHTMLWriter >> canvasClass [
	^ MicHTMLCanvas
]

{ #category : #templating }
MicHTMLWriter >> chapterTemplateName [
	^ 'htmlChapterTemplate'
]

{ #category : #private }
MicHTMLWriter >> createAnchorWith: anId [
	canvas tag
		name: 'a';
		parameterAt: 'id' put: anId;
		with: ''
]

{ #category : #private }
MicHTMLWriter >> exportImgFor: aFigure [

	| img |
	img := canvas emptyTag
		       name: 'img';
		       parameterAt: 'src' put: aFigure localFileOrExternalReference;
		       yourself.
	aFigure arguments
		at: 'width'
		ifPresent: [ :width | 
		img parameterAt: 'width' put: width asString , '%' ].
	"aFigure hasLabel ifTrue:[
		img
			parameterAt: 'id'
			put: aFigure label ]."
	img parameterAt: 'alt' put: (aFigure children size > 0
			 ifTrue: [ aFigure substring ]
			 ifFalse: [ '' ]).
	img closeTag
]

{ #category : #'visiting-document' }
MicHTMLWriter >> generateLanguage: aCodeBlock for: code [

	aCodeBlock language ifNotNil: [ 
		code parameterAt: 'class' put: aCodeBlock language ]
]

{ #category : #private }
MicHTMLWriter >> internalLinkWillBeRender: anInternalLink [
	(anInternalLink hasReference and: [ anInternalLink hasAnchor not ])
		ifTrue: [ 
			MicLinkWarning
				signal:
					'Your inter-file link will not be rendered because you export without separate output files. If you want your link to be rendered add an anchor to the beginning of your file.' ]
]

{ #category : #private }
MicHTMLWriter >> noteAtEnd [
	self noteDictionary
		ifNotEmpty: [ canvas newLine.
			canvas tag
				name: 'hr';
				with: ''.
			canvas newLine ].
	self noteDictionary
		keysAndValuesDo: [ :keys :value | 
			canvas tag
				name: 'sup';
				parameterAt: 'id' put: 'footnote' , keys asString;
				with: '[' , keys asString , '] ' , value.
			canvas emptyTag
				name: 'br';
				closeTag.
			canvas newLine ]
]

{ #category : #accessing }
MicHTMLWriter >> noteDictionary [
	^ noteDictionary
]

{ #category : #visiting }
MicHTMLWriter >> start: anObject [
	canvas := self canvasClass on: stream.
	footnoteID := 0.
	noteDictionary := Dictionary new.
	super visit: anObject.
	self noteAtEnd.
	canvas flush
]

{ #category : #'visiting-document' }
MicHTMLWriter >> visitAnchor: anAnchor [
	self createAnchorWith: anAnchor name
]

{ #category : #'visiting-document' }
MicHTMLWriter >> visitAnnotatedParagraph: anAnnotatedParagraph [
	"Annotations need to be defined as CSS styles. For example...
		@@note 
		@@dothis
	could have...
	 	<head><style>
		p.note{colour:green}
		p.dothis{colour:red}
		</style></head> 
	"

	canvas tag
		name: 'p';
		parameterAt: 'class' put: anAnnotatedParagraph annotation;
		with: [ 
					"We call #visitParagraph: directly because we don't want 'self visitParagraph:' to be executed."
					super visitParagraph: anAnnotatedParagraph ]
]

{ #category : #'visiting-document' }
MicHTMLWriter >> visitBold: aFormat [
	canvas tag
		name: 'strong';
		with: [ super visitBold: aFormat ]
]

{ #category : #'visiting-document' }
MicHTMLWriter >> visitCode: aCodeBlock [

	canvas tag
		name: 'figure';
		with: [ 
			canvas tag
				name: 'pre';
				with: [ 
					| code |
					code := canvas tag
						        name: 'code';
						        yourself.
						
					aCodeBlock arguments ifNotEmpty: [ 
						self generateLanguage: aCodeBlock for: code].
					code with: [ canvas lines: aCodeBlock body ].
					
					aCodeBlock arguments ifNotEmpty: [
						canvas tag
							name: 'figcaption';
							with: [ aCodeBlock hasCaption ifTrue: [ 
										self visitAll: aCodeBlock captionElements ] ] ] ] ].
	canvas newLine
]

{ #category : #'visiting-document' }
MicHTMLWriter >> visitColumn: aColumn [
	canvas tag
		name: 'div';
		parameterAt: 'class' put: 'column';
		parameterAt: 'style' put: 'float:left; margin:0; width:' , aColumn width asString , '%;';
		with: [ "super visitColumn: aColumn" 'fix later' ].
	canvas newLine
]

{ #category : #'visiting-document' }
MicHTMLWriter >> visitColumns: aColumns [
	canvas tag
		name: 'div';
		parameterAt: 'class' put: 'columns';
		parameterAt: 'style' put: 'margin:0px auto; width:100%';
		with: [ super visitColumns: aColumns ].
	canvas newLine
]

{ #category : #'visiting-document' }
MicHTMLWriter >> visitFigure: aFigure [
	( aFigure hasCaption not )
		ifTrue: [ 
			self exportImgFor: aFigure.
			^ self ].
	aFigure url asString ifNotNil: [ :label | self createAnchorWith: label ].
	canvas newLine.
	canvas tag
		name: 'figure';
		with:
				[ 
			canvas newLine.
			canvas nextPut: Character tab.
			self exportImgFor: aFigure.
			canvas newLine.
			canvas nextPut: Character tab.
			canvas tag
				name: 'figcaption';
				with:
						[ 
					"aFigure label ifNotNil: [ self writeCounterForFigure: aFigure ]."
					super visitFigure: aFigure ].
			canvas newLine ]
]

{ #category : #'visiting-annotations' }
MicHTMLWriter >> visitFootnote: aFootnote [
	footnoteID := footnoteID + 1.
	canvas tag
		name: 'sup';
		with: [ canvas tag
				name: 'a';
				parameterAt: 'href' put: '#footnote' , footnoteID asString;
				with: '[' , footnoteID asString , ']' ].
	noteDictionary at: footnoteID ifAbsentPut: aFootnote note
]

{ #category : #'visiting-document' }
MicHTMLWriter >> visitHeader: aHeader [
	| level |
	"h1 to h7 exist."
	level := aHeader level min: 7 max: 1.
	canvas tag
		name: 'h' , level asString;
		with: [ 
					self writeCounterForHeader: aHeader.
					super visitHeader: aHeader ].
	canvas newLine
]

{ #category : #'visiting-document' }
MicHTMLWriter >> visitHorizontalLine: anHorizontalRule [

	canvas newLine; newLine.
	canvas raw: '<hr>'.
	canvas newLine.
]

{ #category : #'visiting-document' }
MicHTMLWriter >> visitInternalLink: anInternalLink [
	| href |
	href := String new.
	anInternalLink hasReference
		ifTrue: [ href := href , anInternalLink referenceAsHTML ].
	anInternalLink hasAnchor
		ifTrue: [ href := self addAnchorFrom: anInternalLink To: href ].
	canvas tag
		name: 'a';
		parameterAt: 'href' put: href;
		with: [ 
					anInternalLink counter isValidCounter
						ifTrue: [ 
							self writeCounter: anInternalLink counter.
							anInternalLink hasAlias
								ifTrue: [ canvas nextPutAll: ' ' ] ].
					super visitInternalLink: anInternalLink ]
]

{ #category : #'visiting-document' }
MicHTMLWriter >> visitItalic: aFormat [
	canvas tag
		name: 'em';
		with: [ super visitItalic: aFormat ]

]

{ #category : #'visiting-document' }
MicHTMLWriter >> visitLink: anExternalLink [
	|visitor|
	visitor := self class new.
	anExternalLink captionElements do: [ :each | each accept: visitor ].
	canvas tag
		name: 'a';
		parameterAt: 'href' put: anExternalLink localFileOrExternalReference;
		with: visitor contents
]

{ #category : #'visiting-document' }
MicHTMLWriter >> visitListItem: anItem [
	canvas tag
		name: 'li';
		with: [ super visitListItem: anItem ].
	canvas newLine
]

{ #category : #'visiting-document' }
MicHTMLWriter >> visitMailLink: aLink [
	canvas tag
		name: 'a';
		parameterAt: 'href' put: aLink unscrambledUrl;
		with: aLink alias
]

{ #category : #'visiting-document' }
MicHTMLWriter >> visitMonospace: aFormat [
	canvas tag
		name: 'code';
		with: [ super visitBold: aFormat ]
]

{ #category : #'visiting-document' }
MicHTMLWriter >> visitOrderedList: aList [
	canvas tag
		name: 'ol';
		with: [ super visitOrderedList: aList ].
	canvas newLine
]

{ #category : #'visiting-document' }
MicHTMLWriter >> visitParagraph: aParagraph [
	(aParagraph children size = 1 and: [ aParagraph children first isKindOf: MicRawBlock ])
		ifTrue: [ 
			self
				flag:
					'TODO: ugly fix. The idea is that you don''t want the <p> when using a Raw that potentially displays a <div>, because this is not HTML compliant'.
			self visitRaw: aParagraph children first ]
		ifFalse: [ 
			canvas tag
				name: 'p';
				with: [ canvas newLine.
							super visitParagraph: aParagraph.
							canvas newLine ] ]
]

{ #category : #'visiting-document' }
MicHTMLWriter >> visitPreformatted: aPreformatted [
	canvas tag
		name: 'pre';
		with: [ aPreformatted children do: [ :child | self visit: child ] separatedBy: [ canvas newLine ] ]
]

{ #category : #'visiting-document' }
MicHTMLWriter >> visitSection: aSection [
	canvas tag
		name: 'section';
		with: [ 
					canvas newLine.
					super visitSection: aSection ]
]

{ #category : #'visiting-document' }
MicHTMLWriter >> visitStrike: aFormat [
	canvas tag
		name: 's';
		with: [ super visitStrike: aFormat ]
]

{ #category : #'visiting-document' }
MicHTMLWriter >> visitTable: aTable [
	canvas tag
		name: 'table';
		parameterAt: 'style' put: 'border: solid thin';
		with: [ super visitTable: aTable ].
	canvas newLine
]

{ #category : #'visiting-document' }
MicHTMLWriter >> visitTableCell: aCell [
	| tagName tag |
	tagName := aCell isHeading
		ifTrue: [ 'th' ]
		ifFalse: [ 'td' ].
	tag := canvas tag name: tagName.
	aCell isAligned
		ifTrue: [ 
			aCell isAlignedLeft
				ifTrue: [ tag parameterAt: 'style' put: 'text-align: left' ].
			aCell isAlignedCenter
				ifTrue: [ tag parameterAt: 'style' put: 'text-align: center' ].
			aCell isAlignedRight
				ifTrue: [ tag parameterAt: 'style' put: 'text-align: right' ] ].
	tag with: [ super visitTableCell: aCell ].
	canvas newLine
]

{ #category : #'visiting-document' }
MicHTMLWriter >> visitTableRow: aRow [
	canvas tag
		name: 'tr';
		with: [ super visitTableRow: aRow ].
	canvas newLine
]

{ #category : #'visiting-document' }
MicHTMLWriter >> visitUnorderedList: aList [
	canvas tag
		name: 'ul';
		with: [ 
					canvas newLine.
					super visitUnorderedList: aList ].
	canvas newLine
]

{ #category : #writing }
MicHTMLWriter >> writeParagraphDuring: aBlockClosure [ 
	
	canvas tag
		name: 'p';
		with: [ 
			canvas newLine.
			aBlockClosure value.
			canvas newLine ]
]

{ #category : #accessing }
MicHTMLWriter >> writerFor: aPRPillarConfiguration [ 
	
	^ (MicDocumentWriter allSubclasses detect: [ :each | 
		each isAbstract not
			and: [ each writerName = (aPRPillarConfiguration propertyAt: #htmlWriter) ] ])
				new
]
