"
I am a parser for paragraphs with substructure in Microdown.

My only external method is `parse:`.
"
Class {
	#name : #MicInlineParser2,
	#superclass : #Object,
	#pools : [
		'MicMicrodownSharedPool'
	],
	#category : #'Microdown-InlineParser'
}

{ #category : #parsing }
MicInlineParser2 class >> parse: string [
	^ self new parse: string
]

{ #category : #'block creation' }
MicInlineParser2 >> createInlineBlock: token inStream: aReadStream [ 
	| blockClass newBlock|
	blockClass := token delimiter blockClass.
	newBlock := blockClass parse: token stream: aReadStream for: self.
	^ newBlock 
	
	
]

{ #category : #'block creation' }
MicInlineParser2 >> createTextBlock: token [
	^ MicTextBlock2 new substring: token
]

{ #category : #'private parsing' }
MicInlineParser2 >> joinTextNodesOf: children [
	"children might have several text blocks following each other - join them and remove empty Text blocks"
	| outStream bufferText  |
	outStream := WriteStream on: OrderedCollection new.
	bufferText := nil.
	children do: [ :child |
		child class = MicTextBlock2
			ifTrue: [ bufferText 
				ifNil: [ bufferText := child ]
				ifNotNil: [ bufferText substring: (bufferText substring , child substring) ] ]
			ifFalse: [ bufferText
				ifNil: [ outStream nextPut: child ]
				ifNotNil: [ 
					bufferText substring ifNotEmpty: [outStream nextPut: bufferText].
					outStream nextPut: child. bufferText := nil ]
				 ]
		 ].
	(bufferText isNotNil and: [ bufferText substring isNotEmpty  ]) 
		ifTrue: [ outStream nextPut: bufferText ].
	 ^ outStream contents asArray
]

{ #category : #parsing }
MicInlineParser2 >> parse: aString [
	"I return an array of inline blocks"
	| tokenStream |
	tokenStream := MicInlineTokenStream on: aString.
	^ (self parseChildrenIn: tokenStream) asArray 
]

{ #category : #'private parsing' }
MicInlineParser2 >> parseChildrenIn: tokenStream [
	"return an array of blocks from parsing tokenStream"
	| children child |
	children := OrderedCollection new.
	[ tokenStream atEnd ]
		whileFalse: [ | token |
			token := tokenStream next.
			child := token delimiter isOpener 
				ifTrue: [self createInlineBlock: token inStream: tokenStream]
				ifFalse: [ self createTextBlock: token substring].
			children add: child.
		].
	^ self joinTextNodesOf: children
]

{ #category : #'private parsing' }
MicInlineParser2 >> parseEvaluatedBlock: blockType token: token stream: tokenStream [
	| skipRes |
	skipRes := (self skipTo: token delimiter closer inStream: tokenStream).
	skipRes ifNil: [ ^ self createTextBlock: token substring].
	tokenStream next. "skip closer"
	^ blockType new
		children: (self parseChildrenIn: skipRes second );
		closeMe
]

{ #category : #'private parsing' }
MicInlineParser2 >> parseNameUrlBlock: blockType from: aTokenStream token: token [
	| skipRes children urlToken|
	skipRes := (self skipToUrlStartInStream: aTokenStream).
	skipRes ifNil: [ ^ self createTextBlock: token substring].
	children := self parseChildrenIn: skipRes second.
	urlToken := aTokenStream next.
	^ blockType new
		children: children;
		url: urlToken undelimitedSubstring;
		closeMe.
		
	

]

{ #category : #'private parsing' }
MicInlineParser2 >> parseNonEvaluatedBlock: blockClass token: token stream: aTokenStream [
	^ blockClass new
		substring: token undelimitedSubstring;
		closeMe
]

{ #category : #'private parsing' }
MicInlineParser2 >> skipTo: closer inStream: tokenStream [
	"skip tokenStream to closer, ignore closers in non-evaluated. if we find it return the accumulates text and a subtokenstream to read it from"
	| startPos substringStream |
	startPos := tokenStream position.
	substringStream := WriteStream on: ''.
	[ tokenStream atEnd]
		whileFalse: [ | token|
			token := tokenStream peek.
			token delimiter markup = closer ifTrue: [ 
				^ { substringStream contents.  
					 ReadStream on: tokenStream contents from: startPos + 1 to: tokenStream position} ].
			substringStream nextPutAll: token substring.
			tokenStream next.
			].
	tokenStream position: startPos.
	^ nil
	
]

{ #category : #'private parsing' }
MicInlineParser2 >> skipToUrlStartInStream: tokenStream [
	"Skip to my UrlStart. Notice, I might find a nested url construct"
	| startPos substringStream nestingLevel|
	startPos := tokenStream position.
	substringStream := WriteStream on: ''.
	nestingLevel := 0.
	[ tokenStream atEnd]
		whileFalse: [ | token|
			token := tokenStream peek.
			({ LinkNameOpenerMarkup. FigureNameOpenerMarkup  } includes: token delimiter markup)
				ifTrue: [ nestingLevel := nestingLevel + 1 ].
			token delimiter markup = NameCloserUrlOpener
				ifTrue: [ nestingLevel = 0
					ifFalse: [ nestingLevel := nestingLevel -1 ]
			 		ifTrue: [ ^ { substringStream contents.  
						 ReadStream on: tokenStream contents from: startPos + 1 to: tokenStream position} ]].
			substringStream nextPutAll: token substring.
			tokenStream next.
			].
	tokenStream position: startPos.
	^ nil
	
]
