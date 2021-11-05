Class {
	#name : #MicRealDumper,
	#superclass : #MicrodownVisitor,
	#instVars : [
		'stream'
	],
	#category : #'Microdown-PrettyPrinter'
}

{ #category : #utils }
MicRealDumper >> classOf: aHeader [
	self flag: #todo.
	"il faut utiliser emitClassNameOf:"
	stream
		<< aHeader class name;
		<< ' new '
]

{ #category : #accessing }
MicRealDumper >> contents [ 
	^ stream contents
]

{ #category : #utils }
MicRealDumper >> emitClassNameOf: aMicElement [

	stream nextPutAll: aMicElement class asString
]

{ #category : #initialization }
MicRealDumper >> initialize [

	super initialize.
	stream := MicOutputStream new setStream: (WriteStream on: (String new: 1000)).
]

{ #category : #build }
MicRealDumper >> visit: aMicElement [

	aMicElement accept: self.
	stream contents
]

{ #category : #'visit - section' }
MicRealDumper >> visitAnchor: aAnchor [

	| text |
	self flag: #todo. 
	"Should be (MicAnchor....)"
	text := self emitClassNameOf: aAnchor.
	text := text , ' "' , aAnchor label , '"'.
	^ text
]

{ #category : #'visit - format' }
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
	self flag: #todo.
	"un code peut avoir des arguments:
	
	```language=Pharo|.....
	llkj
	
	donc voir des exemples avec des arguments + ecrire des tests
	Et fixer cette methode. 
	"
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
	self flag: #todo.
	"
	We should not hard the arguments like that.... we should grab the dictionary and iterate... 
	with keysAndValuesDo:...
	"
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

	stream nextPut: $(.
	self emitClassNameOf: aMicItalic.
	stream space.
	stream
		nextPutAll: 'new';
		space.
	stream nextPutAll: 'textElement: '.
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
MicRealDumper >> visitListItem: anItem [

	stream nextPut: $(.
	self emitClassNameOf: anItem.
	stream space.
	stream
		nextPutAll: 'new';
		space.
	stream nextPut: $).
	self flag: #todo.
	"qd on a une liste elle contient des items e.g. une liste de inline model"
]

{ #category : #'visit - format' }
MicRealDumper >> visitMonospace: aMonospace [
	self flag: #todo.
	"a verifier si un monospace contient un micText ou une chaine. Je pense que c'est un micText"
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
MicRealDumper >> visitOrderedList: anOrderedList [

	stream nextPut: $(.
	self emitClassNameOf: anOrderedList.
	stream space.
	stream
		nextPutAll: 'new';
		space.
	stream nextPutAll: 'children: '.
	stream nextPut: ${.
	self visitChildrenOf: anOrderedList.
	stream nextPut: $}.
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

{ #category : #'visit - format' }
MicRealDumper >> visitStrike: aMicStrike [

	stream nextPut: $(.
	self emitClassNameOf: aMicStrike.
	stream space.
	stream
		nextPutAll: 'new';
		space.
	stream nextPutAll: 'textElement: '.
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

	stream nextPut: $(.
	self emitClassNameOf: aUnOrderedList.
	stream space.
	stream
		nextPutAll: 'new';
		space.
	self flag: #todo.
	"This cannot be an addChild: because an orderedList can have multiple children...."
	stream nextPutAll: 'addChild: '.
	aUnOrderedList children do: [ :each | 
		 each accept: self ].
	stream nextPut: $)
]
