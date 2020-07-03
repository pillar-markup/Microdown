Class {
	#name : #MicInlineSplitter,
	#superclass : #Object,
	#instVars : [
		'openersStack',
		'result',
		'allDelimiters',
		'index',
		'string',
		'incrementation',
		'delimiterSubclassFound',
		'children',
		'nestedLevel',
		'opener',
		'closer',
		'correctSubstring',
		'correctURL'
	],
	#category : #'Microdown-Parser'
}

{ #category : #'class factory' }
MicInlineSplitter >> abstractDelimiterClass [
	^ MicAbstractDelimiter
]

{ #category : #adding }
MicInlineSplitter >> addABasicTextFrom: start to: end toFinalArray: aFinalArray [
	(start = end) 
		ifTrue: [ " do nothing "]
		ifFalse: [ aFinalArray add: (self newBasicInlineBlockFrom: start to: end ) ]
]

{ #category : #adding }
MicInlineSplitter >> addInlineBlock [
	"The found closer should match with the last opener, found at the top of openersStack e.g. at index 1"
	self addInlineBlock: 1
]

{ #category : #adding }
MicInlineSplitter >> addInlineBlock: indexOfAssociateOpener [
	| startIndex endIndex |
	opener := openersStack at: indexOfAssociateOpener.
	closer := delimiterSubclassFound index: index.
	"Check the linkName or figure case"
	(#(#linkName #figure) includes: opener type ) 
		ifTrue: [ self linkOrFigureProcess: indexOfAssociateOpener ]
		ifFalse: [ 
			startIndex := opener index + opener size.
			endIndex := closer index - 1.
			correctSubstring := string collect: [ :c | c ] from: startIndex to: endIndex.
			"Add found inline block"
			(openersStack size > 1)
				ifTrue: [ 
					(openersStack size - 1 > nestedLevel)
						ifTrue: [ 
							children 
								ifEmpty: [ children add: self newInlineBlock ]
								ifNotEmpty: [ children last add: self newInlineBlock ] ]
						ifFalse: [ children add: self newInlineBlockWithoutChildren ].
				]
				ifFalse: [ 
					result add: self newInlineBlock.
					children := LinkedList new.
				].
			nestedLevel := openersStack size - 1.
			"Delete openers above in stack, considered as unclosed so ignored"
			self popFrom: 1 to: indexOfAssociateOpener
		]
]

{ #category : #'class factory' }
MicInlineSplitter >> allDelimiters [
	^ allDelimiters
]

{ #category : #process }
MicInlineSplitter >> bothCase [
	openersStack 
		ifEmpty: [ 
			"It's the first opener"
			self pushNewOpener
		]
		ifNotEmpty: [ 
			(openersStack top type = delimiterSubclassFound type)
			ifTrue: [ 
				"We consider the delimiter as a closer of last opened inline block"
				self addInlineBlock
			 ]
			ifFalse: [ 
				"We consider the delimiter as a new opener"
				self pushNewOpener
			 ]
		]
	
]

{ #category : #process }
MicInlineSplitter >> closerOnlyCase [
	"IF delimiter found is a closer which can close an opened inline block
	THEN we add the associate inline block
	ELSE we ignore it"
	| indexOfAssociateOpener typesToFind|
	typesToFind := (#(#linkName #figure) includes: delimiterSubclassFound type ) 
		ifTrue: [#(#linkName #figure)] 
		ifFalse: [ Array braceWith: delimiterSubclassFound type ].
	indexOfAssociateOpener := openersStack findFirst: [ :opener | typesToFind includes: opener type ].
	(indexOfAssociateOpener > 0) ifTrue: [ self addInlineBlock: indexOfAssociateOpener ]
]

{ #category : #process }
MicInlineSplitter >> delimiterFoundProcess [
	"Case 0: it's an escape character"
	(delimiterSubclassFound type = #escape) 
		ifTrue: [ incrementation := incrementation + 1 ]
		ifFalse: [ 
			"Case 1: it's a opener only"
			(delimiterSubclassFound isOpenerOnly) 
				ifTrue: [ self openerOnlyCase ]
				ifFalse: [ 
					"Case 2: it's both opener and closer"
					(delimiterSubclassFound isBoth) 
						ifTrue: [ self bothCase ]
						ifFalse: [ 
							"Case 3: it's a closer only"
							self closerOnlyCase
						]
				]
		]
			
			

]

{ #category : #accessing }
MicInlineSplitter >> indexIncrement [
	^ self indexIncrement: 1
]

{ #category : #accessing }
MicInlineSplitter >> indexIncrement: anInteger [
	index := index + anInteger
]

{ #category : #'class factory' }
MicInlineSplitter >> initialize [
	super initialize.
	self initializeDelimiters.
	openersStack := Stack new.
	result := LinkedList new.
	children := LinkedList new.
	nestedLevel := 0.
	index := 1
]

{ #category : #'class factory' }
MicInlineSplitter >> initializeDelimiters [
	allDelimiters := Dictionary new.
	self abstractDelimiterClass subclasses 
		select: [ :subclass | subclass isActive ]
		thenDo: [ :subclass | allDelimiters 
										at: subclass markup 
										put: subclass ]
]

{ #category : #'as yet unclassified' }
MicInlineSplitter >> insertBasicText: anArrayOfInlineBlocks [
	^ self insertBasicText: anArrayOfInlineBlocks withFinalArray: LinkedList new
]

{ #category : #'as yet unclassified' }
MicInlineSplitter >> insertBasicText: anArrayOfInlineBlocks withFinalArray: finalArray [
	anArrayOfInlineBlocks ifEmpty: [ ^ finalArray ].
	(anArrayOfInlineBlocks size = 1) ifTrue: [ 
		| element |
		element := anArrayOfInlineBlocks first.
		finalArray ifEmpty: [ self addABasicTextFrom: 1 to: element start - 1 toFinalArray: finalArray ].
		finalArray add: element.
		self addABasicTextFrom: element end + 1 to: string size toFinalArray: finalArray.
		^ self insertBasicText: Array empty withFinalArray: finalArray
	].
	finalArray ifEmpty: [ self addABasicTextFrom: 1 to: anArrayOfInlineBlocks first start - 1toFinalArray: finalArray ].
	finalArray add: anArrayOfInlineBlocks first.
	self addABasicTextFrom: anArrayOfInlineBlocks first end + 1 to: anArrayOfInlineBlocks second start - 1 toFinalArray: finalArray.
	^ self insertBasicText: anArrayOfInlineBlocks allButFirst withFinalArray: finalArray
	
	
	
]

{ #category : #process }
MicInlineSplitter >> linkOrFigureProcess: indexOfAssociateOpener [
	"IF we find a ( just after and a ) after again
	THEN we add the associate link or figure inline block
	ELSE we ignore it"
	| startIndex endIndex urlCloserIndex |
	((string allButFirst: (closer index + closer size - 1)) beginsWith: self urlOpenerDelimiterClass markup)
		ifTrue: [ 
			urlCloserIndex := string indexOfSubCollection: self urlCloserDelimiterClass markup startingAt: closer index ifAbsent: [ 0 ].
			(urlCloserIndex > 0) 
				ifTrue: [ 
					startIndex := opener index + opener size.
					endIndex := closer index - 1.
					correctSubstring := string collect: [ :c | c ] from: startIndex to: endIndex.
					correctURL := string collect: [ :c | c ] from: (closer index + closer size + self urlOpenerDelimiterClass size) to: (urlCloserIndex - 1).
					"Add found inline block"
					result add: 
						(opener associatedInlineBlock
							from: opener index
							to: urlCloserIndex 
							withKind: opener type
							withSubstring: correctSubstring
							withURL: correctURL).
				"Delete openers above in stack, considered as unclosed so ignored"
				self popFrom: 1 to: indexOfAssociateOpener.
				incrementation := urlCloserIndex - index
				]
				ifFalse: [ "do nothing" ]
		]
		ifFalse: [ "do nothing" ]
]

{ #category : #'instance creation' }
MicInlineSplitter >> newBasicInlineBlockFrom: stIndex to: eIndex [
	^ (MicBasicInlineBlock
			from: stIndex
			to: eIndex
			withKind: #basic
			withSubstring: (string collect: [ :c | c ] from: stIndex to: eIndex)
			withChildren: Array empty)
]

{ #category : #'instance creation' }
MicInlineSplitter >> newInlineBlock [
	| inlineBlockClass |
	inlineBlockClass := opener associatedInlineBlock.
	(inlineBlockClass isEvaluated) 
		ifTrue: [ 
			^ inlineBlockClass
				from: opener index
				to: closer index + closer size - 1
				withKind: opener type
				withSubstring: correctSubstring
				withChildren: children asArray
		 ]
		ifFalse: [ ^ self newInlineBlockWithoutChildren ]
	
]

{ #category : #'instance creation' }
MicInlineSplitter >> newInlineBlockWithoutChildren [
	^ opener associatedInlineBlock
			from: opener index
			to: closer index + closer size - 1
			withKind: opener type
			withSubstring: correctSubstring
]

{ #category : #process }
MicInlineSplitter >> openerOnlyCase [
	self pushNewOpener
]

{ #category : #process }
MicInlineSplitter >> popFrom: aStartIndex to: anEndIndex [
	aStartIndex to: anEndIndex do: [ :i | openersStack pop ]
	
]

{ #category : #process }
MicInlineSplitter >> pushNewOpener [
	openersStack push: (delimiterSubclassFound index: index)
]

{ #category : #'meta-object-protocol' }
MicInlineSplitter >> read: aString [
	incrementation := 1.
	aString ifEmpty: [ ^ self resultProcess ].
	allDelimiters keys do: [ :key | 
 		(aString beginsWith: key) 
			ifTrue: [ 
				incrementation := key size.
				delimiterSubclassFound := (allDelimiters at: key).
				self delimiterFoundProcess
			].
	].
	self indexIncrement: incrementation.
	^ self read: (aString allButFirst: incrementation)
	
]

{ #category : #process }
MicInlineSplitter >> resultProcess [
	"At the end, we add all basic text between found inline blocks"
	result ifEmpty: [ ^ (self newBasicInlineBlockFrom: 1 to: string size) asArray ].
	result do: [ :e | e children: (self insertBasicText: e children ) ].
	^ self insertBasicText: result
]

{ #category : #accessing }
MicInlineSplitter >> start: aString [
	aString ifEmpty: [ ^ Array empty ].
	string := aString.
	^ self read: aString
]

{ #category : #'class references' }
MicInlineSplitter >> urlCloserDelimiterClass [
	^ MicURLCloserDelimiter
]

{ #category : #'class references' }
MicInlineSplitter >> urlOpenerDelimiterClass [
	^ MicURLOpenerDelimiter 
]
