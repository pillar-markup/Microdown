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
			| indexOfFirstClosingBracket |
			indexOfFirstClosingBracket := line indexOf: $].
			label := indexOfFirstClosingBracket = 0
				ifTrue: [ parent children removeLast. ^ self createMicBlockQuoteBlock: line ]
				ifFalse: [line copyFrom: self lineMarkup size + 1 to: indexOfFirstClosingBracket - 1.
					].
				label := label trim]
		ifNotNil: [ | treatedLine |
	treatedLine := self extractLine: line.
	body := body
		ifNil: [ treatedLine ]
		ifNotNil: [ body , String cr , treatedLine ]]
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

{ #category : 'as yet unclassified' }
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
