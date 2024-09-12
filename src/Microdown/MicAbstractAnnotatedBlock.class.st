Class {
	#name : 'MicAbstractAnnotatedBlock',
	#superclass : 'MicAbstractBlock',
	#instVars : [
		'label',
		'isClosed',
		'body'
	],
	#category : 'Microdown-Model',
	#package : 'Microdown',
	#tag : 'Model'
}

{ #category : 'public' }
MicAbstractAnnotatedBlock >> addLineAndReturnNextNode: line [
	"line is assumed to be of the form '!!label some text'"
	
	isClosed
		ifTrue: [ ^ self ].
	label 
		ifNil: [ 
			"this part is to be backward compatible and we will remove it in future releases"
			(line beginsWith: AnnotatedParagraphBackwardCompatibleMarkup)
				ifTrue: [ ^ self handleDoubleBangStartingLine: line ] 
				ifFalse: [  
					| indexOfFirstClosingBracket |
					indexOfFirstClosingBracket := line indexOf: $].
					label := indexOfFirstClosingBracket = 0
						ifTrue: [ 
							parent children removeLast. 
							^ self createMicBlockQuoteBlock: line ]
						ifFalse: [
							line 
								copyFrom: self lineMarkup size + 1 
								to: indexOfFirstClosingBracket - 1 ].
				label := label trim ] ]
			
		ifNotNil: [ 
			| treatedLine |
			treatedLine := self extractLine: line.
			body := body
				ifNil: [ treatedLine ]
				ifNotNil: [ body , String cr , treatedLine ] ]
]

{ #category : 'accessing' }
MicAbstractAnnotatedBlock >> body [
	^ body
]

{ #category : 'testing' }
MicAbstractAnnotatedBlock >> canConsumeLine: line [
	"return if this block can consume line"

	"it can be dangerous but let us try"
	^ line isNotEmpty 
]

{ #category : 'creating classes' }
MicAbstractAnnotatedBlock >> createMicBlockQuoteBlock: line [

^ MicBlockQuoteBlock new
		setParser: parser;
		parent: parent;
		addLineAndReturnNextNode: line 


]

{ #category : 'actions' }
MicAbstractAnnotatedBlock >> extractLine: line [
	^ (line copyFrom: 2 to: line size) trim
]

{ #category : 'public' }
MicAbstractAnnotatedBlock >> handleDoubleBangStartingLine: line [
	"line should be in format 
	!!label text
	"
	| indexOfFirstSpace |
	indexOfFirstSpace := line indexOf: Character space.
	label := indexOfFirstSpace = 0
		ifTrue: [ '' ]
		ifFalse: [line copyFrom: '!!' size + 1 to: indexOfFirstSpace - 1.].
	body := (line copyFrom: indexOfFirstSpace + 1 to: line size) trim.
]

{ #category : 'initialization' }
MicAbstractAnnotatedBlock >> initialize [

	super initialize.
	isClosed := false.
]

{ #category : 'accessing' }
MicAbstractAnnotatedBlock >> label [
	^ label
]

{ #category : 'testing' }
MicAbstractAnnotatedBlock >> lineMarkup [

	^ self subclassResponsibility
]
