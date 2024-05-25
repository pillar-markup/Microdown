"
I am a parser for paragraphs with substructure in Microdown.

My only external method is `parse:`.
"
Class {
	#name : 'MicInlineParser',
	#superclass : 'Object',
	#pools : [
		'MicMicrodownSharedPool'
	],
	#category : 'Microdown-InlineParser',
	#package : 'Microdown',
	#tag : 'InlineParser'
}

{ #category : 'parsing' }
MicInlineParser class >> parse: string [
	^ self new parse: string
]

{ #category : 'block creation' }
MicInlineParser >> createInlineBlock: token inStream: aReadStream [ 
	| blockClass newBlock |
	blockClass := token delimiter blockClass.
	newBlock := blockClass parse: token stream: aReadStream for: self.
	^ newBlock 
	
	
]

{ #category : 'block creation' }
MicInlineParser >> createTextBlock: token [

	^ MicTextBlock new bodyString: token
]

{ #category : 'private parsing' }
MicInlineParser >> joinTextNodesOf: children [
	"children might have several text blocks following each other - join them and remove empty Text blocks"

	| outStream bufferText |
	outStream := WriteStream on: OrderedCollection new.
	bufferText := nil.
	children do: [ :child |
		child class = MicTextBlock
			ifTrue: [
				bufferText
					ifNil: [ bufferText := child ]
					ifNotNil: [
					bufferText bodyString: bufferText bodyString , child bodyString ] ]
			ifFalse: [
				bufferText ifNil: [ outStream nextPut: child ] ifNotNil: [
					bufferText bodyString ifNotEmpty: [
						outStream nextPut: bufferText ].
					outStream nextPut: child.
					bufferText := nil ] ] ].
	(bufferText isNotNil and: [ bufferText bodyString isNotEmpty ])
		ifTrue: [ outStream nextPut: bufferText ].
	^ outStream contents asArray
]

{ #category : 'parsing' }
MicInlineParser >> parse: aString [
	"I return an array of inline blocks"
	| tokenStream |
	tokenStream := MicInlineTokenStream on: aString.
	^ (self parseChildrenIn: tokenStream) asArray 
]

{ #category : 'private parsing' }
MicInlineParser >> parseChildrenIn: tokenStream [
	"return an array of blocks from parsing tokenStream"
	| children child |
	children := OrderedCollection new.
	[ tokenStream atEnd ]
		whileFalse: [ | token |
			token := tokenStream next.
			child := token delimiter isOpener 
				ifTrue: [self createInlineBlock: token inStream: tokenStream]
				ifFalse: [ self createTextBlock: token string].
			children add: child.
		].
	^ self joinTextNodesOf: children
]

{ #category : 'private parsing' }
MicInlineParser >> parseEvaluatedBlock: blockType token: token stream: tokenStream [
	| skipRes |
	skipRes := (self skipTo: token delimiter closer inStream: tokenStream).
	skipRes ifNil: [ ^ self createTextBlock: token string].
	tokenStream next. "skip closer"
	^ blockType new
		children: (self parseChildrenIn: skipRes second );
		closeMe
]

{ #category : 'private parsing' }
MicInlineParser >> parseNameUrlBlock: blockType from: aTokenStream token: token [

	| skipRes children urlToken caption rest toCaption newBlock |
	self halt.
	skipRes := self skipToUrlStartInStream: aTokenStream.
	skipRes ifNil: [ ^ self createTextBlock: token string ].

	"We look if we have a % in the caption to remove the rest from the caption
	and place them as arguments"
	caption := OrderedCollection new. 
	rest := OrderedCollection new. 
	toCaption := true. 
	skipRes second contents do: [:each | 		
			each delimiter markup = '%'
				ifTrue: [toCaption := false].
			toCaption ifTrue: [ caption add: each ]
				ifFalse: [ rest add: each ] ].
	self halt.
	children := self parseChildrenIn: caption readStream.
	self halt.
	urlToken := aTokenStream next.
	newBlock := blockType new
		  children: children;
		  url: urlToken undelimitedSubstring.
	rest 
		ifNotEmpty: [ newBlock	arguments: (MicArgumentList withString: rest second string )]
		ifEmpty: [ 
			"We mark it to nil to indicate to the closeMe that there were no arguments in the caption. In the future when all the books and more will not use arguments in the url then we will remove this hack. For now it enables backward compatibility while giving precedence to caption arguments."
			newBlock arguments: nil ].
	newBlock closeMe.
	^ newBlock
]

{ #category : 'private parsing' }
MicInlineParser >> parseNonEvaluatedBlock: blockClass token: token stream: aTokenStream [

	^ blockClass new
		  bodyString: token undelimitedSubstring;
		  closeMe
]

{ #category : 'private parsing' }
MicInlineParser >> skipTo: closer inStream: tokenStream [
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
			substringStream nextPutAll: token string.
			tokenStream next.
			].
	tokenStream position: startPos.
	^ nil
	
]

{ #category : 'private parsing' }
MicInlineParser >> skipToUrlStartInStream: tokenStream [
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
			substringStream nextPutAll: token string.
			tokenStream next.
			].
	tokenStream position: startPos.
	^ nil
	
]
