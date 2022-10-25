Class {
	#name : #MicRealDumper,
	#superclass : #MicrodownVisitor,
	#instVars : [
		'stream'
	],
	#category : #'Microdown-PrettyPrinter'
}

{ #category : #accessing }
MicRealDumper >> contents [ 
	^ stream contents
]

{ #category : #utilities }
MicRealDumper >> emitClassNameOf: aMicElement [

	stream nextPutAll: aMicElement class asString
]

{ #category : #'visit - section' }
MicRealDumper >> emitList: aList [

	stream nextPut: $(.
	self emitClassNameOf: aList.
	stream space.
	stream
		nextPutAll: 'new';
		space.
	stream nextPutAll: 'children: { '.
	aList children
		do: [ :each | each accept: self ]
		separatedBy: [ stream nextPutAll: ' . ' ].
	stream nextPutAll: ' }; yourself)'
]

{ #category : #build }
MicRealDumper >> emitParameters: aCodeBlock [

	stream nextPutAll: 'arguments: { '.
	self parametersPrint: aCodeBlock arguments withoutDefaultValue.
	stream nextPutAll: ' } asDictionary ; '
]

{ #category : #initialization }
MicRealDumper >> initialize [

	super initialize.
	stream := MicOutputStream new setStream: (WriteStream on: (String new: 1000)).
]

{ #category : #build }
MicRealDumper >> parametersPrint: aDictionnary [

	| lastKey |
	lastKey := aDictionnary keys last.

	aDictionnary keysAndValuesDo: [ :k :v | 
		stream
			nextPut: $#;
			nextPutAll: k;
			nextPutAll: ' ->'.
			v class = Array
				ifTrue: [ 
					stream nextPutAll: ''''.
					v do: [ :each | stream nextPutAll: each text ].
					stream nextPutAll: '''' ]
				ifFalse: [ stream nextPutAll: v asString ].
		k = lastKey ifFalse: [ stream nextPutAll: ' . ' ] ]
]

{ #category : #'visit - format' }
MicRealDumper >> visit: aMicElement [

	aMicElement accept: self.
	stream contents
]

{ #category : #'visit - section' }
MicRealDumper >> visitAnchor: aMicAnchor [

	stream nextPut: $(.
	self emitClassNameOf: aMicAnchor.
	stream space.
	stream
		nextPutAll: 'new';
		space.
	stream nextPutAll: 'textElement: '.
	stream
		nextPutAll: '" ';
		nextPutAll: aMicAnchor label;
		nextPutAll: ' "'.
	stream nextPut: $)
]

{ #category : #'visit - format' }
MicRealDumper >> visitAttributedText: aMicBold [

	stream nextPut: $(.
	self emitClassNameOf: aMicBold.
	stream space.
	stream
		nextPutAll: 'new';
		space.
	stream nextPutAll: 'textElements: '.
	stream nextPutAll: '{'.
	aMicBold children do: [ :each | each accept: self ] separatedBy: [ stream nextPutAll: ' . '].
	stream nextPutAll: '}'.
	stream nextPut: $)
]

{ #category : #'visit - format' }
MicRealDumper >> visitBold: aMicItalic [

	self visitAttributedText: aMicItalic
]

{ #category : #'visit - section' }
MicRealDumper >> visitCode: aCodeBlock [

	stream nextPut: $(.
	self emitClassNameOf: aCodeBlock.
	stream space.
	stream
		nextPutAll: 'new';
		space.
	aCodeBlock hasNonDefaultArguments ifTrue: [ self emitParameters: aCodeBlock ].
	aCodeBlock hasBody ifTrue: [ 
		stream nextPutAll: 'body: '.
		stream
			nextPutAll: '''';
			nextPutAll: aCodeBlock body;
			nextPutAll: '''' ].
	stream nextPut: $)
]

{ #category : #'visit - section' }
MicRealDumper >> visitComment: aComment [

	stream nextPut: $(.
	self emitClassNameOf: aComment.
	stream space.
	stream
		nextPutAll: 'new';
		space.
	stream nextPutAll: 'textElement: '.
	stream nextPutAll: '''Foo'''.
	stream nextPut: $)
]

{ #category : #'visit - section' }
MicRealDumper >> visitFigure: aMicFigure [

	stream nextPut: $(.
	self emitClassNameOf: aMicFigure.
	stream nextPutAll: ' new '.
	aMicFigure hasArguments ifTrue: [ self emitParameters: aMicFigure ].
	stream nextPutAll: 'url: '.
	stream print: aMicFigure reference fullName.
	stream
		space;
		nextPutAll: ';'.
	stream nextPutAll: ' caption: { '.
	aMicFigure captionElements
		do: [ :each | self visit: each ]
		separatedBy: [ stream nextPutAll: ' . ' ].
	stream nextPutAll: '}; yourself) '
]

{ #category : #'visit - section' }
MicRealDumper >> visitHeader: aHeader [
	
	stream nextPut: $(.
	self emitClassNameOf: aHeader.
	stream nextPutAll: ' new '.
	stream nextPutAll: 'level: '.
	aHeader level printOn: stream. 
	stream nextPutAll: '; '.
	stream nextPutAll: 'headerElements: '.
	stream nextPut: ${.
	self visitChildrenOf: aHeader.
	stream nextPut: $}.
	stream nextPut: $)
]

{ #category : #'visit - format' }
MicRealDumper >> visitItalic: aMicItalic [

	self visitAttributedText: aMicItalic
]

{ #category : #'visit - section' }
MicRealDumper >> visitLink: aMicLink [

	stream nextPut: $(.
	self emitClassNameOf: aMicLink.
	stream space.
	stream
		nextPutAll: 'new';
		space.
	stream nextPutAll: 'textElement: '.
	stream nextPut: $[.
	stream nextPutAll: aMicLink substring.
	stream nextPut: $].
	stream nextPut: $(.
	stream nextPutAll: aMicLink url.
	stream nextPut: $)
]

{ #category : #'visit - section' }
MicRealDumper >> visitListItem: anItem [

	stream nextPut: $(.
	self emitClassNameOf: anItem.
	stream space.
	stream
		nextPutAll: 'new';
		space.
	anItem children 
		do: [ :each | each accept: self ]
		separatedBy: [ ''.	'' ].
	stream nextPut: $).
	self flag: #todo.
	"qd on a une liste elle contient des items e.g. une liste de inline model"
]

{ #category : #'visit - format' }
MicRealDumper >> visitMonospace: aMonospace [

	stream nextPut: $(.
	self emitClassNameOf: aMonospace.
	stream space.
	stream
		nextPutAll: 'new';
		space.
	stream nextPutAll: 'textElement: '.
	aMonospace children first accept: self.
	stream nextPut: $)
]

{ #category : #'visit - section' }
MicRealDumper >> visitOrderedList: anOrderedList [

	self emitList: anOrderedList
]

{ #category : #'visit - section' }
MicRealDumper >> visitParagraph: aParagraph [

	stream nextPut: $(.
	self emitClassNameOf: aParagraph.
	stream space.
	stream
		nextPutAll: 'new';
		space.
	stream
		nextPutAll: 'textElements: '. 
	stream nextPut: ${.
	self visitChildrenOf: aParagraph.
	stream nextPut: $}.
	stream nextPut: $)
]

{ #category : #'visit - section' }
MicRealDumper >> visitQuote: aQuote [

	stream nextPut: $(.
	self emitClassNameOf: aQuote.
	stream space.
	stream
		nextPutAll: 'new';
		space.
	stream nextPutAll: 'textElement: '.
	aQuote children first accept: self.
	stream nextPut: $)
]

{ #category : #'visit - section' }
MicRealDumper >> visitRaw: aMicRaw [

	stream nextPut: $(.
	self emitClassNameOf: aMicRaw.
	stream space.
	stream
		nextPutAll: 'new';
		space.
	stream nextPutAll: 'textElement: '.
	aMicRaw do: [ :each | each accept: self ].
	stream nextPut: $)
]

{ #category : #'visit - format' }
MicRealDumper >> visitStrike: aMicItalic [

	self visitAttributedText: aMicItalic
]

{ #category : #'visit - section' }
MicRealDumper >> visitTable: aTable [
	
	stream nextPut: $(.
	self emitClassNameOf: aTable.
	stream space.
	stream
		nextPutAll: 'new';
		space.
	stream nextPutAll: 'string: '.
	self flag: #todo.
	"we should check the API of table and grab the rows."
	aTable children first accept: self.
	stream nextPut: $)
]

{ #category : #'visit - section' }
MicRealDumper >> visitText: aText [
	
	stream nextPut: $(.
	self emitClassNameOf: aText.
	stream space.
	stream
		nextPutAll: 'new';
		space.
	stream
		nextPutAll: 'substring: ';
		nextPutAll: '''';
		nextPutAll: aText substring;
		nextPutAll: ''''.
	stream nextPut: $)
]

{ #category : #'visit - section' }
MicRealDumper >> visitUnorderedList: aUnOrderedList [

	self emitList: aUnOrderedList
]
