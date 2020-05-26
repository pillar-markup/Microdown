"
I am a light parser for github markdown. I'm not fully implementing markdown (far too complex and clumsy). I do not accept lazy definition. I do not accept three different ways to do the same. Except for bulleted list where * and - are accepted. 


My implementation strategy is based on the specification in https://github.github.com/gfm, in particular the parsing strategy in appendix A.

In short, the strategy is that at any point in time, we might have a number of children of the root which are ""open"". The deepest open in the tree is called ""current"". All the parents of current are open. 

When a new line is read we do the following:

1. Check if the new line can be consumed by current.
	- as part of this, a child of current can be made which can consume the new line.
	for example when consuming ``` the root block node will create, a new code block 
	that will become current and consume the body of the ``` element then close. 
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



!! Todo

- extract a superclass of codeBlock named GHMStartStopDelimitedBlock (for starting and closing markup <? >)
- rename blocktext (check because if it cannot be name preformatted) 
- extract a superclass of blocktext named GHMContinuousMarkedBlock (>  for each line)
- read and check the intrablock parser. 

"
Class {
	#name : #GHMParser,
	#superclass : #Object,
	#instVars : [
		'current',
		'root'
	],
	#category : #'Microdown-Parser'
}

{ #category : #private }
GHMParser class >> allBlockNodeClasses [
	^ GHMAbstractBlock allSubclasses
	
]

{ #category : #markups }
GHMParser class >> codeblockMarkup [

	^ '```'
]

{ #category : #examples }
GHMParser class >> example [
	<example>
	(self fromUrl: 'https://raw.githubusercontent.com/kasperosterbye/PillarRichTextRender/master/README.md') inspectWithLabel: 'PillarRichTextRender/README.md'
]

{ #category : #'instance creation' }
GHMParser class >> fromUrl: aUrl [
	
	^self asText:   
		(ZnClient new 
			beOneShot;
			get: aUrl;
			entity) string.
]

{ #category : #markups }
GHMParser class >> headerMarkup [

	^ '#'
]

{ #category : #markups }
GHMParser class >> preformattedMarkup [

	^ '> '
]

{ #category : #markups }
GHMParser class >> tableCellMarkup [

	^ '|'
]

{ #category : #markups }
GHMParser class >> unorderedListMarkups [

	^ #('- ' '* ' '+ ')
]

{ #category : #'node creation' }
GHMParser >> blockExtensionStarterClassFrom: line [
	"return the class of a block which can start with line, or nil if none"
		
	^ nil
]

{ #category : #'node creation' }
GHMParser >> blockStarterClassFrom: line [
	"return the class of a block which can start with line, or nil if none"
	
	(self blockExtensionStarterClassFrom: line)
		ifNotNil: [ :c | ^ c ]
		ifNil: [ 
		(line beginsWith: self headerMarkup)
			ifTrue: [ ^ GHMHeaderBlock ].
		(line beginsWith: self codeblockMarkup)
			ifTrue: [ ^ GHMCodeBlock ].
		(self matchUnordered: line) "this one could be split if we move to a dictionary based structure"
			ifTrue: [ ^ GHMUnorderedListBlock ].
		(self matchOrdered: line)
			ifTrue: [ ^ GHMOrderedListBlock ].	"number followed by . or ). We could treat this one separated and fall back on a dictionary
			By moving this into the extension for example."
		(line beginsWith: self preformattedMarkup)
			ifTrue: [ ^ GHMQuoteBlock ].	"or '> '??"
		(line beginsWith: self tableCellMarkup)
			ifTrue: [ ^ GHMTableBlock ].	
		 line ifNotEmpty: [ ^ GHMParagraphBlock ]
				ifEmpty: [  ^ nil ]]
]

{ #category : #markups }
GHMParser >> codeblockMarkup [ 
	^ self class codeblockMarkup 
]

{ #category : #accessing }
GHMParser >> current [ 

	^ current
]

{ #category : #parsing }
GHMParser >> handleErrorInLine: line [
	"This implementation is temporary.
	The right way to handle this is to insert an error node into the tree"
	
	self error: 'I was not able to handle this input'.
]

{ #category : #parsing }
GHMParser >> handleLine: line [
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
GHMParser >> headerMarkup [ 
	^ self class headerMarkup 
]

{ #category : #testing }
GHMParser >> isAList: normalized [
	
	^ (self matchUnordered: normalized) or: [ self matchOrdered: normalized ]
]

{ #category : #'node creation' }
GHMParser >> matchOrdered: line [
	^ line prefixMatchesRegex: '\d+(\.|\))'
]

{ #category : #'node creation' }
GHMParser >> matchUnordered: line [
	^ (line beginsWith: '- ') | (line beginsWith: '* ')
		| (line beginsWith: '+ ')
]

{ #category : #parsing }
GHMParser >> newRootBlock [
	^ GHMRootBlock new
]

{ #category : #parsing }
GHMParser >> parse: aStreamOrString [
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
GHMParser >> preformattedMarkup [ 
	^ self class preformattedMarkup 
]

{ #category : #markups }
GHMParser >> tableCellMarkup [

	^ self class tableCellMarkup
]
