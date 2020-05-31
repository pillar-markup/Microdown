"
# Microdown Parser and Elements

I'm a parser for microdown implemented by S. Ducasse, L. Dargaud and G. Polito. It is based on the work on markdown of K. Osterbye. 

Microdown is a smaller mardown than but mardown but more extensible. 
It supports the default
- Header
- Lists
- Paragraph
- Code with arguments: key=val&key2=val2
- Quote
- Table
But also 
- Environment with arguments
- Anchors
- Annotated paragraph
- Math with arguments
- and more intra block elements such as extensible markups, raw, math, and references.


I follow the design mentioned in [https://github.github.com/gfm](https://github.github.com/gfm), in particular the parsing strategy in appendix A.

In short, the strategy is that at any point in time, we might have a number of children of the root which are ""open"". The deepest in open in the tree is called ""current"". All the parents of current are open. 

When a new line is read we do the following:

1. Check if the new line can be consumed by current.
  - as part of this a child of current can be made which can consume the new line
2. If current cannot consume the new line, we close current, move current to its parent, and repeat 1.
3. The root node can consume anything, for instance by making new nodes for storing the new line.
4. The roor node is not closed until input is exhausted


I do not accept lazy definition. I do not accept three different ways to do the same. Except for bulleted list where * and - are accepted. 

When a new line is read we do the following:

1. Check if the new line can be consumed by current.
	- as part of this, a child of current can be made which can consume the new line.
	for example when consuming \`\`\` the root block node will create, a new code block 
	that will become current and consume the body of the \`\`\` element then close. 
2. If current cannot consume the new line, we close current, move current to its parent, and repeat 1.
3. The root node can consume anything, for instance by making new nodes for storing the new line.
4. The root node is not closed until input is exhausted.


The spec says:
```
-> document
  -> block_quote
       paragraph
         ""Lorem ipsum dolor\nsit amet.""
    -> list (type=bullet tight=true bullet_char=-)
         list_item
           paragraph
             ""Qui *quodsi iracundia*""
      -> list_item
        -> paragraph
             ""aliquando id""
```
Now the implementation for now does not create a paragraph in the list_item element. 

"
Class {
	#name : #MicMicrodownParser,
	#superclass : #Object,
	#instVars : [
		'current',
		'root'
	],
	#category : #'Microdown-Parser'
}

{ #category : #private }
MicMicrodownParser class >> allBlockNodeClasses [
	^ MicAbstractBlock allSubclasses
	
]

{ #category : #markups }
MicMicrodownParser class >> anchorMarkup [
	^ '@@'
]

{ #category : #markups }
MicMicrodownParser class >> annotatedParagraphMarkup [
	^ '!!'
]

{ #category : #markups }
MicMicrodownParser class >> argumentListStartDelimiter [
	
	^ '|'
]

{ #category : #markups }
MicMicrodownParser class >> boldMarkup [

	^ '*'
]

{ #category : #markups }
MicMicrodownParser class >> builder [
	^ MicBuilder new
]

{ #category : #markups }
MicMicrodownParser class >> codeblockMarkup [

	^ '```'
]

