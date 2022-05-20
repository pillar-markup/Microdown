"
# Microdown Parser and Elements

I'm a parser for Microdown, implemented by S. Ducasse, L. Dargaud and G. Polito (2020). 
It is based on K. Osterbye's work on GitHubMarkdown. 

Microdown covers Markdown basis syntax, with great Pillar's features. It's more extensible too.

## MicroDown Syntax in a Nutshell!

**Headers** (up to 6 levels) >>>> `# Header level 1`

**Unordered list**
```
- item a
  on another line
- item b
   - item b1
   - item b2
- item c
```

produces

- item a
  on another line
- item b
   - item b1
   - item b2
- item c

**Ordered list**
```
1. item one
   1. subitem
2. item two
```
produces 

1. item one
   1. subitem
2. item two


**Codeblock with arguments**
```
 ```language=Pharo&caption=Beautiful&label=Fig1
 some piece of code
 ```
```

produces 

```language=Pharo&caption=Beautiful&label=Fig1
some piece of code
```

**Anchor and its reference** >>>> `\@anchor` and its reference in text with `\*@anchor@*`

**Math environment** (rendered with LaTex in Pharo)
- inline: $\cos(\theta_i+C_3)$ >>>> `\$\cos(\theta_i+C_3)$`
- block: 
```
 $
 \cos(\theta_i+C_3)
 $
```
**Annotated paragraph**
``` 
 !!note Then you can write your note
 on several lines, like a normal paragraph
```
**Quote** to indent some lines
```
> This is
> A nice quote
```
**Environment** (called Annotation for inline)
- inline: `\<?keyword|key1=value1&key2=value2?>`
- block: 
```
 <?keyword|key1=value1&key2=value2
 type your content
 ?>
```
**Metadata** as a block
```
 { 
 type your metadata
 }
```

**Table** **@tocomment**

**Horizontal line** >>> `***` alone on a line will define a separator in your text **@todo**

**Comments** don't appear after parsing >>> `% A commented line`

**Inline formats**
- **bold** >>>> `**bold**`
- _italic_ >>>> `\_italic_`
- `monospace` aka inline code >>>> `\`monospace\``

_Note: inline escape character is back slash: \\ ._
_Note: text in monospace is analyzed for you to generate hypertext Pharo code objects! Isn't it so cool to write a great doc? It is! Click on them!_
- `Point` for classes
- `Point class` for class side
- `Point>>#setX:setY:` for methods
- `#'Microdown-Tests'` for packages

**Raw** for your other code (inline) >>>> `\{{ some code }}`

**Link** >>>> `\[link's name](url|key1=value1&key2=value2)`

**Figure** >>>> `\!\[figure's name](url|key1=value1&key2=value2)`

`![Pharo logo](https://files.pharo.org/media/logo/logo.png)`
produces

