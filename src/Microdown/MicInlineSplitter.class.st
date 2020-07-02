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
		'delimiterSubclassFound'
	],
	#category : #'Microdown-Parser'
}

{ #category : #'class factory' }
MicInlineSplitter >> abstractDelimiterClass [
	^ MicAbstractDelimiter
]

{ #category : #adding }
MicInlineSplitter >> addInlineBlock [
	"The found closer should match with the last opener, found at the top of openersStack e.g. at index 1"
	self addInlineBlock: 1
]

{ #category : #adding }
MicInlineSplitter >> addInlineBlock: indexOfAssociateOpener [
	| opener closer startIndex endIndex correctSubstring |
	opener := openersStack at: indexOfAssociateOpener.
	closer := delimiterSubclassFound index: index.
	"Check the linkName or figure case"
	(#(#linkName #figure) includes: opener type ) 
		ifTrue: [ self linkOrFigureProcess: indexOfAssociateOpener withOpener: opener withCloser: closer]
		ifFalse: [ 
			startIndex := opener index + opener size.
			endIndex := closer index - 1.
			correctSubstring := string collect: [ :c | c ] from: startIndex to: endIndex.
			"Add found inline block"
			result add: 
				(opener associatedInlineBlock
					from: opener index
					to: closer index + closer size - 1
					withKind: opener type
					withSubstring: correctSubstring).
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

{ #category : #process }
MicInlineSplitter >> linkOrFigureProcess: indexOfAssociateOpener withOpener: opener withCloser: closer [
	"IF we find a ( just after and a ) after again
	THEN we add the associate link or figure inline block
	ELSE we ignore it"
	| startIndex endIndex urlCloserIndex correctSubstring correctURL |
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
					self halt.
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
	aString ifEmpty: [ "^ self resultProcess" ^ result ].
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

{ #category : #accessing }
MicInlineSplitter >> start: aString [
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
