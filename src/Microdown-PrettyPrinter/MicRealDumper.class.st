Class {
	#name : #MicRealDumper,
	#superclass : #MicrodownVisitor,
	#instVars : [
		'stream'
	],
	#category : #'Microdown-PrettyPrinter'
}

{ #category : #'visit - section' }
MicRealDumper >> accept: aVisitor [

	^ aVisitor visitRaw: self
]

{ #category : #build }
MicRealDumper >> blockPrint: aMicText [

	self emitClassNameOf: aMicText.
	stream nextPutAll: '"' ; nextPutAll: aMicText substring ; nextPutAll: '"'.
]

{ #category : #'visit - section' }
MicRealDumper >> classOf: aHeader [

	stream
		<< aHeader class name;
		<< ' new '
]

{ #category : #build }
MicRealDumper >> emitClassNameOf: aMicFigure [

	stream nextPutAll: aMicFigure class asString
]

{ #category : #build }
MicRealDumper >> visit: aMicElement [

	aMicElement accept: self.
	stream contents
]

{ #category : #'visit - section' }
MicRealDumper >> visitAnchor: aAnchor [

	| text |
	text := self emitClassNameOf: aAnchor.
	text := text , ' "' , aAnchor label , '"'.
	^ text
]

{ #category : #'visit - section' }
MicRealDumper >> visitBold: aMicBold [

	stream nextPut: $(.
	self emitClassNameOf: aMicBold.
	stream space.
	stream
		nextPutAll: 'new';
		space.
	stream nextPutAll: 'textElement: '.
	aMicBold children first accept: self.
	stream nextPut: $)
]

{ #category : #'visit - section' }
MicRealDumper >> visitCode: aCodeBlock [

	stream nextPut: $(.
	self emitClassNameOf: aCodeBlock.
	stream space.
	stream
		nextPutAll: 'new';
		space.
	stream nextPutAll: 'body: '.
	stream 
		nextPutAll: '''';
		nextPutAll: aCodeBlock body;
		nextPutAll: ''''.
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
	stream space.
	stream nextPutAll: 'parameters: '.
	stream nextPutAll: 'label=figureTest&size=80'.
	stream space.
	stream nextPutAll: 'url: '.
	stream nextPutAll: aMicFigure url originalString.
	stream 
		space;
		nextPutAll: '''';
	   nextPutAll: aMicFigure caption;
		nextPutAll: ''''.
	stream nextPut: $)
]

{ #category : #'visit - section' }
MicRealDumper >> visitHeader: aHeader [

	stream nextPut: $(.
	self emitClassNameOf: aHeader.
	stream nextPutAll: 'level: '.
	stream nextPutAll: 'header: '.
	stream
		nextPutAll: 'new';
		space.
	stream nextPutAll: 'textElement: '.
	aHeader children first accept: self.
	stream nextPut: $)
]

{ #category : #'visit - section' }
MicRealDumper >> visitItalic: aMicItalic [

	stream nextPut: $(.
	self emitClassNameOf: aMicItalic.
	stream space.
	stream
		nextPutAll: 'new';
		space.
	stream nextPutAll: 'string: '.
	aMicItalic children first accept: self.
	stream nextPut: $)
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
	stream nextPutAll: aMicLink url originalString .
	stream nextPut: $)
]

{ #category : #'visit - section' }
MicRealDumper >> visitMonospace: aMonospace [

	stream nextPut: $(.
	self emitClassNameOf: aMonospace.
	stream space.
	stream
		nextPutAll: 'new';
		space.
	stream
		nextPutAll: 'string: ';
		nextPutAll: '''';
		nextPutAll: aMonospace substring;
		nextPutAll: ''''.
	stream nextPut: $)
]

{ #category : #'visit - section' }
MicRealDumper >> visitOrderedList: aOrderedList [

	stream nextPut: $(.
	self emitClassNameOf: aOrderedList.
	stream space.
	stream
		nextPutAll: 'new';
		space.
	stream nextPutAll: 'addChild: '.
	aOrderedList children do: [ :each | each accept: self ].
	stream nextPut: $)
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
		nextPutAll: 'textElement: '. aParagraph children first
		accept: self.
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

	self halt.
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

{ #category : #'visit - section' }
MicRealDumper >> visitStrike: aMicStrike [

	stream nextPut: $(.
	self emitClassNameOf: aMicStrike.
	stream space.
	stream
		nextPutAll: 'new';
		space.
	stream nextPutAll: 'string: '.
	aMicStrike children first accept: self.
	stream nextPut: $)
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
	aTable children first accept: self.
	stream nextPut: $)
]

{ #category : #'visit - section' }
MicRealDumper >> visitText: aMonospace [

	stream nextPut: $(.
	self emitClassNameOf: aMonospace.
	stream space.
	stream
		nextPutAll: 'new';
		space.
	stream
		nextPutAll: 'substring: ';
		nextPutAll: '''';
		nextPutAll: aMonospace substring;
		nextPutAll: ''''.
	stream nextPut: $)
]

{ #category : #'visit - section' }
MicRealDumper >> visitUnorderedList: aUnOrderedList [

	stream nextPut: $(.
	self emitClassNameOf: aUnOrderedList.
	stream space.
	stream
		nextPutAll: 'new';
		space.
	stream nextPutAll: 'addChild: '.
	aUnOrderedList children do: [ :each | 
		 each accept: self ].
	stream nextPut: $)
]
