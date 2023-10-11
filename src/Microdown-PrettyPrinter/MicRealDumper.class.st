Class {
	#name : 'MicRealDumper',
	#superclass : 'MicrodownVisitor',
	#instVars : [
		'stream'
	],
	#category : 'Microdown-PrettyPrinter',
	#package : 'Microdown-PrettyPrinter'
}

{ #category : 'accessing' }
MicRealDumper >> contents [ 
	^ stream contents
]

{ #category : 'visit - section' }
MicRealDumper >> element: anElement during: aBlock [
	
	stream nextPut: $(.
	self emitClassNameOf: anElement.
	stream space.
	stream
		nextPutAll: 'new';
		space.
	aBlock value.
	stream nextPut: $)
]

{ #category : 'utilities' }
MicRealDumper >> emitClassNameOf: aMicElement [

	stream nextPutAll: aMicElement class asString
]

{ #category : 'visit - section' }
MicRealDumper >> emitList: aList [

	self 
		element: aList 
		during: [
			stream nextPutAll: 'children: { '.
			aList children
				do: [ :each | each accept: self ]
				separatedBy: [ stream nextPutAll: ' . ' ].
	stream nextPutAll: ' }; yourself']
]

{ #category : 'build' }
MicRealDumper >> emitParameters: aCodeBlock [

	stream nextPutAll: 'arguments: { '.
	self parametersPrint: aCodeBlock arguments withoutDefaultValue.
	stream nextPutAll: ' } asDictionary ; '
]

{ #category : 'initialization' }
MicRealDumper >> initialize [

	super initialize.
	stream := MicOutputStream new setStream: (WriteStream on: (String new: 1000)).
]

{ #category : 'build' }
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

{ #category : 'visit - format' }
MicRealDumper >> visit: aMicElement [

	aMicElement accept: self.
	stream contents
]

{ #category : 'visit - section' }
MicRealDumper >> visitAnchor: aMicAnchor [

	self
		element: aMicAnchor 
		during: [
			stream nextPutAll: 'textElement: '.
			stream
				nextPutAll: '" ';
				nextPutAll: aMicAnchor label;
				nextPutAll: ' "' ]
]

{ #category : 'visit - format' }
MicRealDumper >> visitAttributedText: aMicBold [

	self 
		element: aMicBold 
		during: [
			stream nextPutAll: 'textElements: '.
			stream nextPutAll: '{'.
			aMicBold children do: [ :each | each accept: self ] separatedBy: [ stream nextPutAll: ' . '].
			stream nextPutAll: '}' ]
]

{ #category : 'visit - format' }
MicRealDumper >> visitBold: aMicItalic [

	self visitAttributedText: aMicItalic
]

{ #category : 'visit - section' }
MicRealDumper >> visitCode: aCodeBlock [

	self 
		element: aCodeBlock 
		during: [
			aCodeBlock hasNonDefaultArguments ifTrue: [ self emitParameters: aCodeBlock ].
			aCodeBlock hasBody ifTrue: [ 
				stream nextPutAll: 'body: '.
				stream
					nextPutAll: '''';
					nextPutAll: aCodeBlock body;
					nextPutAll: '''' ]]
]

{ #category : 'visit - section' }
MicRealDumper >> visitComment: aComment [
	
	self flag: #argh.
	self 
		element: aComment 
		during: [
			stream nextPutAll: 'textElement: '.
			stream nextPutAll: '''Foo''' ]
]

{ #category : 'visit - section' }
MicRealDumper >> visitFigure: aMicFigure [

	self flag: #arg.
	self 
		element: aMicFigure 
		during: [
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
			stream nextPutAll: '}; yourself' ]
]

{ #category : 'visit - section' }
MicRealDumper >> visitHeader: aHeader [
	
	self 
		element: aHeader 
		during: [
			stream nextPutAll: 'level: '.
			aHeader level printOn: stream. 
			stream nextPutAll: '; '.
			stream nextPutAll: 'headerElements: '.
			stream nextPut: ${.
			self visitChildrenOf: aHeader.
			stream nextPut: $}]
]

{ #category : 'visit - format' }
MicRealDumper >> visitItalic: aMicItalic [

	self visitAttributedText: aMicItalic
]

{ #category : 'visit - section' }
MicRealDumper >> visitLink: aMicLink [

	self 
		element: aMicLink 
		during: [
			stream nextPutAll: 'captionElements: '.
			stream nextPutAll: '{'.
			aMicLink captionElements do: [ :each | self visit: each  ] separatedBy: [ stream nextPutAll: ' . ' ].
			stream nextPutAll: '} ; url: '.
			stream print: aMicLink url.
			stream nextPutAll: ' ; yourself' ]
]

{ #category : 'visit - section' }
MicRealDumper >> visitListItem: anItem [

	self flag: #arg.
	self 
		element: anItem 
		during: [
			anItem children 
				do: [ :each | each accept: self ]
				separatedBy: [ ''.	'' ] ]

]

{ #category : 'visit - format' }
MicRealDumper >> visitMonospace: aMonospace [

	self 
		element: aMonospace 
		during: [
			stream nextPutAll: 'textElement: '.
			aMonospace children first accept: self ]
	
]

{ #category : 'visit - section' }
MicRealDumper >> visitOrderedList: anOrderedList [

	self emitList: anOrderedList
]

{ #category : 'visit - section' }
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

{ #category : 'visit - section' }
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

{ #category : 'visit - section' }
MicRealDumper >> visitRaw: aMicRaw [

	self 
		element: aMicRaw 
		during: [
			stream nextPutAll: 'substring: ' ; print: aMicRaw substring
			]
]

{ #category : 'visit - format' }
MicRealDumper >> visitStrike: aMicItalic [

	self visitAttributedText: aMicItalic
]

{ #category : 'visit - section' }
MicRealDumper >> visitTable: aTable [
	self flag: #arg.
	self 
		element: aTable 
		during: [
				stream nextPutAll: 'string: '.
	aTable children first accept: self ]
]

{ #category : 'visit - section' }
MicRealDumper >> visitText: aText [
	
	self 
		element: aText 
		during: [
			stream
				nextPutAll: 'substring: ';
				nextPutAll: '''';
				nextPutAll: aText substring;
				nextPutAll: '''' ]
]

{ #category : 'visit - section' }
MicRealDumper >> visitUnorderedList: aUnOrderedList [

	self emitList: aUnOrderedList
]
