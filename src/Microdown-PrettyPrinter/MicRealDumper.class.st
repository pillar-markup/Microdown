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

{ #category : #initialization }
MicRealDumper >> contents [ 

	^ stream contents
]

{ #category : #build }
MicRealDumper >> emitClassNameOf: aMicFigure [

	stream nextPutAll: aMicFigure class asString
]

{ #category : #initialization }
MicRealDumper >> initialize [ 
	super initialize.
	stream := (String new: 10000) writeStream
]

{ #category : #build }
MicRealDumper >> parametersPrint: aDictionnary [

	| text lastKey |
	lastKey := aDictionnary keys last.
	text := 'parameters:'.
	aDictionnary keysAndValuesDo: [ :k :v |
		text := text , k ,'=', v.
		k = lastKey 
			ifFalse: [ 
				text := text , '&' ]].
	^ text
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
MicRealDumper >> visitCode: aMicText [

 	self emitClassNameOf: MicCodeBlock
]

{ #category : #'visit - section' }
MicRealDumper >> visitComment: aComment [

	| text |
	text := self emitClassNameOf: aComment.
	text := text , ' "' , aComment text , '"'.
	^ text
]

{ #category : #'visit - section' }
MicRealDumper >> visitFigure: aMicFigure [

	| text |
	text := (self emitClassNameOf: aMicFigure) , String space.
	text := text
	        , (self parametersPrint: aMicFigure arguments asDictionary).
	text := text , ' url:' , aMicFigure url asString.
	text := text , ' "' , aMicFigure substring , '"'.
	^ text
]

{ #category : #'visit - section' }
MicRealDumper >> visitHeader: aHeader [

	stream << '('.
	self classOf: aHeader.
	stream << 'level: '.
	aHeader level printOn: stream.
	stream
		<< '; ';
		<< 'header: '.
	aHeader header printOn: stream.
	stream << ')'
]

{ #category : #'visit - section' }
MicRealDumper >> visitItalic: aMicItalic [

	^ self blockPrint: aMicItalic
]

{ #category : #'visit - section' }
MicRealDumper >> visitLink: aMicLink [

	| text |
	text := self emitClassNameOf: aMicLink.
	text := text , ' url:' , aMicLink url asString , ' "'
	        , aMicLink substring , '"'.
	^ text
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

	^ self emitClassNameOf: aOrderedList
]

{ #category : #'visit - section' }
MicRealDumper >> visitParagraph: aParagraph [

	stream << '('.
	self classOf: aParagraph.
	stream << ')'
]

{ #category : #'visit - section' }
MicRealDumper >> visitQuote: aQuote [

	| text |
	text := self emitClassNameOf: aQuote.
	text := text , ' "' , aQuote text , '"'.
	^ text
]

{ #category : #'visit - section' }
MicRealDumper >> visitRaw: aMicRaw [

	^ self blockPrint: aMicRaw
]

{ #category : #'visit - section' }
MicRealDumper >> visitStrike: aMicStrike [

	^ self blockPrint: aMicStrike
]

{ #category : #'visit - section' }
MicRealDumper >> visitTable: aTable [

	^ self emitClassNameOf: aTable
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
MicRealDumper >> visitUnorderedList: aUnorderedList [

	^ self emitClassNameOf: aUnorderedList
]
