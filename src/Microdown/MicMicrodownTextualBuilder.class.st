"
I'm a textual builder for Microdown: Using my API clients can generate text in Microdown format.


I have two kinds of clients.
- some to generate using high level Microdown blocks and text.
  for example using `paragraph: aBlock` I will generate a block and do not force the user to think about newline.
- some to generate pieces of text. For example the Pillar writer will invoke the raw version. For example `rawParagraph: aBlock` just issue a paragraph without taken care about new line.


#### Known limits 
Nested lists are probably not well managed.
In particular since ordered and unordered do not have the same indentation length 
we would have to know all the nested path and not just the level.
"
Class {
	#name : #MicMicrodownTextualBuilder,
	#superclass : #MicAbstractMicrodownTextualBuilder,
	#instVars : [
		'prefixStack',
		'currentLevel'
	],
	#category : #'Microdown-Parser'
}

{ #category : #'element - annotated' }
MicMicrodownTextualBuilder >> anchor: aLabel [

	self raw: AnchorMarkup.
	self raw: aLabel.

]

{ #category : #'element - format' }
MicMicrodownTextualBuilder >> anchorReference: aText [

	self raw: AnchorReferenceOpenerMarkup.
	self raw: aText.
	self raw: AnchorReferenceCloserMarkup.
]

{ #category : #'element - annotated' }
MicMicrodownTextualBuilder >> annotated: annotation paragraph:  aBlock [
	"!!Important 
	
	attention there is not space between the !! and the label (annotation in pillar) or we should improve the microdown parser"
	self rawAnnotated: annotation paragraph: aBlock. 
	self newLine

]

{ #category : #'element - annotated' }
MicMicrodownTextualBuilder >> annotatedAnnotation: annotation [
	"I'm made to be followed by a paragraph. I manage the space between the annotation/label and the paragraph."
	
	"!!Important there is not space between the !! and the label (annotation in pillar) or we should improve the microdown parser"
	self
		raw: AnnotatedParagraphMarkup;
		raw: annotation;
		raw: String space
	

]

{ #category : #'element - annotated' }
MicMicrodownTextualBuilder >> annotation: aString arguments: aDictionary [

	self raw: AnnotationOpenerMarkup.
	self raw: aString.
	aDictionary ifNotEmpty: [ 
		self raw: ' | '.
		aDictionary keysAndValuesDo: [ :key :value | 
			self raw: key.
			self raw: '='.
			self raw: value.
			key = aDictionary keys last ifFalse: [ self raw: '&' ] ] ].
	self raw: AnnotationCloserMarkup
]

{ #category : #'element - format' }
MicMicrodownTextualBuilder >> bold: aBlock [
	self raw: BoldMarkup.
	aBlock value.
	self raw: BoldMarkup.
]

{ #category : #accessing }
MicMicrodownTextualBuilder >> cell: aCellBlock [
	self raw: '| '.
	aCellBlock value.
	self raw: ' '
]

{ #category : #'element - code block' }
MicMicrodownTextualBuilder >> codeblock: aString [ 
	self codeblock: aString firstLineAssociations: #() 
]

{ #category : #'element - code block' }
MicMicrodownTextualBuilder >> codeblock: aString firstLineAssociations: aCol [
	self raw: CodeblockMarkup.
	aCol do: [ :each | self 
						raw: each key;
						raw: '=';
						raw: each value value asString
						"so that we can put format such as bold in the value"]
			separatedBy: [ self raw: '&' ].
	self newLine.
	self raw: aString.
	self newLine.
	self raw: CodeblockMarkup.
	self newLine.
]

{ #category : #'element - code block' }
MicMicrodownTextualBuilder >> codeblock: aString firstLineAssociations: aCol withCaption: aCaptionBlock [
	self raw: CodeblockMarkup.
	aCol do: [ :each | self 
						raw: each key;
						raw: '='.
						each key = #caption 
							ifTrue: [ aCaptionBlock value ]
						 	ifFalse: [ self raw: each value value  ]
						"so that we can put format such as bold in the value"]
			separatedBy: [ self raw: '&' ].
	self newLine.
	self raw: aString.
	self newLine.
	self raw: CodeblockMarkup.
	self newLine.
]

{ #category : #'element - code block' }
MicMicrodownTextualBuilder >> codeblockTag: aTag withBody: aString [
	self flag: #fixme. 
	"missing first line stuff and we need a block for value of keys
	because we can write ```language=pharo&caption=The **bold** and `mono`
	...
	"

	self raw: CodeblockMarkup.
	self raw: aTag.	
	self newLine.
	self raw: aString.
	self newLine.
	self raw: CodeblockMarkup.
]

{ #category : #'element - slide' }
MicMicrodownTextualBuilder >> columnWidth: aString withBody: aBodyBlock [ 
	self raw: EnvironmentOpeningBlockMarkup.
	self raw: 'column|width='.
	self raw: aString.
	self newLine.
	self newLine.
	aBodyBlock value.
	self newLine.
	self raw: EnvironmentClosingBlockMarkup.
	self newLine.
	self newLine.
]

{ #category : #'element - slide' }
MicMicrodownTextualBuilder >> columnsWithBody: aBodyBlock [ 
	
	self raw: EnvironmentOpeningBlockMarkup.
	self raw: 'columns|width=100'.
	self newLine.
	self newLine.
	aBodyBlock value.
	self newLine.
	self raw: EnvironmentClosingBlockMarkup.
	self newLine.
]

{ #category : #'element - header' }
MicMicrodownTextualBuilder >> comment: aText [
	self 
		withLinesIn: aText 
		do: [ :line | self writeText: line beginsWith: CommentedLineMarkup ] 		
		separatedBy: [ self newLine ]
	
]

{ #category : #'element - environment' }
MicMicrodownTextualBuilder >> environment: aName arguments: aCol [
	self raw: EnvironmentOpeningBlockMarkup.
	self raw: aName.
	self raw: ArgumentListStartDelimiter.
	self rawParameters: aCol asDictionary.
	self newLine.
	self raw: EnvironmentClosingBlockMarkup
]

{ #category : #'element - environment' }
MicMicrodownTextualBuilder >> environment: aName body: aBodyBlock arguments: aCol [
	
	self raw: EnvironmentOpeningBlockMarkup.
	self raw: aName.
	self raw: ArgumentListStartDelimiter.
	self rawParameters: aCol asDictionary.
	self newLine.
	aBodyBlock value.
	self newLine.
	self raw: EnvironmentClosingBlockMarkup
]

{ #category : #'element - references' }
MicMicrodownTextualBuilder >> externalLink: aURL withDescription: aDescriptionBlock [

	self raw: LinkNameOpenerMarkup.
	aDescriptionBlock value.
	self raw: LinkNameCloserMarkup.
	self raw: URLOpenerMarkup.
	self raw: aURL asString.
	self raw: URLCloserMarkup.
]

{ #category : #'element - figure' }
MicMicrodownTextualBuilder >> figureURL: aUrl withCaption: aDescriptionBlock [

	self rawFigureDescription: aDescriptionBlock.
	self raw: URLOpenerMarkup.
	self raw: aUrl asString. 
	self raw: URLCloserMarkup
]

{ #category : #'element - figure' }
MicMicrodownTextualBuilder >> figureURL: aUrl withCaption: aDescriptionBlock withParameters: anOrderedDictionary [
	"If you specify association of arguments then asSting is not the url but the url without the query part, i.e., http://www.pharo.org/figures/light.png"
	self deprecated: 'Better use figureURLString:withCaption:withParameters:'.
	anOrderedDictionary
		ifEmpty: [ 
			self figureURL: aUrl withCaption: aDescriptionBlock ]
		ifNotEmpty: [ 
			self rawFigureDescription: aDescriptionBlock.
			self raw: URLOpenerMarkup.
			aUrl scheme ifNotNil: [ :sch | self raw: sch asString, '://' ].
			aUrl authority ifNotNil: [ :auth | self raw: auth asString ].
			self raw: '/'.
			aUrl segments ifNotNil: [:segs | segs do: [:each | self raw: each asString]].
			self raw: Character space.
			"self raw: parserClass argumentListOfFigureStartDelimiter."
			self rawParameters: anOrderedDictionary.
			self raw: URLCloserMarkup ]
]

{ #category : #'element - figure' }
MicMicrodownTextualBuilder >> figureURLString: aString withCaption: aDescriptionBlock [
	"aString can be 'http://www.pharo.org or http://www.pharo.org?width=80&language=en'"
	
	self rawFigureDescription: aDescriptionBlock.
	self raw: URLOpenerMarkup.
	self raw: aString.
	self raw: URLCloserMarkup.
]

{ #category : #'element - figure' }
MicMicrodownTextualBuilder >> figureURLString: aString withCaption: aDescriptionBlock withParameters: anOrderedDictionary [
	"If you specify association of arguments then asSting is not the url but the url without the query part, i.e., http://www.pharo.org/figures/light.png
	
	In microdown external parameters i.e., the ones not part of the URL but part of the documents such as the label and size are following the url separated by a space.
	"
	
	anOrderedDictionary
		ifEmpty: [ 
			self figureURLString: aString withCaption: aDescriptionBlock ]
		ifNotEmpty: [ 
			self rawFigureDescription: aDescriptionBlock.
			self raw: URLOpenerMarkup.
			self raw: aString.
			self raw: Character space.
			"self raw: parserClass argumentListOfFigureStartDelimiter."
			self rawParameters: anOrderedDictionary.
			self raw: URLCloserMarkup ]
]

{ #category : #accessing }
MicMicrodownTextualBuilder >> headCell [
	self raw: '| --- '.
]

{ #category : #'element - header' }
MicMicrodownTextualBuilder >> header: aBloc withLevel: anInteger [
	self rawHeader: aBloc withLevel: anInteger.
	self newLine
]

{ #category : #'element - header' }
MicMicrodownTextualBuilder >> horizontalLine [
	self raw: HorizontalLineMarkup.
   self newLine

]

{ #category : #initialization }
MicMicrodownTextualBuilder >> initialize [
	super initialize.
	prefixStack := OrderedCollection new.
	currentLevel := -1.
	
]

{ #category : #'element - annotated' }
MicMicrodownTextualBuilder >> inputFile: aPathString [

	self raw: AnnotationOpenerMarkup.
	self raw: 'inputfile | path='.
	self raw: aPathString.
	self raw: AnnotationCloserMarkup
]

{ #category : #'element - annotated' }
MicMicrodownTextualBuilder >> inputfile: aPathString [
	"deprecated"
	self inputFile: aPathString
]

{ #category : #'element - references' }
MicMicrodownTextualBuilder >> internalLink: aLabel [
	self 
		writeText: aLabel 
		surroundBy: AnchorReferenceOpenerMarkup
		and: AnchorReferenceCloserMarkup
	
]

{ #category : #'element - format' }
MicMicrodownTextualBuilder >> italic: aBlock [
	self raw: ItalicMarkup.
	aBlock value.
	self raw: ItalicMarkup
]

{ #category : #'element - list' }
MicMicrodownTextualBuilder >> item: aBlock [

	self raw: (self startOfUnorderedListForLevel: currentLevel).
	aBlock value.
	self potentialNewLine.
]

{ #category : #'ugly line handling' }
MicMicrodownTextualBuilder >> lines: aString [
	"Output aString and take care of line ending within aString."
	| str |
	str := aString readStream.
	[ str atEnd ] whileFalse: [ | line |
		line := str nextLine.
		str atEnd
			ifTrue: [ self nextPutAll: line ]
			ifFalse: [ self line: line ]
	 ]
]

{ #category : #'element - format' }
MicMicrodownTextualBuilder >> mathInline: aText [

	self raw: MathMarkup.
	self raw: aText.
	self raw: MathMarkup.
]

{ #category : #'element - math' }
MicMicrodownTextualBuilder >> mathblock: aString firstLineAssociations: aCol [

	self raw: MathOpeningBlockMarkup.
	aCol do: [ :each | self 
						raw: each key;
						raw: '=';
						raw: each value value 
						"so that we can put format such as bold in the value"]
			separatedBy: [ self raw: '&' ].
	self newLine.
	self raw: aString.
	self newLine.
	self raw: MathClosingBlockMarkup.
	self newLine.
]

{ #category : #'element - math' }
MicMicrodownTextualBuilder >> mathblock: aString firstLineAssociations: aCol withCaption: aCaptionBlock [

	self raw: MathOpeningBlockMarkup.
	aCol do: [ :each | self 
						raw: each key;
						raw: '='.
						each key = #caption
							ifTrue: [ aCaptionBlock value ]
							ifFalse: [ self raw: each value value  ]
						"so that we can put format such as bold in the value"]
			separatedBy: [ self raw: '&' ].
	self newLine.
	self raw: aString.
	self newLine.
	self raw: MathClosingBlockMarkup.
	self newLine.
]

{ #category : #'element - metadata' }
MicMicrodownTextualBuilder >> metaDataFrom: aDictionary [ 

	self metaDataFromAssociations: aDictionary associations
]

{ #category : #'element - metadata' }
MicMicrodownTextualBuilder >> metaDataFromAssociations: aCollection [ 
	self raw: '{'; newLine.
	aCollection do: [ :each | 
		self raw: '"';
		raw: each key; 
		raw: '" : "';
		raw: each value;
		raw: '"'
		]
		separatedBy: [ self raw: ' , '].
	self newLine; raw: '}'.
]

{ #category : #'ugly line handling' }
MicMicrodownTextualBuilder >> nextPutAllLines: aString [
	self 
		withLinesIn: aString 
		do: [ :line | self nextPutAll: line ] 
		separatedBy: [ self newLine ]
]

{ #category : #'element - list' }
MicMicrodownTextualBuilder >> orderedItem: aBlock [

	self raw: (self startOfOrderedListForLevel: currentLevel).
	aBlock value.
	self potentialNewLine.
	
]

{ #category : #'element - list' }
MicMicrodownTextualBuilder >> orderedItem: aBlock startingAt: aNumber [

	self writeStartOfOrderedListIndex: aNumber.
	aBlock value.
	self newLine.
]

{ #category : #'element - list' }
MicMicrodownTextualBuilder >> orderedListDuring: aBlockClosure [
	"For list we do not emit empty line at the end because we do not want to force the creation of a paragraph 
	in the middle of nested list. And from a builder point of view this is difficult to know it."
	currentLevel := currentLevel + 1.
	aBlockClosure value.
	currentLevel := currentLevel - 1.
	"for now we do not care to generate 
	1. 
	2.
	
	but 
	1. 
	1.
	because this is the same"
		
]

{ #category : #'element - paragraph' }
MicMicrodownTextualBuilder >> paragraph: aBlock [

	self rawParagraph: aBlock.
	self newLine
]

{ #category : #'private utilities' }
MicMicrodownTextualBuilder >> popPrefix [
	
	prefixStack removeLast
]

{ #category : #'private utilities' }
MicMicrodownTextualBuilder >> pushPrefix: aString [ 
	
	prefixStack addLast: aString
]

{ #category : #'element - quote block' }
MicMicrodownTextualBuilder >> quoteBlock: aText [

	self writeText: aText beginsWith: PreformattedMarkup
]

{ #category : #'writing low-level' }
MicMicrodownTextualBuilder >> raw: aString [
	"We have in the prefix potentially many nesting level '> ', '```' and for each new line 
	we want to make sure that prefixes are written prior to aString.
	
	Now lastIsNewLine indicates that we should only do that for new line since 
	raw can be invoked for multiple reasons. Now the logic of writeIndentedCodeBlockDuring: only works if 
	this raw is invoked. 
	"

	lastIsNewLine ifTrue: [ 
		prefixStack do: [ :each |
			super raw: each ].
	].
	super raw: aString.
	lastIsNewLine := false
]

{ #category : #'element - annotated' }
MicMicrodownTextualBuilder >> rawAnnotated: annotation paragraph:  aBlock [
	"!!Important 
	
	attention there is not space between the !! and the label (annotation in pillar) or we should improve the microdown parser"
	self
		raw: AnnotatedParagraphMarkup;
		raw: annotation; 
		raw: String space;
		rawParagraph: aBlock
	

]

{ #category : #'element - figure' }
MicMicrodownTextualBuilder >> rawFigureDescription: aBlock [

	self raw: FigureNameOpenerMarkup.
	aBlock value.
	self raw: LinkNameCloserMarkup
]

{ #category : #'element - format' }
MicMicrodownTextualBuilder >> rawFormat: aText [

	self raw: RawOpenerMarkup.
	self raw: aText.
	self raw: RawCloserMarkup.
]

{ #category : #'writing low-level' }
MicMicrodownTextualBuilder >> rawHeader: aBloc withLevel: anInteger [

	self raw: (HeaderMarkup repeat: anInteger).
   self raw: String space.
	self flag: #todo. 
	"in this future once we are sure no one use header: [:b | b...] but [abuilder ..
	we should replace aBloc cull: self by aBloc value"
   aBloc cull: self 
	
]

{ #category : #'ugly line handling' }
MicMicrodownTextualBuilder >> rawLines: aString [
	"Output aString and take care of line ending within aString."
	self withLinesIn: aString do: [ :line | self raw: line ] separatedBy: [ self newLine ]
]

{ #category : #'writing low-level' }
MicMicrodownTextualBuilder >> rawParagraph: aBlock [

	aBlock value
	

	
	
]

{ #category : #'element - figure' }
MicMicrodownTextualBuilder >> rawParameters: aZnDictionary [
	"should be better to use do: separatedBy:"
	
	aZnDictionary keysAndValuesDo: [ :key :value | 
		self raw: key.
		self raw: ArgumentListEqualsDelimiter.
		self raw: value asString.
		key = aZnDictionary keys last ifFalse: [ 
			self raw: ArgumentListDelimiter ] ]
]

{ #category : #'ugly line handling' }
MicMicrodownTextualBuilder >> root: aBlock [
	
	aBlock value
]

{ #category : #'element - slide' }
MicMicrodownTextualBuilder >> slideTitle: aString withBody: aBodyBlock [ 
	
	self raw: EnvironmentOpeningBlockMarkup.
	self raw: 'slide|title='.
	self raw: aString.
	self newLine.
	self newLine.
	aBodyBlock value.
	self newLine.
	self raw: EnvironmentClosingBlockMarkup.
	self newLine.
]

{ #category : #'element - list' }
MicMicrodownTextualBuilder >> startOfOrderedListForLevel: aNumber [

	^ ('  ' repeat: aNumber) ,'1', OrderedListSemiMarkup
]

{ #category : #'element - list' }
MicMicrodownTextualBuilder >> startOfUnorderedListForLevel: aNumber [

	^ ('  ' repeat: aNumber) , UnorderedListMarkup
]

{ #category : #'element - format' }
MicMicrodownTextualBuilder >> strike: aBlock [
	self raw: StrikeMarkup.
	aBlock value.
	self raw: StrikeMarkup.
]

{ #category : #'element - list' }
MicMicrodownTextualBuilder >> unorderedListDuring: aBlockClosure [
	"For list we do not emit empty line at the end because we do not want to force the creation of a paragraph 
	in the middle of nested list. And from a builder point of view this is difficult to know it."
	
	self potentialNewLine.
	currentLevel := currentLevel + 1.
	"self
		writePrefix: (self startOfUnorderedListForLevel: currentLevel)
		forEachLineDuring: aBlockClosure."
	aBlockClosure value.
	currentLevel := currentLevel - 1.
]

{ #category : #'ugly line handling' }
MicMicrodownTextualBuilder >> withLinesIn: aString do: aBlock separatedBy: anotherBlock [
	"this method shows that the body of code block is weak because it should encapsulate the way it internally represents lines. Now this is exposed in clients."
	| str |
	str := aString readStream.
	[ str atEnd ]
		whileFalse: [ 
			| line |
			line := str nextLine.
			aBlock value: line.
			str atEnd
				ifFalse: anotherBlock ]
]

{ #category : #'writing during' }
MicMicrodownTextualBuilder >> writeIndentedCodeBlockDuring: aBlockClosure [ 
	"The logic of writeIndentedCodeBlockDuring: only works if the raw: method managing the prefixes
is invoked. Therefore somehow the blockclosure execution should invoke it.
It means that within the context of a visitor the visitText: method should do it."
	
	self
		writePrefix: PreformattedMarkup
		forEachLineDuring: aBlockClosure.
]

{ #category : #'writing during' }
MicMicrodownTextualBuilder >> writePrefix: aString forEachLineDuring: aBlockClosure [ 
	"The logic of writePrefix:forEachLineDuring: only works if the raw: method managing the prefixes
is invoked. Therefore somehow the blockclosure execution should invoke it.
It means that within the context of a visitor the visitText: method should do it."
	self pushPrefix: aString.
	aBlockClosure ensure: [ self popPrefix ].
]

{ #category : #'writing during' }
MicMicrodownTextualBuilder >> writeQuoteCodeBlockDuring: aBlockClosure [ 
	"The logic of writePrefix:forEachLineDuring: only works if the raw: method managing the prefixes
is invoked. Therefore somehow the blockclosure execution should invoke it.
It means that within the context of a visitor the visitText: method should do it."
	self
		writePrefix: PreformattedMarkup, String space
		forEachLineDuring: aBlockClosure
]

{ #category : #'element - list' }
MicMicrodownTextualBuilder >> writeStartOfOrderedListIndex: anInteger [
	"does not handle for now nesting"
	self raw: anInteger asString, OrderedListSemiMarkup
]
