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
	#name : #MicroDownParser,
	#superclass : #Object,
	#instVars : [
		'current',
		'root'
	],
	#classInstVars : [
		'inlineMarkups'
	],
	#category : #'Microdown-Parser'
}

{ #category : #private }
MicroDownParser class >> allBlockNodeClasses [
	^ MicAbstractBlock allSubclasses
	
]

{ #category : #'block markup' }
MicroDownParser class >> anchorMarkup [
	^ '@'
]

{ #category : #'block markup' }
MicroDownParser class >> annotatedParagraphMarkup [
	^ '!!'
]

{ #category : #markups }
MicroDownParser class >> argumentListStartDelimiter [
	
	^ '|'
]

{ #category : #'grammar - Format' }
MicroDownParser class >> boldMarkup [
	^ self inlineMarkups at: #bold
]

{ #category : #private }
MicroDownParser class >> builder [
	^ MicBuilder new
]

{ #category : #'block markup' }
MicroDownParser class >> codeblockMarkup [

	^ '```'
]

{ #category : #'block markup' }
MicroDownParser class >> commentedLineMarkup [

	^ '%'
]

{ #category : #'block markup' }
MicroDownParser class >> environmentClosingBlockMarkup [
	^ '?>'
]

{ #category : #'block markup' }
MicroDownParser class >> environmentOpeningBlockMarkup [
	^ '<?'
]

{ #category : #examples }
MicroDownParser class >> example [
	<sampleInstance>
	^ self parse: self comment
]

{ #category : #'grammar - Format' }
MicroDownParser class >> figureOpenerMarkup [
	^ self inlineMarkups at: #figureOpener
]

{ #category : #'block markup' }
MicroDownParser class >> headerMarkup [

	^ '#'
]

{ #category : #'grammar - Format' }
MicroDownParser class >> inlineMarkup: aType [
	^ self inlineMarkups at: aType asSymbol
]

{ #category : #markups }
MicroDownParser class >> inlineMarkups [
	^ inlineMarkups ifNil: [ 
		inlineMarkups := Dictionary new.
	MicAbstractDelimiter subclasses 
		do: [ :subclass | 
			| role |
			role := subclass isOpener ifTrue: [ subclass isCloser ifTrue: [ '' ] ifFalse: [ 'Opener' ] ] ifFalse: [ 'Closer' ].			
			inlineMarkups
										at: subclass type asString, role
										put: subclass markup ].
									^ inlineMarkups ]
]

{ #category : #'grammar - Format' }
MicroDownParser class >> linkNameCloserMarkup [
	^ self inlineMarkups at: #linkNameCloser
]

{ #category : #'grammar - Format' }
MicroDownParser class >> linkNameOpenerMarkup [
	^ self inlineMarkups at: #linkNameOpener
]

{ #category : #'block markup' }
MicroDownParser class >> mathClosingBlockMarkup [
	self flag: #fixMe. 
	"should implement block logic for different opening and closing this way we could have 
	a different markup."
	
	^ '&'
]

{ #category : #'block markup' }
MicroDownParser class >> mathOpeningBlockMarkup [

	^ '&'
]

{ #category : #'block markup' }
MicroDownParser class >> metaDataClosingBlockMarkup [
	^ '}'
]

{ #category : #'block markup' }
MicroDownParser class >> metaDataOpeningBlockMarkup [
	^ '{'
]

{ #category : #'grammar - Format' }
MicroDownParser class >> monospaceMarkup [
	^ self inlineMarkups at: #monospace
]

{ #category : #'instance creation' }
MicroDownParser class >> parse: aString [

	^ self new parse: aString
]

{ #category : #'block markup' }
MicroDownParser class >> preformattedMarkup [

	^ '> '
]

{ #category : #'block markup' }
MicroDownParser class >> tableCellMarkup [

	^ '|'
]

{ #category : #'block markup' }
MicroDownParser class >> unorderedListMarkup [

	^ '- '
]

{ #category : #'block markup' }
MicroDownParser class >> unorderedListMarkups [

	^ #('- ' '* ' '+ ')
]

{ #category : #'grammar - Format' }
MicroDownParser class >> urlCloserMarkup [
	^ self inlineMarkups at: #urlCloser
]

{ #category : #'grammar - Format' }
MicroDownParser class >> urlOpenerMarkup [
	^ self inlineMarkups at: #urlOpener
]

{ #category : #markups }
MicroDownParser >> anchorMarkup [
	^ self class anchorMarkup
]

{ #category : #markups }
MicroDownParser >> annotatedParagraphMarkup [
	^ self class annotatedParagraphMarkup
]

{ #category : #markups }
MicroDownParser >> argumentListStartDelimiter [
	
	^ self class argumentListStartDelimiter
]

{ #category : #'node creation' }
MicroDownParser >> blockExtensionStarterClassFrom: line [
	"return the class of a block which can start with line, or nil if none"
	
	"We may use this for item not matching a dictionary-based dispatch"
	^ nil
]

{ #category : #'node creation' }
MicroDownParser >> blockStarterClassFrom: line [
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
MicroDownParser >> boldMarkup [

	^ self class boldMarkup
]

{ #category : #accessing }
MicroDownParser >> builder [
	"return a little helper to build microdown correct expression"
	
	^ self class builder
]

{ #category : #markups }
MicroDownParser >> codeblockMarkup [ 
	^ self class codeblockMarkup 
]

{ #category : #markups }
MicroDownParser >> commentedLineMarkup [

	^ self class commentedLineMarkup
]

{ #category : #accessing }
MicroDownParser >> current [ 

	^ current
]

{ #category : #markups }
MicroDownParser >> environmentClosingBlockMarkup [
	^ self class environmentClosingBlockMarkup
]

{ #category : #markups }
MicroDownParser >> environmentOpeningBlockMarkup [
	^ self class environmentOpeningBlockMarkup
]

{ #category : #parsing }
MicroDownParser >> handleErrorInLine: line [
		
	^ MicParsingError new 
		line: line;
		signal
	
]

{ #category : #parsing }
MicroDownParser >> handleLine: line [
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
MicroDownParser >> headerMarkup [ 
	^ self class headerMarkup 
]

{ #category : #markups }
MicroDownParser >> horizontalLineMarkup [
	^ '***'
]

{ #category : #testing }
MicroDownParser >> isAList: normalized [
	
	^ (self matchUnordered: normalized) or: [ self matchOrdered: normalized ]
]

{ #category : #'node creation' }
MicroDownParser >> matchOrdered: line [
	^ line prefixMatchesRegex: '\d+(\.|\))'
]

{ #category : #'node creation' }
MicroDownParser >> matchUnordered: line [
	^ (line beginsWith: '- ') | (line beginsWith: '* ')
		| (line beginsWith: '+ ')
]

{ #category : #markups }
MicroDownParser >> mathClosingBlockMarkup [
	^ self class mathClosingBlockMarkup
]

{ #category : #markups }
MicroDownParser >> mathOpeningBlockMarkup [
	^ self class mathOpeningBlockMarkup
]

{ #category : #markups }
MicroDownParser >> metaDataClosingBlockMarkup [
	^ self class metaDataClosingBlockMarkup
]

{ #category : #markups }
MicroDownParser >> metaDataOpeningBlockMarkup [
	^ self class metaDataOpeningBlockMarkup
]

{ #category : #parsing }
MicroDownParser >> newRootBlock [
	^ MicRootBlock new
]

{ #category : #parsing }
MicroDownParser >> parse: aStreamOrString [
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
MicroDownParser >> preformattedMarkup [ 
	^ self class preformattedMarkup 
]

{ #category : #markups }
MicroDownParser >> tableCellMarkup [

	^ self class tableCellMarkup
]
