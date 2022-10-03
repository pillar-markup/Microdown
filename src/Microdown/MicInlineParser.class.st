"
I'm a parser of block text. I'm responsible to generate text, annotation, format, link, url kind of objects.
"
Class {
	#name : #MicInlineParser,
	#superclass : #Object,
	#instVars : [
		'openersStack',
		'result',
		'index',
		'string',
		'incrementation',
		'children',
		'nestedLevel',
		'opener',
		'closer',
		'correctSubstring',
		'correctURL',
		'delimiterClass',
		'keys',
		'allDelimiters'
	],
	#classVars : [
		'AllDelimiters',
		'KeyBeginSet'
	],
	#pools : [
		'MicMicrodownSharedPool'
	],
	#category : #'Microdown-Parser'
}

{ #category : #accessing }
MicInlineParser class >> abstractDelimiterClass [

	^ MicAbstractDelimiter
]

{ #category : #accessing }
MicInlineParser class >> allDelimiters [
	
	AllDelimiters ifNil: [ 
		AllDelimiters := Dictionary new.
		self abstractDelimiterClass allActive do: [ :subclass | 
				AllDelimiters 
					at: subclass markup 
					put: subclass ] ].

	^ AllDelimiters 
]

{ #category : #'escape character' }
MicInlineParser class >> escapeDecode: aString [
	"I convert all encoded chars back to their original (without the leading escape character)"
	"My sister method escapeEncode encodes into the format I decode from"
	| inStream outStream char special |
	aString ifEmpty: [ ^aString ].
	special := [ :c | c asInteger between: self magicCharacter  and: self magicCharacter + 65536 ].
	inStream := ReadStream on: aString.
	outStream := WriteStream on: String new.
	[ inStream atEnd ] whileFalse: [ 
		char := inStream next.
		(special value: char)
			ifTrue: [ char := (char asInteger - self magicCharacter ) asCharacter  ].
		outStream nextPut: char
	].
	^ outStream contents
	
]

{ #category : #'escape character' }
MicInlineParser class >> escapeEncode: aString [
	"I convert all escaped characters (eg '\`' or '\\') into special characters which are not used in Microdown"
	"My sister method escapeDecode reverts back"
	| inStream outStream char |
	aString size <= 1 ifTrue: [ ^aString ].
	inStream := ReadStream on: aString.
	outStream := WriteStream on: String new.
	[ inStream atEnd ] whileFalse: [ 
		char := inStream next.
		(char = $\ and: [ inStream atEnd not ]) 
			ifTrue: [ char := (inStream next asInteger + self magicCharacter) asCharacter  ].
		outStream nextPut: char
	].
	^ outStream contents
	
]

{ #category : #'escape character' }
MicInlineParser class >> escapeReescape: aString except: keep [
	"I convert all encoded back to escaped chars, except the characters in keep"
	"My sister method escapeEncode encodes into the format I decode from"
	| inStream outStream char |
	aString ifEmpty: [ ^aString ].
	inStream := ReadStream on: aString.
	outStream := WriteStream on: String new.
	[ inStream atEnd ] whileFalse: [ 
		char := inStream next.
		(char asInteger between: self magicCharacter  and: self magicCharacter + 65536)
			ifTrue: [ 
				char := (char asInteger - self magicCharacter ) asCharacter.  
				(keep includes: char) ifFalse: [outStream nextPut: $\]] .
		outStream nextPut: char
	].
	^ outStream contents
	
]

{ #category : #'class initialization' }
MicInlineParser class >> initialize [
	<script>
	AllDelimiters := KeyBeginSet := nil.
]

{ #category : #accessing }
MicInlineParser class >> keyBeginSet [

	KeyBeginSet ifNil: [ KeyBeginSet := (self allDelimiters keys collect: #first) asSet ].
	^ KeyBeginSet
]

{ #category : #'escape character' }
MicInlineParser class >> magicCharacter [
	"All escaped characters are moved out of range. 
	The unicode range Private Use Area is used, 
	see https://en.wikipedia.org/wiki/Private_Use_Areas "
	^ 16r100000 "Private Use Area-B"
]

{ #category : #'handle basic text' }
MicInlineParser >> addATextFrom: start to: end toFinalArray: aFinalArray [
	(start > end or: [end > string size])
		ifTrue: [ " do nothing "]
		ifFalse: [ aFinalArray add: (self newBasicInlineBlockFrom: start to: end ) ]
]

{ #category : #process }
MicInlineParser >> addInlineBlock: indexOfAssociateOpener [
	
	opener := openersStack at: indexOfAssociateOpener.
	closer := delimiterClass index: index.

	opener addInlineBlock: indexOfAssociateOpener to: self

]

{ #category : #process }
MicInlineParser >> addInlineBlock: indexOfAssociateOpener from: startIndex to: endIndex [

	correctSubstring := string copyFrom: startIndex to: endIndex.
	"Delete openers above in stack, considered as unclosed so ignored"
	self popFrom: 1 to: indexOfAssociateOpener.
	"Add found inline block"
	openersStack 
		ifNotEmpty: [ 
			(openersStack size > nestedLevel)
				ifTrue: [ 
					children 
						ifEmpty: [ children add: self newInlineBlock ]
						ifNotEmpty: [ children addLast: self newInlineBlock ] ]
				ifFalse: [ children add: self newInlineBlockWithoutChildren ] ]
		ifEmpty: [ 
			result add: self newInlineBlock.
			children := LinkedList new ].

	nestedLevel := openersStack size
]

{ #category : #process }
MicInlineParser >> addRegularInlineBlock: indexOfAssociateOpener [
	
	self 
		addInlineBlock: indexOfAssociateOpener 
		from: opener index + opener size
		to: closer endIndex
]

{ #category : #accessing }
MicInlineParser >> allDelimiters [
	^ allDelimiters 
]

{ #category : #process }
MicInlineParser >> bothCase [
	| indexOfAssociateOpener |
	indexOfAssociateOpener := self findType: delimiterClass type.
	(openersStack isEmpty or: [ indexOfAssociateOpener = 0 ])
		ifTrue: [ 
			"We consider the delimiter as a new opener or it's the first opener"
			self pushNewOpener ]
		ifFalse: [ 
			"We consider the delimiter as a closer of last opened inline block"
			self addInlineBlock: indexOfAssociateOpener ]
]

{ #category : #process }
MicInlineParser >> closerOnlyCase [
	"IF delimiter found is a closer which can close an opened inline block
	THEN we add the associate inline block
	ELSE we ignore it"
	| indexOfAssociateOpener |
	
	indexOfAssociateOpener := self findAnyType: delimiterClass associatedTypes.
	(indexOfAssociateOpener > 0) 
		ifTrue: [ self addInlineBlock: indexOfAssociateOpener ]
]

{ #category : #process }
MicInlineParser >> delimiterFoundProcess [
	"Case 1: it's a opener only"
	delimiterClass isOpenerOnly ifTrue: [ ^ self openerOnlyCase ].
	"Case 2: it's both opener and closer"
	delimiterClass isBoth ifTrue: [ ^ self bothCase ].
	"Case 3: it's a closer only"
	self closerOnlyCase
]

{ #category : #'instance creation' }
MicInlineParser >> elementBlockClass [
		
	^ MicTextBlock
]

{ #category : #private }
MicInlineParser >> findAnyType: aCollectionOfType [

	^ openersStack findFirst: [ :each | aCollectionOfType includes: each type ]
]

{ #category : #private }
MicInlineParser >> findType: aType [

	^ self findAnyType: { aType }
]

{ #category : #actions }
MicInlineParser >> identifyMarkupFor: aString [

	(self class keyBeginSet includes: aString first) ifFalse: [ ^ 1 ].
	keys do: [ :key |
		(aString beginsWith: key) ifTrue: [ 
			delimiterClass := allDelimiters at: key.
			self delimiterFoundProcess.
			^ key size ] ].
	
	^ 1
]

{ #category : #actions }
MicInlineParser >> indexIncrement [
	^ self indexIncrement: 1
]

{ #category : #actions }
MicInlineParser >> indexIncrement: anInteger [
	index := index + anInteger
]

{ #category : #initialization }
MicInlineParser >> initialize [
	super initialize.
	self initializeDelimiters.
	openersStack := Stack new.
	result := LinkedList new.
	children := LinkedList new.
	nestedLevel := 0.
	index := 1.

]

{ #category : #initialization }
MicInlineParser >> initializeDelimiters [
	allDelimiters := self class allDelimiters.
	keys := allDelimiters keys.
]

{ #category : #'handle basic text' }
MicInlineParser >> insertBasicText: anArrayOfInlineBlocks [
	^ self 
		insertBasicText: anArrayOfInlineBlocks 
			withFinalArray: LinkedList new 
			from: 1 
			to: string size
]

{ #category : #'handle basic text' }
MicInlineParser >> insertBasicText: anArrayOfInlineBlocks from: startIndex to: endIndex [
	^ self 
		insertBasicText: anArrayOfInlineBlocks 
		withFinalArray: LinkedList new 
		from: startIndex 
		to: endIndex
		
]

{ #category : #'handle basic text' }
MicInlineParser >> insertBasicText: anArrayOfInlineBlocks 
	withFinalArray: finalArray 
	from: startIndex 
	to: endIndex [
	
	anArrayOfInlineBlocks ifEmpty: [ ^ finalArray asArray ].
	(anArrayOfInlineBlocks size = 1) ifTrue: [ 
		| element |
		element := anArrayOfInlineBlocks first.
		finalArray ifEmpty: [ self addATextFrom: startIndex 
										to: element start - 1 
										toFinalArray: finalArray ].
		finalArray add: element.
		self addATextFrom: element end + 1 
			to: endIndex 
			toFinalArray: finalArray.
		^ self insertBasicText: Array empty withFinalArray: finalArray from: startIndex to: endIndex
	].
	finalArray ifEmpty: [ 
		self addATextFrom: startIndex 
			to: anArrayOfInlineBlocks first start - 1 
			toFinalArray: finalArray ].
	finalArray add: anArrayOfInlineBlocks first.
	self 
		addATextFrom: anArrayOfInlineBlocks first end + 1 
		to: anArrayOfInlineBlocks second start - 1 
		toFinalArray: finalArray.

	^ self insertBasicText: anArrayOfInlineBlocks allButFirst 
		withFinalArray: finalArray 
		from: startIndex 
		to: endIndex
	
	
	
]

{ #category : #process }
MicInlineParser >> linkOrFigureProcess: indexOfAssociateOpener [
	"IF we find a ( just after and a ) after again
	THEN we add the associate link or figure inline block
	ELSE we ignore it"
	| startIndex endIndex urlCloserIndex |
	
	((string allButFirst: (closer index + closer size - 1)) beginsWith: URLOpenerMarkup)
		ifTrue: [ 
			urlCloserIndex := string indexOfSubCollection: URLCloserMarkup startingAt: closer index ifAbsent: [ 0 ].
			(urlCloserIndex > 0) 
				ifTrue: [ 
					startIndex := opener index + opener size.
					endIndex := closer index - 1.
					correctSubstring := string copyFrom: startIndex to: endIndex.
					correctURL := string copyFrom: (closer index + closer size + URLOpenerMarkup size) to: (urlCloserIndex - 1).
					"Delete openers above in stack, considered as unclosed so ignored"
					self popFrom: 1 to: indexOfAssociateOpener.
					"Add found inline block"
			(openersStack size > 0)
				ifTrue: [ 
					(openersStack size > nestedLevel)
						ifTrue: [ 
							children 
								ifEmpty: [ children add: (self newURLInlineBlockWithCloser: urlCloserIndex) ]
								ifNotEmpty: [ children last add: (self newURLInlineBlockWithCloser: urlCloserIndex) ] ]
						ifFalse: [ children add: (self newURLInlineBlockWithoutChildrenWithCloser: urlCloserIndex) ].
				]
				ifFalse: [ 
					result add: (self newURLInlineBlockWithCloser: urlCloserIndex).
					children := LinkedList new.
				].
			incrementation := urlCloserIndex - index.
			nestedLevel := openersStack size.
				]
				ifFalse: [ "do nothing" ]
		]
		ifFalse: [ "do nothing" ]
]

{ #category : #'instance creation' }
MicInlineParser >> newBasicInlineBlockFrom: stIndex to: eIndex [
	| text |
	
	text := string copyFrom: stIndex to: eIndex.
	^ self elementBlockClass
		from: stIndex
		to: eIndex
		withSubstring: text
		withChildren: #()
			
		"should use copyFrom:to:"
]

{ #category : #'instance creation' }
MicInlineParser >> newInlineBlock [
	| inlineBlockClass |
	
	inlineBlockClass := opener associatedInlineBlock.
	^ inlineBlockClass isEvaluated 
		ifTrue: [ 
			inlineBlockClass
				from: opener index
				to: closer index + closer size - 1
				withSubstring: correctSubstring
				withChildren: children asArray ]
		ifFalse: [  
			self newInlineBlockWithoutChildren ]
]

{ #category : #'instance creation' }
MicInlineParser >> newInlineBlockWithoutChildren [
	^ opener associatedInlineBlock
			from: opener index
			to: closer index + closer size - 1
			withSubstring: correctSubstring
			
]

{ #category : #'instance creation' }
MicInlineParser >> newURLInlineBlockWithCloser: aCloserIndex [
	| inlineBlockClass |
	
	inlineBlockClass := opener associatedInlineBlock.
	^ inlineBlockClass isEvaluated 
		ifTrue: [ 
			inlineBlockClass
				from: opener index
				to: aCloserIndex
				withKind: opener type
				withSubstring: correctSubstring
				withChildren: children asArray
				withURL: correctURL
				withParser: self ]
		ifFalse: [  self newURLInlineBlockWithoutChildren ]
	
]

{ #category : #'instance creation' }
MicInlineParser >> newURLInlineBlockWithoutChildren [
	^ opener associatedInlineBlock
			from: opener index
			to: closer index + closer size - 1
			withKind: opener type
			withSubstring: correctSubstring
			withURL: correctURL
]

{ #category : #'instance creation' }
MicInlineParser >> newURLInlineBlockWithoutChildrenWithCloser: aCloserIndex [
	^ opener associatedInlineBlock
			from: opener index
			to: aCloserIndex
			withKind: opener type
			withSubstring: correctSubstring
			withURL: correctURL
]

{ #category : #process }
MicInlineParser >> openerOnlyCase [
	self pushNewOpener
]

{ #category : #public }
MicInlineParser >> parse: aString [

	aString ifEmpty: [ ^ #() ].
	string := self class escapeEncode: aString.
	^ self read
]

{ #category : #actions }
MicInlineParser >> popFrom: aStartIndex to: anEndIndex [
	aStartIndex to: anEndIndex do: [ :i | openersStack pop ]
	
]

{ #category : #actions }
MicInlineParser >> pushNewOpener [
	delimiterClass associatedInlineBlock isEvaluated 
		ifTrue: [ openersStack push: (delimiterClass index: index)]
		ifFalse: [ self rawRead ]
]

{ #category : #process }
MicInlineParser >> rawRead [
	| open rawType close startIndex endIndex rawContents rawBlock |

	open := delimiterClass index: index.
	rawType := open associatedInlineBlock.
	close := rawType basicNew closingDelimiter.
	startIndex := index.
	endIndex := string findString: close startingAt: startIndex+1.
	endIndex = 0 ifTrue: [ index := index +1. ^self ].
	rawContents := string copyFrom: (startIndex+open size) to: (endIndex-1).
	rawBlock := rawType from: startIndex to: endIndex -1 + close size withSubstring: rawContents.
	openersStack 
		ifEmpty: [ result add: rawBlock. children := LinkedList new ]
		ifNotEmpty: [ children add: rawBlock ].
	index:= endIndex.
]

{ #category : #actions }
MicInlineParser >> read [
	| next |
	
	[ index <= string size ] 
	whileTrue: [
		next := string allButFirst: index-1.
		incrementation := self identifyMarkupFor: next.
		self indexIncrement: incrementation ].
	
	^ self resultProcess
]

{ #category : #process }
MicInlineParser >> resultProcess [
	"At the end, we add all basic text between found inline blocks"
	
	result ifEmpty: [ ^ { self newBasicInlineBlockFrom: 1 to: string size } ].
	result do: [ :each | 
		| startSubstring endSubstring |
		each substring isEmpty 	
			ifTrue: [ startSubstring := endSubstring := 1 ]
			ifFalse: [  	startSubstring := each start + each openingDelimiterSize.
		endSubstring := startSubstring + each substring size - 1 ].
		each children: (self insertBasicText: each children from: startSubstring to: endSubstring) ].
	^ self insertBasicText: result
]

{ #category : #public }
MicInlineParser >> start: aString [
	self deprecated: 'Use parse: instead' transformWith: '`@receiver start: `@arg' -> '`@receiver parse: `@arg'.
	^ self parse: aString
]

{ #category : #accessing }
MicInlineParser >> urlCloserDelimiterClass [
	^ MicURLCloserDelimiter
]

{ #category : #accessing }
MicInlineParser >> urlOpenerDelimiterClass [
	^ MicURLOpenerDelimiter 
]