{ #category : #markups }
MicMicrodownParser class >> commentedLineMarkup [

	^ '%'
]

{ #category : #markups }
MicMicrodownParser class >> environmentClosingBlockMarkup [
	^ '?>'
]

{ #category : #markups }
MicMicrodownParser class >> environmentOpeningBlockMarkup [
	^ '<?'
]

{ #category : #examples }
MicMicrodownParser class >> example [
	<example>
	(self fromUrl: 'https://raw.githubusercontent.com/kasperosterbye/PillarRichTextRender/master/README.md') inspectWithLabel: 'PillarRichTextRender/README.md'
]

{ #category : #'instance creation' }
MicMicrodownParser class >> fromUrl: aUrl [
	
	^self asText:   
		(ZnClient new 
			beOneShot;
			get: aUrl;
			entity) string.
]

{ #category : #markups }
MicMicrodownParser class >> headerMarkup [

	^ '#'
]

{ #category : #markups }
MicMicrodownParser class >> mathClosingBlockMarkup [
	self flag: #fixMe. 
	"should implement block logic for different opening and closing this way we could have 
	a different markup."
	
	^ '&'
]

{ #category : #markups }
MicMicrodownParser class >> mathOpeningBlockMarkup [

	^ '&'
]

{ #category : #markups }
MicMicrodownParser class >> metaDataClosingBlockMarkup [
	^ '}'
]

{ #category : #markups }
MicMicrodownParser class >> metaDataOpeningBlockMarkup [
	^ '{'
]

{ #category : #markups }
MicMicrodownParser class >> preformattedMarkup [

	^ '> '
]

{ #category : #markups }
MicMicrodownParser class >> tableCellMarkup [

	^ '|'
]

{ #category : #markups }
MicMicrodownParser class >> unorderedListMarkup [

	^ '- '
]

{ #category : #markups }
MicMicrodownParser class >> unorderedListMarkups [

	^ #('- ' '* ' '+ ')
]

{ #category : #markups }
MicMicrodownParser >> anchorMarkup [
	^ self class anchorMarkup
]

{ #category : #markups }
MicMicrodownParser >> annotatedParagraphMarkup [
	^ self class annotatedParagraphMarkup
]

{ #category : #markups }
MicMicrodownParser >> argumentListStartDelimiter [
	
	^ self class argumentListStartDelimiter
]

{ #category : #'node creation' }
MicMicrodownParser >> blockExtensionStarterClassFrom: line [
	"return the class of a block which can start with line, or nil if none"
		
	^ nil
]

{ #category : #'node creation' }
MicMicrodownParser >> blockStarterClassFrom: line [
	"return the class of a block which can start with line, or nil if none"

	(self blockExtensionStarterClassFrom: line)
		ifNotNil: [ :c | ^ c ]
		ifNil: [ (line beginsWith: self headerMarkup)
				ifTrue: [ ^ MicHeaderBlock ].
			(line beginsWith: self codeblockMarkup)
				ifTrue: [ ^ MicCodeBlock ].
			(self matchUnordered: line)
				ifTrue: [ ^ MicUnorderedListBlock ].
			"this one could be split if we move to a dictionary based structure"
			(self matchOrdered: line)
				ifTrue: [ ^ MicOrderedListBlock ].
				"number followed by . or ). We could treat this one separated and fall back on a dictionary By moving this into the extension for example."
			(line beginsWith: self annotatedParagraphMarkup)
				ifTrue: [ ^ MicAnnotatedBlock ].
			(line beginsWith: self anchorMarkup)
				ifTrue: [ ^ MicAnchorBlock ].
			(line beginsWith: self commentedLineMarkup)
				ifTrue: [ ^ MicCommentBlock ].
			(line beginsWith: self mathOpeningBlockMarkup)
				ifTrue: [ ^ MicMathBlock ].
			(line beginsWith: self environmentOpeningBlockMarkup)
				ifTrue: [ ^ MicEnvironmentBlock ].
			(line beginsWith: self horizontalLineMarkup)
				ifTrue: [ ^ MicHorizontalLineBlock ].
			(line beginsWith: self metaDataOpeningBlockMarkup)
				ifTrue: [ ^ MicMetaDataBlock ].
			(line beginsWith: self preformattedMarkup)
				ifTrue: [ ^ MicQuoteBlock ].	"or '> '??"
			(line beginsWith: self tableCellMarkup)
				ifTrue: [ ^ MicTableBlock ].
			line ifNotEmpty: [ ^ MicParagraphBlock ] ifEmpty: [ ^ nil ] ]
]

{ #category : #markups }
MicMicrodownParser >> boldMarkup [

	^ self class boldMarkup
]

{ #category : #accessing }
MicMicrodownParser >> builder [
	"return a little helper to build microdown correct expression"
	
	^ self class builder
]

{ #category : #markups }
MicMicrodownParser >> codeblockMarkup [ 
	^ self class codeblockMarkup 
]

{ #category : #markups }
MicMicrodownParser >> commentedLineMarkup [

	^ self class commentedLineMarkup
]

{ #category : #accessing }
MicMicrodownParser >> current [ 

	^ current
]

{ #category : #markups }
MicMicrodownParser >> environmentClosingBlockMarkup [
	^ self class environmentClosingBlockMarkup
]

{ #category : #markups }
MicMicrodownParser >> environmentOpeningBlockMarkup [
	^ self class environmentOpeningBlockMarkup
]

{ #category : #parsing }
MicMicrodownParser >> handleErrorInLine: line [
		
	^ MicParsingError new 
		line: line;
		signal
	
]

{ #category : #parsing }
MicMicrodownParser >> handleLine: line [
	"The logic is the following: 
		-first line is cleaned to avoid noise,
		-then if the current block can consume the line, it manages it and this potentially creates a new block that becomes the current one.
		When the line is not consume, the current block is closed and its parent becomes the current one and the process is called back to treat the line."
	| normalized |
	normalized := line copyReplaceAll: String tab with: String space.
	[ 
	(current canConsumeLine: normalized)
		ifTrue: [ ^ current := current addLineAndReturnNextNode: normalized ]
		ifFalse: [ current closeMe ].
	current := current parent.
	self handleLine: normalized ] on: Error do: [ self handleErrorInLine: line ]
]

{ #category : #markups }
MicMicrodownParser >> headerMarkup [ 
	^ self class headerMarkup 
]

{ #category : #markups }
MicMicrodownParser >> horizontalLineMarkup [
	^ '***'
]

{ #category : #testing }
MicMicrodownParser >> isAList: normalized [
	
	^ (self matchUnordered: normalized) or: [ self matchOrdered: normalized ]
]

{ #category : #'node creation' }
MicMicrodownParser >> matchOrdered: line [
	^ line prefixMatchesRegex: '\d+(\.|\))'
]

{ #category : #'node creation' }
MicMicrodownParser >> matchUnordered: line [
	^ (line beginsWith: '- ') | (line beginsWith: '* ')
		| (line beginsWith: '+ ')
]

{ #category : #markups }
MicMicrodownParser >> mathClosingBlockMarkup [
	^ self class mathClosingBlockMarkup
]

{ #category : #markups }
MicMicrodownParser >> mathOpeningBlockMarkup [
	^ self class mathOpeningBlockMarkup
]

{ #category : #markups }
MicMicrodownParser >> metaDataClosingBlockMarkup [
	^ self class metaDataClosingBlockMarkup
]

{ #category : #markups }
MicMicrodownParser >> metaDataOpeningBlockMarkup [
	^ self class metaDataOpeningBlockMarkup
]

{ #category : #parsing }
MicMicrodownParser >> newRootBlock [
	^ MicRootBlock new
]

{ #category : #parsing }
MicMicrodownParser >> parse: aStreamOrString [
	"returns the root node of aStreamOrText"

	| inStream line |
	current := root := self newRootBlock
		setParser: self;
		yourself.
	inStream := aStreamOrString readStream.
	[ line := inStream nextLine.
	line isNil ] whileFalse: [ self handleLine: line ].
	[ current = root ]
		whileFalse: [ current closeMe.
			current := current parent ].
	^ root
]

{ #category : #markups }
MicMicrodownParser >> preformattedMarkup [ 
	^ self class preformattedMarkup 
]

{ #category : #markups }
MicMicrodownParser >> tableCellMarkup [

	^ self class tableCellMarkup
]
