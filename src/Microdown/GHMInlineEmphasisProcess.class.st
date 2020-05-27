"
I am a recursive algorithm to find different kinds of emphasis i.e. inline formats in a text line.

To proceed, call my constructor which start automatically the emphasis process.

I need:
- stack = stack of delimiters determined by the inline splitter algorithm
- string = the initial text line

At the end, I return an array of GHMInlineBlock which represents the initial text line.
"
Class {
	#name : #GHMInlineEmphasisProcess,
	#superclass : #Object,
	#instVars : [
		'stack',
		'result',
		'string',
		'start',
		'end',
		'startIndex',
		'endIndex',
		'firstOpener',
		'firstOpenerIndex',
		'associateCloser',
		'associateCloserIndex',
		'children'
	],
	#category : #'Microdown-Model'
}

{ #category : #'new & start' }
GHMInlineEmphasisProcess class >> startWithStack: aStack withResult: aResultArray withStart: aStartSubstringIndex withEnd: anEndSubstringIndex withString: aString [
	| newProcess |
	newProcess := self new stack: aStack; result: aResultArray; start: aStartSubstringIndex; end: anEndSubstringIndex; string: aString; yourself.
	^ newProcess emphasisProcess.
]

{ #category : #'new & start' }
GHMInlineEmphasisProcess class >> startWithStack: aStack withString: aString [
	^ self startWithStack: aStack withResult: LinkedList new withStart: 1 withEnd: aString size withString: aString
]

{ #category : #actions }
GHMInlineEmphasisProcess >> addBasicTextBlocks [
	| string_array |
	string_array := string asArray.
	string_array doWithIndex: [ :each :i | (i between: start and: end) ifFalse: [ string_array at: i put: nil ]  ].
	result do: [ :anInlineBlock | anInlineBlock start to: anInlineBlock end do: [ :k | string_array at: k put: nil ] ].
	string_array splitOn: nil indicesDo: [ :startIndex :endIndex | 
		| substring |
		substring := string collect: [ :c | c ] from: startIndex to: endIndex.
		(substring isEmpty) ifFalse: [ 
			result add: 
				(GHMInlineBlock_v2
					from: startIndex
					to: endIndex
					withKind: #basic
					withSubstring: substring
					withChildren: Array empty)
			 ]
	].
	^ (result sort: [ :block :block2 | block start < block2 start ]) asArray
]

{ #category : #actions }
GHMInlineEmphasisProcess >> childrenInNestedCase [
	^ self class 
		startWithStack: (stack withIndexSelect: [:value :i | i between: firstOpenerIndex + 1 and: associateCloserIndex - 1 ]) 
		withResult: LinkedList new 
		withStart: startIndex 
		withEnd: endIndex 
		withString: string
]

{ #category : #'global process' }
GHMInlineEmphasisProcess >> emphasisProcess [
	| correctSubstring |
	"1. search first opener. If not found, exit case."
	firstOpenerIndex := stack findFirst: [ :delimiter | delimiter isOpener ].
	firstOpenerIndex isZero 
		ifTrue: [ ^ self addBasicTextBlocks ].
	firstOpener := stack at: firstOpenerIndex.
	"Case link or figure"
	(#(#linkName #figure) includes: firstOpener type ) ifTrue: [ ^ self linkOrFigureProcess ].
	"2. search first closer with same type, just after. If not found, pair isn't complete so we skip it and keep going."	
	associateCloserIndex := (stack allButFirst: firstOpenerIndex) findFirst: [ :delimiter | delimiter isCloser and: delimiter type = firstOpener type].
	associateCloserIndex isZero 
		ifTrue: [ 
			self stackWithoutFirstOpenerIndex.
			^ self emphasisProcess ].
	"3. translate index in delimiters stack"
	associateCloserIndex := associateCloserIndex + firstOpenerIndex.
	associateCloser := stack at: associateCloserIndex.	
	"4. set substring in global string concerned by found emphasis"
	startIndex := firstOpener index + firstOpener size.
	endIndex := associateCloser index - 1.
	correctSubstring := string collect: [ :c | c ] from: startIndex to: endIndex.
	"5. are we in a nested emphasis case?"
	self processNestedCase.
	"6. add in result_array"
	result add: 
		(self inlineBlockClass
			from: firstOpener index
			to: associateCloser index + associateCloser size - 1
			withKind: firstOpener type
			withSubstring: correctSubstring
			withChildren: children).
	"7. keep going"
	stack := (stack withIndexSelect: [:value :i | (i between: firstOpenerIndex and: associateCloserIndex) not ]).
	^ self emphasisProcess
	
		
]

{ #category : #accessing }
GHMInlineEmphasisProcess >> end: anEndIndex [
	end := anEndIndex 
]

{ #category : #actions }
GHMInlineEmphasisProcess >> inlineBlockClass [
	^ GHMInlineBlock_v2
]

{ #category : #'global process' }
GHMInlineEmphasisProcess >> linkOrFigureProcess [
	| urlCloserStringIndex correctSubstring correctURL |
	"1. search the linkname closer delimiter"
	associateCloserIndex := (stack allButFirst: firstOpenerIndex) findFirst: [ :delimiter | delimiter isCloser and: delimiter type = #linkName].
	associateCloserIndex isZero 
		ifTrue: [ 
			self stackWithoutFirstOpenerIndex.
			^ self emphasisProcess ].
	"2. translate index in delimiters stack"
	associateCloserIndex := associateCloserIndex + firstOpenerIndex.
	associateCloser := stack at: associateCloserIndex.
	"3. check we find a ( just after closer in string"
	((string allButFirst: associateCloser index + associateCloser size - 1) beginsWith: self urlOpenerDelimiterClass markup) 
		ifFalse: [ self stackWithoutFirstOpenerIndex. ^ self emphasisProcess ].
	"4. search url closer"
	urlCloserStringIndex := string indexOfSubCollection: self urlCloserDelimiterClass markup startingAt: associateCloser index 
		ifAbsent: [ self stackWithoutFirstOpenerIndex. ^ self emphasisProcess ].
	"5. link or figure found"
	startIndex := firstOpener index + firstOpener size.
	endIndex := associateCloser index - 1.
	correctSubstring := string collect: [ :c | c ] from: startIndex to: endIndex.
	correctURL := string collect: [ :c | c ] from: (associateCloser index + associateCloser size + self urlOpenerDelimiterClass size) to: (urlCloserStringIndex - 1).
	"6. define children"
	self processNestedCase.
	result add: 
		(GHMInlineBlockWithUrl_v2
			from: firstOpener index
			to: urlCloserStringIndex 
			withKind: firstOpener type
			withSubstring: correctSubstring
			withChildren: children
			withURL: correctURL).
	"7. keep going"
	stack := (stack withIndexSelect: [:value :i | (i between: firstOpenerIndex and: associateCloserIndex) not ]).
	^ self emphasisProcess
	
	
	
	
]

{ #category : #actions }
GHMInlineEmphasisProcess >> processNestedCase [
	(associateCloserIndex = (firstOpenerIndex + 1))
		ifTrue: [ children := Array empty ]
		ifFalse: [ children := self childrenInNestedCase ].
]

{ #category : #accessing }
GHMInlineEmphasisProcess >> result: anArray [
	result := anArray
]

{ #category : #accessing }
GHMInlineEmphasisProcess >> stack: aStack [
	stack := aStack
]

{ #category : #actions }
GHMInlineEmphasisProcess >> stackWithoutFirstOpenerIndex [
	stack := (stack withIndexSelect: [ :value :i | (i = firstOpenerIndex) not ])
]

{ #category : #accessing }
GHMInlineEmphasisProcess >> start: aStartIndex [
	start := aStartIndex
]

{ #category : #accessing }
GHMInlineEmphasisProcess >> string: aString [
	string := aString
]

{ #category : #'class references' }
GHMInlineEmphasisProcess >> urlCloserDelimiterClass [
	^ GHMURLCloserDelimiter
]

{ #category : #'class references' }
GHMInlineEmphasisProcess >> urlOpenerDelimiterClass [
	^ GHMURLOpenerDelimiter 
]