![Pharo logo](https://files.pharo.org/media/logo/logo.png)


## Implementation

I follow the design mentioned in [https://github.github.com/gfm](https://github.github.com/gfm), in particular the parsing strategy in appendix A.

In short, the strategy is that at any point in time, we might have a number of children of the root which are ""open"". The deepest in open in the tree is called ""current"". All the parents of current are open. 

When a new line is read we do the following:

1. Check if the new line can be consumed by current.
   - as part of this, a child of current can be made which can consume the new line. for example when consuming \`\`\` the root block node will create, a new code block that will become current and consume the body of the \`\`\` element then close. 
2. If current cannot consume the new line, we close current, move current to its parent, and repeat 1.
3. The root node can consume anything, for instance by making new nodes for storing the new line.
4. The root node is not closed until input is exhausted.

I do not accept lazy definition. I do not accept three different ways to do the same. Except for bulleted list where `*` and `-` are accepted. 

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
	#name : #MicrodownParser,
	#superclass : #Object,
	#instVars : [
		'current',
		'root',
		'dispatchTable'
	],
	#pools : [
		'MicroSharedPool'
	],
	#category : #'Microdown-Parser'
}

{ #category : #builder }
MicrodownParser class >> builder [
	^ MicMicrodownTextualBuilder new
]

{ #category : #examples }
MicrodownParser class >> example [
	<sampleInstance>
	^ self parse: self comment
]

{ #category : #'instance creation' }
MicrodownParser class >> parse: aString [

	^ self new parse: aString
]

{ #category : #'node creation' }
MicrodownParser >> blockStarterClassFrom: line [
	"return the class of a block which can start with line, or nil if none"

	line ifEmpty: [ ^ nil ].
	(self matchOrdered: line)
		ifTrue: [ ^ self orderedListBlockClass ]
		ifFalse: [
			"the max significant length of a markup is 3"
			(3 to: 1 by: -1) do: [:i | | prefix |
				prefix := (line truncateTo: i).
				"If we have a inline starter, it takes precedence"
				(Delimiters includes: prefix) 
					ifTrue: [ ^ self delimiterBlockClassFor: prefix ].
  				dispatchTable
    		 		at: prefix
      				ifPresent: [ :blockClass | ^ blockClass ] ] ].
	
	^ self nonMatchedBlockClassFor: line
]

{ #category : #accessing }
MicrodownParser >> builder [
	"return a little helper to build microdown correct expression"
	
	^ self class builder
]

{ #category : #accessing }
MicrodownParser >> current [ 

	^ current
]

{ #category : #'node creation' }
MicrodownParser >> delimiterBlockClassFor: prefix [

	^ self paragraphBlockClass
]

{ #category : #parsing }
MicrodownParser >> handleErrorInLine: line [
		
	^ MicParsingError new 
		line: line;
		signal
	
]

{ #category : #parsing }
MicrodownParser >> handleLine: line [
	"The logic is the following: 
		-first line is cleaned to avoid noise,
		-then if the current block can consume the line, it manages it and this potentially creates a new block that becomes the current one.
		When the line is not consumed, the current block is closed and its parent becomes the current one and the process is called back to treat the line."
		
	| normalized |
	normalized := line copyReplaceAll: String tab with: String space.
	[ 
	(current canConsumeLine: normalized)
		ifTrue: [ 
			current := current addLineAndReturnNextNode: normalized.
			^ current ]
		ifFalse: [ 
			current closeMe ].
	current := current parent.
	self handleLine: normalized ] on: Error do: [ self handleErrorInLine: line ]
]

{ #category : #initialization }
MicrodownParser >> initialize [

	super initialize.
	dispatchTable := Dictionary new.
	dispatchTable at: AnchorMarkup put: MicAnchorBlock.
	dispatchTable at: HeaderMarkup put: MicHeaderBlock.
	dispatchTable at: CodeblockMarkup put: MicCodeBlock.
	dispatchTable at: AnnotatedParagraphMarkup put: MicAnnotatedBlock.
	dispatchTable at: CommentedLineMarkup put: MicCommentBlock.
	dispatchTable at: HorizontalLineMarkup put: MicHorizontalLineBlock.
	dispatchTable at: MathOpeningBlockMarkup put: MicMathBlock.
	dispatchTable at: EnvironmentOpeningBlockMarkup put: MicEnvironmentBlock.
	dispatchTable at: MetaDataOpeningBlockMarkup put: MicMetaDataBlock.
	dispatchTable at: UnorderedListPlusMarkup put: MicUnorderedListBlock.
	dispatchTable at: UnorderedListMarkup put: MicUnorderedListBlock.
	dispatchTable at: UnorderedListStarMarkup put: MicUnorderedListBlock.
	dispatchTable at: PreformattedMarkup put: MicQuoteBlock.
	dispatchTable at: TableCellMarkup put: MicTableBlock.
]

{ #category : #testing }
MicrodownParser >> isAList: normalized [
	
	^ (self matchUnordered: normalized) or: [ self matchOrdered: normalized ]
]

{ #category : #'node creation' }
MicrodownParser >> matchOrdered: line [
	^ line prefixMatchesRegex: '\d+(\.|\))'
]

{ #category : #'node creation' }
MicrodownParser >> matchUnordered: line [
	^ ( line beginsWith: UnorderedListPlusMarkup ) 
		| ( line beginsWith: UnorderedListStarMarkup ) 
		| ( line beginsWith: UnorderedListMarkup )
]

{ #category : #parsing }
MicrodownParser >> newRootBlock [
	^ MicRootBlock new
]

{ #category : #'node creation' }
MicrodownParser >> nonMatchedBlockClassFor: line [

	^ self paragraphBlockClass
]

{ #category : #'node creation' }
MicrodownParser >> orderedListBlockClass [

	^ MicOrderedListBlock
]

{ #category : #'node creation' }
MicrodownParser >> paragraphBlockClass [

	^ MicParagraphBlock
]

{ #category : #parsing }
MicrodownParser >> parse: aStreamOrString [
	"returns the root node of aStreamOrText"

	| inStream line |
	current := root := self newRootBlock
		setParser: self;
		yourself.
	inStream := aStreamOrString isStream 
		ifTrue:  [ aStreamOrString readStream ]
		ifFalse: [  aStreamOrString asString readStream ].
	[ 
		line := inStream nextLine.
		line isNil ] 
	whileFalse: [ 
		self handleLine: line ].
	[ current = root ]
		whileFalse: [ 
			current closeMe.
			current := current parent ].
	^ root
]

{ #category : #accessing }
MicrodownParser >> setCurrent: aBlock [
	"aBlock parent = current 
		ifFalse: [ self error: 'When changing current, the current block should be the parent of the new one' ].
	note for me: we could just inforce this. aBlock parent: current.
	No this is not correct since 
	the parent of an item list is the list and this is the list that is parent of environment."	
	current := aBlock
]
